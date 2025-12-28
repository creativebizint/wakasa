# User Session Analysis - Wakasa Application

## Overview
This Laravel application uses a **hybrid authentication system** combining:
- **JWT (JSON Web Tokens)** for API authentication
- **Laravel Sessions** for server-side state management
- **Browser LocalStorage** for client-side state persistence

---

## Session Configuration

### Storage Driver
- **Default**: File-based sessions (`storage/framework/sessions`)
- **Configurable**: Via `SESSION_DRIVER` in `.env` (file, cookie, database, redis, etc.)
- **Location**: `config/session.php`

### Session Lifetime
- **Default**: 120 minutes (2 hours)
- **Configurable**: Via `SESSION_LIFETIME` in `.env`
- **Expire on Close**: `false` (sessions persist after browser closes)

### Session Security
- **Encryption**: Disabled (`encrypt => false`)
- **HTTP Only**: Enabled (prevents JavaScript access)
- **Same-Site**: `lax` (CSRF protection)
- **Secure Cookie**: Configurable via `SESSION_SECURE_COOKIE`

---

## Authentication System

### Guards
1. **`web`** - Session-based (traditional Laravel auth)
2. **`api`** - JWT-based for staff/admin users
3. **`api_front`** - JWT-based for customer/frontend users

### Authentication Flow

#### Login Process (`AuthController::login`)
1. **Session Flush**: All existing sessions are cleared before login
   ```php
   session()->flush();
   ```

2. **JWT Token Generation**: User authenticates via JWT
   ```php
   $token = auth('api')->attempt($credentials);
   ```

3. **Session Storage**: User data is stored in session after successful login
   - User object with relationships (role, permissions, warehouse)
   - Company information
   - Warehouse selection

#### Logout Process (`AuthController::logout`)
1. JWT token is invalidated
2. All sessions are flushed
   ```php
   session()->flush();
   ```

---

## Session Data Storage

### Server-Side (Laravel Sessions)

#### Key Session Variables:

1. **`user`** - Current logged-in user
   - Stored via: `session(['user' => $user])`
   - Retrieved via: `user()` helper function
   - Contains: User model with loaded relationships (role, permissions, warehouse, userWarehouses)
   - Location: `app/Classes/start.php:113-136`

2. **`super_admin`** - Super admin user
   - Stored via: `session(['super_admin' => $user])`
   - Retrieved via: `super_admin()` helper function
   - Location: `app/Classes/start.php:90-105`

3. **`company`** - Current company context
   - Stored via: `session(['company' => $company])`
   - Retrieved via: `company()` helper function
   - Contains: Company model with warehouse, currency, subscription plan
   - Location: `app/Classes/start.php:42-82`

4. **`warehouse`** - Selected warehouse
   - Stored via: `session(['warehouse' => $warehouse])`
   - Retrieved via: `warehouse()` helper function
   - Can be set via HTTP header: `Selected-Warehouse-Xid`
   - Location: `app/Classes/start.php:144-168`

5. **`front_lang_key`** - Frontend language preference
   - Stored via: `session(['front_lang_key' => $lang->key])`
   - Location: `app/Classes/start.php:28-36`

6. **`theme_mode`** - UI theme (light/dark)
   - Stored via: `session(['theme_mode' => $mode])`
   - Location: `app/Http/Controllers/Api/AuthController.php:862`

### Client-Side (Browser LocalStorage)

#### Key LocalStorage Items (Vue.js Store):

1. **`auth_user`** - User object (JSON stringified)
2. **`auth_token`** - JWT token
3. **`expire_key`** - Token expiration timestamp
4. **`app_settings`** - Application settings
5. **`global_settings`** - Global settings
6. **`selected_warehouse`** - Selected warehouse
7. **`all_warehouses`** - All available warehouses
8. **`selected_lang`** - Selected language
9. **`dark_theme`** - Theme preference
10. **`visible_subscription_modules`** - Available modules
11. **`import_progress`** - Import job progress
12. **`tw_progress`** - TW analysis progress
13. **`orders_progress`** - Orders processing progress

**Location**: `resources/js/main/store/auth.js`

---

## Helper Functions

### `user($reset = false)`
- Returns current logged-in user from session
- If `$reset = true`, reloads from database
- Automatically loads relationships: role, role.perms, warehouse, userWarehouses
- Falls back to `auth('api')->user()` if session not set

### `super_admin()`
- Returns super admin user from session
- Falls back to `auth('api')->user()` if session not set

### `company($reset = false)`
- Returns current company context
- Handles both SaaS and non-SaaS modes
- Loads warehouse, currency, subscription plan relationships

### `warehouse($reset = false)`
- Returns selected warehouse
- Can be set via HTTP header `Selected-Warehouse-Xid`
- Falls back to user's default warehouse

---

## Middleware

### Global Middleware
- **`StartSession`** - Starts session on every request
  - Location: `app/Http/Kernel.php:24`
  - Runs on ALL requests (API and web)

### Web Middleware Group
- **`EncryptCookies`** - Encrypts cookies
- **`ShareErrorsFromSession`** - Shares validation errors with views
- **`VerifyCsrfToken`** - CSRF protection

---

## Session Usage Patterns

### 1. Login Flow
```php
// AuthController::login()
session()->flush();  // Clear all sessions
$token = auth('api')->attempt($credentials);
$user = user();  // Automatically stored in session
session(['user' => $user]);
```

### 2. User Data Retrieval
```php
// Helper function automatically checks session first
$user = user();  // Returns from session if available
$user = user(true);  // Force reload from database
```

### 3. Warehouse Selection
```php
// Can be set via HTTP header
$request->header('Selected-Warehouse-Xid')

// Or via API endpoint
session(['warehouse' => $warehouse]);
```

### 4. Logout Flow
```php
// AuthController::logout()
auth('api')->logout();  // Invalidate JWT
session()->flush();  // Clear all session data
```

---

## Session Controller

**Location**: `app/Http/Controllers/Api/SessionController.php`

Currently has a debug method:
```php
public function index()
{
    dd(Session::get(null));  // Dumps all session data
}
```

---

## Important Notes

1. **Session is Global**: `StartSession` middleware runs on ALL requests, including API routes
2. **JWT + Session Hybrid**: Uses JWT for authentication but stores user data in sessions for performance
3. **Session Caching**: User data is cached in session to avoid repeated database queries
4. **Reset Parameter**: Helper functions accept `$reset` parameter to force database reload
5. **Company Scope**: Sessions respect company scoping for multi-tenant functionality
6. **Warehouse Context**: Warehouse can be changed per request via HTTP header

---

## Security Considerations

1. **Session Encryption**: Currently disabled - consider enabling for sensitive data
2. **Session Hijacking**: HTTP-only cookies help, but consider additional security measures
3. **Session Fixation**: Sessions are flushed on login (good practice)
4. **CSRF Protection**: Enabled for web routes
5. **JWT Expiration**: Tokens expire after 180 days (configurable in `respondWithToken`)

---

## Frontend Integration

The Vue.js application stores authentication state in:
- **LocalStorage**: Persistent across browser sessions
- **Vuex Store**: Reactive state management
- **Axios Interceptors**: Automatically adds JWT token to requests

**Token Management**:
- Token stored in `localStorage` as `auth_token`
- Automatically added to axios headers: `Authorization: Bearer {token}`
- Token refresh endpoint: `/auth/refresh-token`

---

## Database Sessions (Optional)

If using database sessions:
- Table: `sessions` (configurable)
- Migration: `php artisan session:table`
- Connection: Configurable via `SESSION_CONNECTION`

---

## Session File Location

Default location: `storage/framework/sessions/`

Files are named with session IDs and contain serialized session data.

