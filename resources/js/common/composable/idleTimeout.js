import { ref, onMounted, onUnmounted, watch } from "vue";
import { useStore } from "vuex";
import { useRouter, useRoute } from "vue-router";

const idleTimeout = () => {
    const store = useStore();
    const router = useRouter();
    const route = useRoute();
    
    const isIdle = ref(false);
    const showWarning = ref(false);
    const countdown = ref(60); // 1 minute countdown
    const idleTime = ref(0);
    
    let idleTimer = null;
    let warningTimer = null;
    let countdownTimer = null;
    
    // Events to track for user activity
    const events = [
        'mousedown',
        'mousemove',
        'keypress',
        'scroll',
        'touchstart',
        'click',
        'keydown'
    ];
    
    // Reset idle timer on user activity
    const resetIdleTimer = () => {
        if (showWarning.value) {
            // If warning is showing, user is active - hide warning
            clearTimeout(warningTimer);
            clearTimeout(countdownTimer);
            showWarning.value = false;
            countdown.value = 60;
            isIdle.value = false;
        }
        
        // Reset idle timer
        clearTimeout(idleTimer);
        idleTime.value = 0;
        
        // Start new idle timer (10 minutes = 600000 ms)
        idleTimer = setTimeout(() => {
            isIdle.value = true;
            showWarning.value = true;
            countdown.value = 60;
            startCountdown();
        }, 10 * 60 * 1000); // 10 minutes
    };
    
    // Start countdown when warning is shown
    const startCountdown = () => {
        countdownTimer = setInterval(() => {
            countdown.value--;
            
            if (countdown.value <= 0) {
                // Time's up - logout user
                clearInterval(countdownTimer);
                logout();
            }
        }, 1000); // Update every second
    };
    
    // Logout user
    const logout = () => {
        // Clear all timers
        clearTimeout(idleTimer);
        clearTimeout(warningTimer);
        clearInterval(countdownTimer);
        
        // Hide warning
        showWarning.value = false;
        isIdle.value = false;
        
        // Dispatch logout action
        store.dispatch("auth/logout").then(() => {
            // Redirect handled by logout action
        }).catch(() => {
            // Even if logout fails, redirect to login
            router.push({ name: "admin.login" });
        });
    };
    
    // User clicked "Stay Logged In"
    const stayLoggedIn = () => {
        clearTimeout(warningTimer);
        clearInterval(countdownTimer);
        showWarning.value = false;
        countdown.value = 60;
        isIdle.value = false;
        
        // Reset idle timer
        resetIdleTimer();
    };
    
    // Check if should run idle detection
    const shouldRunIdleDetection = () => {
        try {
            // Check if user is logged in
            const token = localStorage.getItem('auth_token');
            if (!token || token === 'null' || token === 'undefined') {
                return false;
            }
            
            // Check if route is available
            if (!route || !route.name) {
                return false;
            }
            
            // Check if we're on login page or front store
            const routeName = route.name;
            const isFrontStore = route.meta?.isFrontStore;
            
            if (routeName === 'admin.login' || 
                routeName === 'verify.main' ||
                isFrontStore) {
                return false;
            }
            
            return true;
        } catch (error) {
            console.error('Error checking idle detection:', error);
            return false;
        }
    };
    
    // Initialize idle detection
    const initIdleDetection = () => {
        if (!shouldRunIdleDetection()) {
            return;
        }
        
        // Add event listeners for user activity
        events.forEach(event => {
            document.addEventListener(event, resetIdleTimer, true);
        });
        
        // Start initial timer
        resetIdleTimer();
    };
    
    // Watch route changes to restart idle detection
    // Only watch if route is available
    if (route && route.name !== undefined) {
        watch(() => route.name, (newRoute, oldRoute) => {
            // Destroy old detection
            destroyIdleDetection();
            
            // Reinitialize if should run
            if (shouldRunIdleDetection()) {
                initIdleDetection();
            }
        });
    }
    
    // Cleanup
    const destroyIdleDetection = () => {
        // Remove event listeners
        events.forEach(event => {
            document.removeEventListener(event, resetIdleTimer, true);
        });
        
        // Clear all timers
        clearTimeout(idleTimer);
        clearTimeout(warningTimer);
        clearInterval(countdownTimer);
    };
    
    onMounted(() => {
        // Initialize on mount
        initIdleDetection();
    });
    
    onUnmounted(() => {
        destroyIdleDetection();
    });
    
    return {
        isIdle,
        showWarning,
        countdown,
        stayLoggedIn,
        logout,
        initIdleDetection,
        destroyIdleDetection
    };
};

export default idleTimeout;

