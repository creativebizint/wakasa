<template>
    <a-modal
        v-model:open="visible"
        :title="warningTitle"
        :closable="false"
        :maskClosable="false"
        :keyboard="false"
        :footer="null"
        :width="450"
        centered
    >
        <div class="idle-warning-content">
            <a-alert
                :message="warningMessage"
                type="warning"
                :show-icon="true"
                style="margin-bottom: 20px;"
            />
            
            <div class="countdown-container">
                <a-statistic-countdown
                    :value="countdownValue"
                    :format="'mm:ss'"
                    style="text-align: center;"
                />
                <p class="countdown-text">
                    {{ countdownMessage }}
                </p>
            </div>
            
            <div class="action-buttons">
                <a-button
                    type="primary"
                    size="large"
                    @click="stayLoggedIn"
                    style="margin-right: 10px;"
                >
                    {{ stayLoggedInText }}
                </a-button>
                <a-button
                    size="large"
                    @click="logout"
                >
                    {{ logoutNowText }}
                </a-button>
            </div>
        </div>
    </a-modal>
</template>

<script>
import { computed } from "vue";
import { Modal } from "ant-design-vue";
import { useI18n } from "vue-i18n";

export default {
    name: "IdleWarningModal",
    props: {
        show: {
            type: Boolean,
            default: false
        },
        countdown: {
            type: Number,
            default: 60
        }
    },
    emits: ['stay-logged-in', 'logout'],
    setup(props, { emit }) {
        const { t } = useI18n();
        
        const visible = computed({
            get: () => props.show,
            set: (val) => {
                // Controlled by parent
            }
        });
        
        // Translation strings with fallbacks
        const warningTitle = computed(() => t('idle_timeout.warning_title') || 'Session Timeout Warning');
        const warningMessage = computed(() => t('idle_timeout.warning_message') || 'You have been idle for 10 minutes. You will be automatically logged out in');
        const countdownMessage = computed(() => t('idle_timeout.countdown_message') || 'Click "Stay Logged In" to continue your session.');
        const stayLoggedInText = computed(() => t('idle_timeout.stay_logged_in') || 'Stay Logged In');
        const logoutNowText = computed(() => t('idle_timeout.logout_now') || 'Logout Now');
        
        // Calculate countdown value (current time + countdown seconds)
        const countdownValue = computed(() => {
            return Date.now() + (props.countdown * 1000);
        });
        
        const stayLoggedIn = () => {
            emit('stay-logged-in');
        };
        
        const logout = () => {
            Modal.confirm({
                title: t('idle_timeout.confirm_logout_title') || 'Logout Now?',
                content: t('idle_timeout.confirm_logout_message') || 'Are you sure you want to logout now?',
                onOk: () => {
                    emit('logout');
                }
            });
        };
        
        return {
            visible,
            countdownValue,
            warningTitle,
            warningMessage,
            countdownMessage,
            stayLoggedInText,
            logoutNowText,
            stayLoggedIn,
            logout
        };
    }
};
</script>

<style scoped>
.idle-warning-content {
    padding: 10px 0;
}

.countdown-container {
    text-align: center;
    margin: 30px 0;
}

.countdown-text {
    margin-top: 15px;
    color: #666;
    font-size: 14px;
}

.action-buttons {
    display: flex;
    justify-content: center;
    margin-top: 30px;
}
</style>

