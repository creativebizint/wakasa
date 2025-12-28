# Session/Token Expiration Fix

## Problem
After 30 minutes of login, the application stops showing data properly and requires logout/login to restart.

## Root Cause
1. **JWT Token TTL**: 60 minutes (configured in `config/jwt.php`)
2. **No Automatic Refresh**: Token refresh mechanism was commented out
3. **Poor Error Handling**: On 401 errors, the app immediately redirects to login without attempting token refresh

## Solution Implemented

### 1. Automatic Token Refresh (App.vue)
- Enabled automatic token refresh every 30 minutes
- Prevents token from expiring during active use
- Runs in background without user interaction

### 2. Smart Axios Interceptor (axiosAdmin.js)
- On 401 errors, attempts to refresh token before redirecting
- Queues failed requests and retries them after token refresh
- Only redirects to login if refresh fails
- Prevents infinite refresh loops

## Changes Made

### File: `resources/js/main/views/App.vue`
```javascript
// Automatic token refresh every 30 minutes (before 60 min expiration)
setInterval(() => {
    const token = localStorage.getItem('auth_token');
    if (token && token !== 'null' && token !== 'undefined') {
        store.dispatch("auth/refreshToken").catch(() => {
            // If refresh fails, token might be expired
            // The axios interceptor will handle redirect
        });
    }
}, 30 * 60 * 1000); // 30 minutes
```

### File: `resources/js/common/plugins/axiosAdmin.js`
- Added token refresh logic in 401 error handler
- Implements request queuing during refresh
- Updates token in localStorage and axios headers
- Updates Vuex store with new token and user data

## How It Works

1. **Proactive Refresh**: Every 30 minutes, token is refreshed automatically
2. **Reactive Refresh**: If token expires (401 error), interceptor attempts refresh
3. **Request Retry**: Failed requests are queued and retried after refresh
4. **Fallback**: If refresh fails, user is redirected to login

## Testing

After these changes:
1. Login to the application
2. Wait 30+ minutes
3. Make API requests - they should work without requiring re-login
4. Token should refresh automatically in background

## Additional Recommendations

### Option 1: Increase JWT TTL (Quick Fix)
Add to `.env`:
```
JWT_TTL=1440  # 24 hours instead of 60 minutes
```

### Option 2: Match Session Lifetime
Set JWT TTL to match session lifetime (120 minutes):
```
JWT_TTL=120
```

### Option 3: Keep Current Fix (Recommended)
The automatic refresh solution is better because:
- More secure (shorter token lifetime)
- Better user experience (seamless refresh)
- Handles edge cases (network issues, etc.)

## Notes

- Token refresh endpoint: `/api/v1/auth/refresh-token`
- Refresh TTL: 20160 minutes (14 days) - allows refresh for 2 weeks
- Session lifetime: 120 minutes (2 hours)
- JWT TTL: 60 minutes (1 hour)

## If Issues Persist

1. Check browser console for errors
2. Verify token refresh endpoint is working: `POST /api/v1/auth/refresh-token`
3. Check network tab to see if refresh requests are being made
4. Verify JWT_SECRET is set in `.env`
5. Clear browser cache and localStorage

