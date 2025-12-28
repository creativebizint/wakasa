# Idle Timeout Implementation

## Overview
Implemented an idle timeout feature that:
- Detects user inactivity for 10 minutes
- Shows a warning modal with 1-minute countdown
- Automatically logs out if user doesn't respond

## Files Created/Modified

### 1. `resources/js/common/composable/idleTimeout.js`
**Purpose**: Composable function that handles idle detection logic

**Features**:
- Tracks user activity (mouse, keyboard, touch, scroll)
- 10-minute idle timer
- 1-minute warning countdown
- Automatic logout on timeout
- Route-aware (only runs when logged in)

**Usage**:
```javascript
const {
    showWarning,
    countdown,
    stayLoggedIn,
    logout
} = idleTimeout();
```

### 2. `resources/js/main/components/common/IdleWarningModal.vue`
**Purpose**: Modal component that displays idle warning

**Features**:
- Countdown timer display
- "Stay Logged In" button
- "Logout Now" button
- Non-dismissible (user must choose)

### 3. `resources/js/main/views/App.vue`
**Purpose**: Main app component - integrated idle timeout

**Changes**:
- Imported idleTimeout composable
- Imported IdleWarningModal component
- Added modal to template
- Connected event handlers

## How It Works

### Flow:
1. **User Activity Tracking**: Listens to mouse, keyboard, touch, scroll events
2. **10-Minute Timer**: Starts when user becomes inactive
3. **Warning Modal**: Shows after 10 minutes of inactivity
4. **1-Minute Countdown**: User has 60 seconds to respond
5. **Auto Logout**: If no response, user is logged out automatically

### User Actions:
- **"Stay Logged In"**: Resets idle timer, hides modal, continues session
- **"Logout Now"**: Immediately logs out user
- **No Action**: After 60 seconds, automatic logout

## Configuration

### Timeouts (in `idleTimeout.js`):
- **Idle Time**: 10 minutes (600,000 ms)
- **Warning Countdown**: 60 seconds

To change these values, modify:
```javascript
// In idleTimeout.js, line ~40
idleTimer = setTimeout(() => {
    // Change 10 * 60 * 1000 to desired milliseconds
}, 10 * 60 * 1000); // 10 minutes

// In idleTimeout.js, line ~50
countdown.value = 60; // Change to desired seconds
```

## Events Tracked

The following user activities reset the idle timer:
- `mousedown` - Mouse click
- `mousemove` - Mouse movement
- `keypress` - Keyboard input
- `keydown` - Keyboard input
- `scroll` - Page scrolling
- `touchstart` - Touch input
- `click` - Any click

## Route Awareness

Idle detection only runs when:
- User is logged in (has valid token)
- Not on login page
- Not on front store pages
- Not on verification pages

Automatically restarts when navigating between routes.

## Translation Keys

Add these to your language files:

```php
// resources/lang/en/messages.php (or your language file)
'idle_timeout' => [
    'warning_title' => 'Session Timeout Warning',
    'warning_message' => 'You have been idle for 10 minutes. You will be automatically logged out in',
    'countdown_message' => 'Click "Stay Logged In" to continue your session.',
    'stay_logged_in' => 'Stay Logged In',
    'logout_now' => 'Logout Now',
    'confirm_logout_title' => 'Logout Now?',
    'confirm_logout_message' => 'Are you sure you want to logout now?',
],
```

**Note**: The component includes fallback English text if translations are missing.

## Testing

1. **Login** to the application
2. **Wait 10 minutes** without any activity
3. **Modal should appear** with countdown
4. **Click "Stay Logged In"** - modal should disappear, session continues
5. **Or wait 60 seconds** - should auto-logout

## Customization

### Change Idle Time
Edit `idleTimeout.js`:
```javascript
}, 15 * 60 * 1000); // Change to 15 minutes
```

### Change Warning Countdown
Edit `idleTimeout.js`:
```javascript
countdown.value = 120; // Change to 2 minutes
```

### Disable for Specific Routes
Edit `idleTimeout.js` in `shouldRunIdleDetection()`:
```javascript
if (routeName === 'admin.some-route') {
    return false; // Disable for this route
}
```

## Browser Compatibility

Works in all modern browsers that support:
- Event listeners
- setTimeout/setInterval
- Vue 3 Composition API

## Security Considerations

1. **Token Validation**: Checks for valid token before starting
2. **Route Protection**: Only runs on authenticated routes
3. **Clean Logout**: Properly clears tokens and redirects
4. **No Bypass**: Modal cannot be dismissed without action

## Troubleshooting

### Modal not showing:
- Check browser console for errors
- Verify user is logged in
- Check if on excluded route
- Verify event listeners are attached

### Timer not resetting:
- Check if events are being captured
- Verify no JavaScript errors
- Check browser console

### Auto-logout not working:
- Verify logout action in store
- Check router configuration
- Verify token removal

## Future Enhancements

Possible improvements:
- Configurable timeout via settings
- Different timeouts for different user roles
- Activity detection for API calls
- Visual indicator before warning
- Sound notification option

