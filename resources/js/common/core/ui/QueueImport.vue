<template>
    <div>
        <a-button type="primary" @click="showModal">
            <CloudDownloadOutlined />
            {{ pageTitle }}
        </a-button>
        <a-modal v-model:open="visible" :title="pageTitle">
            <a-row :gutter="16" class="mb-10">
                <a-col :xs="24" :sm="24" :md="24" :lg="24">
                    <a-typography-paragraph>
                        <ul>
                            <li>
                                <a-typography-link
                                    :href="sampleFileUrl"
                                    target="_blank"
                                >
                                    {{
                                        $t(
                                            "messages.click_here_to_download_sample_file"
                                        )
                                    }}
                                </a-typography-link>
                            </li>
                        </ul>
                    </a-typography-paragraph>
                </a-col>
            </a-row>
            <a-row :gutter="16">
                <a-col :xs="24" :sm="24" :md="24" :lg="24">
                    <a-form layout="vertical">
                        <a-form-item
                            :label="$t('common.file')"
                            name="file"
                            :help="rules.file ? rules.file.message : null"
                            :validateStatus="rules.file ? 'error' : null"
                        >
                            <a-upload
                                :accept="'.xlsx,.csv'"
                                v-model:file-list="fileList"
                                name="file"
                                :before-upload="beforeUpload"
                                :maxCount="1"
                            >
                                <a-button :loading="importProgress.loading">
                                    <template #icon>
                                        <UploadOutlined></UploadOutlined>
                                    </template>
                                    {{ $t("common.upload") }}
                                </a-button>
                            </a-upload>
                        </a-form-item>
                    </a-form>
                </a-col>
                <a-col :xs="24" :sm="24" :md="24" :lg="24">
                    <a-progress
                        :percent="importProgress.percent"
                        :status="importProgress.status"
                    />
                    <a-typography-text type="danger">{{
                        importProgress.message
                    }}</a-typography-text>
                </a-col>
            </a-row>
            <template #footer>
                <a-button
                    type="primary"
                    :loading="importProgress.loading"
                    @click="importItems"
                >
                    {{ $t("common.import") }}
                </a-button>
                <a-button key="back" @click="handleCancel">
                    {{ $t("common.close") }}
                </a-button>
            </template>
        </a-modal>
    </div>
</template>
<script>
import { defineComponent, ref, computed } from "vue";
import { useStore } from "vuex";
import { CloudDownloadOutlined, UploadOutlined } from "@ant-design/icons-vue";
import { notification } from "ant-design-vue";
import { useI18n } from "vue-i18n";
import common from "../../composable/common";
import apiAdmin from "../../composable/apiAdmin";
import UploadFile from "./file/UploadFile.vue";

export default defineComponent({
    props: ["pageTitle", "sampleFileUrl", "context", "bus"],
    emits: ["onUploadSuccess"],
    components: {
        CloudDownloadOutlined,
        UploadFile,
        UploadOutlined,
    },
    setup(props, { emit }) {
        const store = useStore();
        const { appSetting } = common();
        const { addEditFileRequestAdmin, loading, rules } = apiAdmin();
        const { t } = useI18n();
        const fileList = ref([]);
        const visible = ref(false);
        const importProgress = computed(() => store.state.auth.importProgress);

        const beforeUpload = (file) => {
            fileList.value = [...fileList.value, file];
            store.commit("auth/updateImportProgress", {
                percent: 0,
                status: "active",
                message: "",
                loading: false,
            });
            return false;
        };

        const importItems = () => {
            const formData = {};
            if (fileList && fileList.value && fileList.value[0] != undefined) {
                formData.file = fileList.value[0];
                formData.context = props.context;
                formData.bus = props.bus;
            }

            store.commit("auth/updateImportProgress", {
                percent: 0,
                status: "active",
                message: "",
                loading: true,
            });

            console.log('queueu import',formData);
            addEditFileRequestAdmin({
                url: "queue/import",
                data: formData,
                // successMessage: t("messages.imported_successfully"),
                success: (res) => {
                    updateImportProgress(res);
                },
                finished: false,
            });
        };

        const updateImportProgress = (res) => {
            setTimeout(() => {
                store.commit("auth/updateImportProgress", {
                    percent: res.progress.percent,
                    status: "active",
                    message: "",
                    loading: true,
                });

                if (res.finished) {
                    notification.success({
                        placement: appSetting.value.rtl
                            ? "bottomLeft"
                            : "bottomRight",
                        message: t("common.success"),
                        description: t("messages.imported_successfully"),
                    });

                    store.commit("auth/updateImportProgress", {
                        percent: 100,
                        status: "success",
                        message: "",
                        loading: false,
                    });

                    rules.value = {};
                    fileList.value = [];
                    emit("onUploadSuccess");
                } else {
                    axiosAdmin
                        .post("queue/import-progress", {
                            id: res.id,
                            finished: res.finished,
                            cache_key: res.cache_key,
                            progress: res.progress,
                        })
                        .then((progressRes) => {
                            updateImportProgress(progressRes.data);
                        })
                        .catch((err) => {
                            store.commit("auth/updateImportProgress", {
                                percent: res.progress.percent,
                                status: "exception",
                                message: err.data.error.message,
                                loading: false,
                            });
                            fileList.value = [];
                        });
                }
            }, 2000);
        };

        const showModal = () => {
            visible.value = true;
        };

        const handleCancel = (e) => {
            fileList.value = [];
            visible.value = false;
        };

        return {
            fileList,
            rules,
            loading,
            importProgress,

            visible,
            showModal,
            handleCancel,
            importItems,

            beforeUpload,
        };
    },
});
</script>
