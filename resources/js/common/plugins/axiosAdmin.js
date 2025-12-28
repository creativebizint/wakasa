import axios from 'axios';
import { message } from "ant-design-vue";
import store from '../../main/store';
import router from '../../main/router';

var axiosAdmin = axios.create({
    baseURL: window.config.path + '/api/v1'
});

// Axios default headers
axiosAdmin.defaults.headers['Accept'] = 'application/json';
axiosAdmin.defaults.headers.common['X-Requested-With'] = 'XMLHttpRequest';
axiosAdmin.defaults.headers.common['X-CSRF-TOKEN'] = document.head.querySelector('meta[name="csrf-token"]').content;

// Axios jwt token by default
if (localStorage.getItem('auth_token')) {
    axiosAdmin.defaults.headers.common['Authorization'] = 'Bearer ' + localStorage.getItem('auth_token');
}
// Track if we're currently refreshing token to avoid infinite loops
let isRefreshing = false;
let failedQueue = [];

const processQueue = (error, token = null) => {
    failedQueue.forEach(prom => {
        if (error) {
            prom.reject(error);
        } else {
            prom.resolve(token);
        }
    });
    failedQueue = [];
};

// Axios error listener
axiosAdmin.interceptors.response.use(function (response) {
    return response.data;
}, async function (error) {
    const originalRequest = error.config;
    const errorCode = error.response?.status;

    if (errorCode === 401 || (errorCode === 500 && error.response && error.response.data && error.response.data.message && error.response.data.message == 'UNAUTHORIZED EXCEPTION')) {
        // Try to refresh token if we haven't already tried
        if (!originalRequest._retry && !isRefreshing) {
            originalRequest._retry = true;
            isRefreshing = true;

            try {
                const token = localStorage.getItem('auth_token');
                if (token && token !== 'null' && token !== 'undefined') {
                    // Attempt to refresh the token
                    const response = await axiosAdmin.post('/auth/refresh-token', {});

                    if (response && response.token) {
                        const newToken = response.token;
                        localStorage.setItem('auth_token', newToken);
                        axiosAdmin.defaults.headers.common['Authorization'] = 'Bearer ' + newToken;
                        originalRequest.headers['Authorization'] = 'Bearer ' + newToken;
                        
                        // Update store if available
                        if (store && store.commit) {
                            store.commit("auth/updateToken", newToken);
                            if (response.user) {
                                store.commit("auth/updateUser", response.user);
                            }
                            if (response.expires_in) {
                                store.commit("auth/updateExpires", response.expires_in);
                            }
                        }

                        processQueue(null, newToken);
                        isRefreshing = false;

                        // Retry the original request
                        return axiosAdmin(originalRequest);
                    }
                }
            } catch (refreshError) {
                processQueue(refreshError, null);
                isRefreshing = false;
                
                // Refresh failed, redirect to login
                window.location.href = window.config.path + '/admin/login';
                delete window.axiosAdmin.defaults.headers.common.Authorization;
                localStorage.removeItem('auth_token');
                localStorage.setItem('auth_user', null);
                return Promise.reject(refreshError);
            }
        }

        // If we're already refreshing, queue this request
        if (isRefreshing) {
            return new Promise((resolve, reject) => {
                failedQueue.push({ resolve, reject });
            }).then(token => {
                originalRequest.headers['Authorization'] = 'Bearer ' + token;
                return axiosAdmin(originalRequest);
            }).catch(err => {
                return Promise.reject(err);
            });
        }

        // If refresh failed or no token, redirect to login
        window.location.href = window.config.path + '/admin/login';
        delete window.axiosAdmin.defaults.headers.common.Authorization;
        localStorage.removeItem('auth_token');
        localStorage.setItem('auth_user', null);
    } else if (errorCode === 400) {
        var errMessage = error.response.data.error.message;
        message.error(errMessage);
    } else if (errorCode === 403) {
        var errMessage = error.response.data.error.message;
        message.error(errMessage);
    } else if (errorCode === 404) {
        var errMessage = error.response.data.error.message;
        message.error(errMessage);
    } else if (errorCode === 405) {
        store.dispatch("auth/updateApp");

        if (window.config.app_type == 'saas') {
            router.push({
                name: "admin.subscription.current_plan",
            });
        }

    }

    return Promise.reject(error.response);
});

/**
 * Set global so you don't have to import it
 */
window.axiosAdmin = axiosAdmin;
