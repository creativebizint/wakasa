# Current User Session Behavior - Runtime Analysis

## Overview
This document describes the **actual runtime behavior** of user sessions in the Wakasa application, based on code analysis.

---

## Session Lifecycle

### 1. Session Initialization
**When**: On EVERY HTTP request (including API requests)
**How**: `StartSession` middleware runs globally
**Location**: `app/Http/Kernel.php:24`

```php
// Runs on ALL requests - web and API
\Illuminate\Session\Middleware\StartSession::class
```

**Behavior**:
- Session is started automatically before any route handler executes
- Session ID is created/retrieved from cookie
- Session data is loaded from storage (file system by default)

---

## 2. Login Flow - Session Behavior

### Step-by-Step Process:

#### A. Pre-Login: Session Flush
```php
// AuthController::login() - Line 220
session()->flush();  // ALL session data is cleared
```

**What happens**:
- All existing session variables are deleted
- This prevents session fixation attacks
- Fresh session is created for new login

#### B. Authentication
```php
// JWT token is generated
$token = auth('api')->attempt($credentials);
```

**Behavior**:
- User is authenticated via JWT (not session-based auth)
- JWT token is returned to client
- Session is NOT used for authentication itself

#### C. Post-Login: Session Population
```php
// respondWithToken() calls user() helper
$user = user();  // This populates session
```

**What `user()` helper does** (Line 113-136 in `start.php`):

1. **Check Session First**:
   ```php
   if (session()->has('user') && $reset == false) {
       return session('user');  // Return cached version
   }
   ```

2. **If Not in Session**:
   ```php
   $user = auth('api')->user();  // Get from JWT
   
   // Load relationships (expensive operation)
   $user = $user->load([
       'role' => function ($query) use ($user) {
           return $query->withoutGlobalScope(CompanyScope::class)
               ->where('company_id', $user->company_id);
       }, 
       'role.perms', 
       'warehouse' => function ($query) use ($user) {
           return $query->withoutGlobalScope(CompanyScope::class)
               ->where('company_id', $user->company_id);
       }, 
       'userWarehouses'
   ]);
   
   // Store in session for future requests
   session(['user' => $user]);
   ```

**Key Behavior**:
- User data is **cached in session** after first load
- Relationships are loaded once and stored
- Subsequent calls to `user()` return cached data (unless `$reset = true`)

#### D. Company Context Loading
```php
// company() helper is called (indirectly via respondWithToken)
$company = company();
```

**Behavior** (`start.php:42-82`):
- Checks session first: `session()->has('company')`
- If not found, loads from database with relationships
- Stores in session: `session(['company' => $company])`
- Different behavior for SaaS vs non-SaaS modes

---

## 3. Runtime Session Access Patterns

### Pattern 1: Lazy Loading with Caching
**Used by**: `user()`, `company()`, `warehouse()`, `super_admin()`

**Behavior**:
```php
// First call - loads from DB and caches
$user = user();  // Database query + relationship loading

// Subsequent calls - returns cached
$user = user();  // No database query, returns from session
$user = user();  // No database query, returns from session

// Force refresh
$user = user(true);  // Bypasses cache, reloads from DB
```

**Performance Impact**:
- ✅ Reduces database queries significantly
- ✅ Faster response times after first load
- ⚠️ Stale data if user is updated elsewhere
- ⚠️ Memory usage (full user object with relationships stored)

### Pattern 2: Direct Session Access
**Used in**: Some controllers directly access session

```php
// PurchaseController.php:150
$user = Session::get('user');

// PickingAssignmentController.php:326, 361, 399
$user = Session::get('user');
```

**Behavior**:
- Direct access without helper function
- No automatic loading if session is empty
- May return `null` if session was cleared

### Pattern 3: Session Check Before Access
**Used by**: Theme mode, language settings

```php
// routes/main.php:19
$themeMode = session()->has('theme_mode') ? session('theme_mode') : 'light';
```

**Behavior**:
- Checks existence before accessing
- Provides default value if not set
- Safe pattern for optional session data

---

## 4. Warehouse Selection Behavior

### Dynamic Warehouse Switching
**Location**: `start.php:144-168`

**Behavior**:
```php
function warehouse($reset = false) {
    // 1. Check session cache first
    if (session()->has('warehouse') && $reset == false) {
        return session('warehouse');
    }
    
    // 2. Check HTTP header for warehouse override
    if ($request->hasHeader('Selected-Warehouse-Xid')) {
        $warehouseId = Common::getIdFromHash($request->header('Selected-Warehouse-Xid'));
        $warehouse = Warehouse::find($warehouseId);
        session(['warehouse' => $warehouse]);  // Cache it
        return session('warehouse');
    }
    
    // 3. Fallback to user's default warehouse
    $user = user($reset);
    if ($user) {
        session(['warehouse' => $user->warehouse]);
        return session('warehouse');
    }
}
```

**Key Behaviors**:
- Warehouse can be changed **per request** via HTTP header
- Header takes precedence over cached session value
- New warehouse is cached in session for subsequent requests
- Falls back to user's default warehouse if no header

**Use Case**: Admin users switching between warehouses without re-login

---

## 5. Session Update Scenarios

### A. User Profile Update
**Location**: `AuthController::user()` - Line 384-395

```php
public function user() {
    $user = auth('api')->user();
    $user = $user->load('role', 'role.perms', 'warehouse', 'userWarehouses');
    
    session(['user' => $user]);  // Updates session
    
    return ApiResponse::make('Data successfull', [
        'user' => $user
    ]);
}
```

**Behavior**:
- Called when user data needs refresh
- Reloads from database
- Updates session cache
- Returns fresh data

### B. Warehouse Change
**Location**: `AuthController::changeAdminWarehouse()` - Line 879-906

```php
public function changeAdminWarehouse(Request $request) {
    // ... validation logic ...
    
    session(['warehouse' => $warehouse]);  // Updates session
    
    return ApiResponse::make('Success', [
        'warehouse' => $warehouse
    ]);
}
```

**Behavior**:
- Updates warehouse in session
- Validates user has access to warehouse
- Persists for subsequent requests

### C. Theme Mode Change
**Location**: `AuthController::changeThemeMode()` - Line 858-877

```php
public function changeThemeMode(Request $request) {
    $mode = $request->has('theme_mode') ? $request->theme_mode : 'light';
    
    session(['theme_mode' => $mode]);  // Updates session
    
    // Also saves to database
    if ($mode == 'dark') {
        $company = company();
        $company->left_sidebar_theme = 'dark';
        $company->save();
        $updatedCompany = company(true);  // Force reload
    }
}
```

**Behavior**:
- Updates session immediately
- Also persists to database
- Forces company reload to get updated data

---

## 6. Logout Flow - Session Behavior

**Location**: `AuthController::logout()` - Line 371-382

```php
public function logout() {
    $request = request();
    
    // 1. Invalidate JWT token
    if (auth('api')->user() && $request->bearerToken() != '') {
        auth('api')->logout();
    }
    
    // 2. Clear ALL session data
    session()->flush();
    
    return ApiResponse::make(__('Session closed successfully'));
}
```

**Behavior**:
- JWT token is invalidated
- **ALL session data is deleted** (not just user data)
- Session file remains but is empty
- Next request will create new session

---

## 7. Session Persistence Behavior

### Session Lifetime
- **Default**: 120 minutes (2 hours) of inactivity
- **Config**: `SESSION_LIFETIME` in `.env`
- **Expire on Close**: `false` (sessions persist after browser closes)

### What Persists:
- ✅ User object (with all relationships)
- ✅ Company context
- ✅ Warehouse selection
- ✅ Theme mode
- ✅ Language preference
- ✅ Super admin flag

### What Doesn't Persist:
- ❌ JWT token (stored in localStorage, not session)
- ❌ Temporary form data (unless explicitly stored)
- ❌ Flash messages (Laravel flash data expires after one request)

---

## 8. Multi-Request Session Behavior

### Request 1: Login
```
1. Session flushed
2. JWT token generated
3. user() called → loads from DB → stores in session
4. company() called → loads from DB → stores in session
5. warehouse() called → loads from DB → stores in session
```

### Request 2: Dashboard Access
```
1. Session loaded (contains user, company, warehouse)
2. user() called → returns from session (no DB query)
3. company() called → returns from session (no DB query)
4. warehouse() called → returns from session (no DB query)
```

### Request 3: API Call with Warehouse Header
```
1. Session loaded
2. warehouse() called → checks header first
3. Header found → loads warehouse from DB → updates session
4. Returns new warehouse
```

### Request 4: Same API Call (no header)
```
1. Session loaded (contains updated warehouse)
2. warehouse() called → returns from session (cached value)
```

---

## 9. Edge Cases and Behaviors

### Case 1: Session Expired but JWT Valid
**Behavior**:
- JWT token still valid
- Session data is empty
- `user()` helper detects empty session
- Reloads user from database using JWT
- Repopulates session

### Case 2: User Updated in Database
**Behavior**:
- Session still contains old data
- `user()` returns cached (stale) data
- **Solution**: Call `user(true)` to force reload
- Or call `/user` API endpoint which updates session

### Case 3: Warehouse Changed by Another User
**Behavior**:
- Session contains old warehouse
- Warehouse header can override per request
- Session is updated with new warehouse
- Subsequent requests use new warehouse

### Case 4: Multiple Tabs/Windows
**Behavior**:
- Same session ID shared across tabs
- Session data is shared
- Warehouse change in one tab affects all tabs
- Logout in one tab clears session for all tabs

### Case 5: Direct Session Access vs Helper
**Problem**:
```php
// Helper function (safe)
$user = user();  // Auto-loads if missing

// Direct access (unsafe)
$user = Session::get('user');  // May be null
```

**Behavior**:
- Helper functions are safer (auto-reload)
- Direct access may return null
- Some controllers use direct access (potential bug)

---

## 10. Performance Characteristics

### Database Query Reduction
**Without Session Caching**:
- Every request: 3-5 queries (user, role, permissions, warehouse, company)
- High database load
- Slower response times

**With Session Caching**:
- First request: 3-5 queries (loads and caches)
- Subsequent requests: 0 queries (uses cache)
- **90%+ reduction in database queries**

### Memory Usage
- Full user object with relationships stored in session
- Company object with relationships
- Warehouse object
- Estimated: 10-50KB per session

### Session File Size
- Serialized PHP objects
- Typically 5-20KB per session file
- Stored in `storage/framework/sessions/`

---

## 11. Security Behaviors

### Session Fixation Protection
✅ **Implemented**: Sessions are flushed on login

### Session Hijacking
⚠️ **Partial**: HTTP-only cookies help, but:
- No IP address validation
- No user agent validation
- Session can be hijacked if cookie is stolen

### CSRF Protection
✅ **Implemented**: For web routes only
- API routes don't use CSRF tokens
- JWT tokens provide API security

### Session Encryption
❌ **Not Enabled**: Session data is stored in plain text (serialized)
- Sensitive data in sessions is readable
- Consider enabling encryption for production

---

## 12. Current Issues/Behaviors

### Issue 1: Stale Data
**Problem**: User data cached in session may become stale
**Impact**: User sees outdated information
**Workaround**: Call `user(true)` or `/user` endpoint to refresh

### Issue 2: Inconsistent Access Patterns
**Problem**: Some code uses helpers, some uses direct session access
**Impact**: Potential null reference errors
**Example**: `PurchaseController` uses `Session::get('user')` directly

### Issue 3: Session on API Routes
**Behavior**: Sessions run on ALL routes (including API)
**Impact**: 
- Unnecessary overhead for stateless API
- Session files created for every API request
- Could use database/redis for better scalability

### Issue 4: No Session Invalidation on User Update
**Problem**: When user is updated elsewhere, session isn't invalidated
**Impact**: Stale user data until session expires or manual refresh

---

## 13. Summary of Current Behavior

### Key Characteristics:
1. **Hybrid Auth**: JWT for authentication, Sessions for caching
2. **Lazy Loading**: Data loaded on-demand and cached
3. **Persistent**: Sessions survive browser close (2 hour lifetime)
4. **Shared State**: Same session across tabs/windows
5. **Performance Optimized**: Reduces DB queries significantly
6. **Dynamic Context**: Warehouse can change per request
7. **Global Middleware**: Sessions run on all requests

### Data Flow:
```
Login → Flush Session → Generate JWT → Load User → Cache in Session
Request → Load Session → Check Cache → Return Cached or Reload
Logout → Invalidate JWT → Flush Session
```

### Caching Strategy:
- **First Access**: Load from DB, store in session
- **Subsequent Access**: Return from session
- **Force Refresh**: Use `$reset = true` parameter
- **Automatic Refresh**: On specific API calls (`/user` endpoint)

---

## Recommendations

1. **Enable Session Encryption** for production
2. **Standardize Access**: Use helper functions everywhere, not direct session access
3. **Add Session Invalidation**: Clear session when user data changes
4. **Consider Redis**: For better scalability and performance
5. **Add IP/User-Agent Validation**: For better security
6. **Document Reset Parameter**: Make it clear when to use `user(true)`

