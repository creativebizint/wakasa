<template>
    <router-view v-slot="{ Component, route }">
        <suspense>
            <template #default>
                <div>
                    <a-config-provider
                        :theme="{
                            token: {
                                colorPrimary: appSetting.primary_color,
                                fontFamily: 'Nunito,sans-serif',
                                borderRadius: 4,
                            },
                        }"
                        :direction="appSetting.rtl ? 'rtl' : 'ltr'"
                    >
                        <div class="theme-container">
                            <ThemeProvider :theme="{ ...themeVars }">
                                <LoadingApp v-if="appChecking" />
                                <component v-else :is="Component" />
                            </ThemeProvider>
                        </div>
                    </a-config-provider>
                    
                    <!-- Idle Warning Modal -->
                    <IdleWarningModal
                        v-if="showIdleWarning"
                        :show="showIdleWarning"
                        :countdown="idleCountdown"
                        @stay-logged-in="handleStayLoggedIn"
                        @logout="handleLogout"
                    />
                </div>
            </template>
            <template #fallback> Loading... </template>
        </suspense>
    </router-view>
</template>

<script>
import { watch, onMounted, computed, ref } from "vue";
import { theme } from "ant-design-vue";
import { ThemeProvider } from "vue3-styled-components";
import { themeVars } from "../config/theme/themeVariables";
import { useRoute, useRouter } from "vue-router";
import { useStore } from "vuex";
import common from "../../common/composable/common";
import idleTimeout from "../../common/composable/idleTimeout";
import LoadingApp from "./LoadingApp.vue";
import IdleWarningModal from "../components/common/IdleWarningModal.vue";

export default {
    name: "App",
    components: {
        ThemeProvider,
        LoadingApp,
        IdleWarningModal,
    },
    setup() {
        const route = useRoute();
        const router = useRouter();
        const store = useStore();
        const darkTheme = "dark";
        const { updatePageTitle, appSetting, frontWarehouse, appType } = common();
        const appChecking = computed(() => store.state.auth.appChecking);
        
        // Idle timeout detection - use refs for reactive values
        const showIdleWarning = ref(false);
        const idleCountdown = ref(60);
        
        // Handlers that will be set after idle timeout initializes
        let handleStayLoggedInFn = () => {
            showIdleWarning.value = false;
        };
        let handleLogoutFn = () => {
            store.dispatch("auth/logout");
        };
        
        const handleStayLoggedIn = () => handleStayLoggedInFn();
        const handleLogout = () => handleLogoutFn();
        
        // Initialize idle timeout after component is mounted
        onMounted(() => {
            // Wait for router to be ready
            setTimeout(() => {
                try {
                    const idleTimeoutResult = idleTimeout();
                    // Watch for changes and update refs
                    watch(idleTimeoutResult.showWarning, (val) => {
                        showIdleWarning.value = val;
                    });
                    watch(idleTimeoutResult.countdown, (val) => {
                        idleCountdown.value = val;
                    });
                    // Update handler functions
                    handleStayLoggedInFn = idleTimeoutResult.stayLoggedIn;
                    handleLogoutFn = idleTimeoutResult.logout;
                } catch (error) {
                    console.error('Idle timeout initialization error:', error);
                }
            }, 500);
        });

        onMounted(() => {
            // Automatic token refresh every 30 minutes (before 60 min expiration)
            if (
                router.currentRoute &&
                router.currentRoute.value &&
                router.currentRoute.value.meta?.isFrontStore == undefined
            ) {
                // Refresh token every 30 minutes to prevent expiration
                setInterval(() => {
                    const token = localStorage.getItem('auth_token');
                    if (token && token !== 'null' && token !== 'undefined') {
                        store.dispatch("auth/refreshToken").catch(() => {
                            // If refresh fails, token might be expired
                            // The axios interceptor will handle redirect
                        });
                    }
                }, 30 * 60 * 1000); // 30 minutes
            }
        });

        watch(route, (newVal, oldVal) => {
            // router.push({
            //     name: "admin.setup_app.index",
            // });

            const menuKey =
                typeof newVal.meta.menuKey == "function"
                    ? newVal.meta.menuKey(newVal)
                    : newVal.meta.menuKey;

            updatePageTitle(menuKey.replace("-", "_"));

            // Redirecting if plan is expired
            if (
                appType == "saas" &&
                appSetting.value.is_global == 0 &&
                appSetting.value.status == "license_expired" &&
                newVal &&
                newVal.meta &&
                !(
                    newVal.meta.menuParent == "subscription" ||
                    newVal.name == "admin.login" ||
                    newVal.name == "verify.main"
                )
            ) {
                router.push({
                    name: "admin.subscription.current_plan",
                });
            }
        });

        // watch(frontWarehouse, (newVal, oldVal) => {
        //     if (newVal && newVal.slug) {
        //         store.dispatch("front/updateApp", newVal.slug);
        //     }
        // });

        return {
            theme,
            themeVars,
            darkTheme,
            appChecking,
            appSetting,
            showIdleWarning,
            idleCountdown,
            handleStayLoggedIn,
            handleLogout,
        };
    },
};
</script>

<style>
body {
    background: #f0f2f5 !important;
}
</style>
