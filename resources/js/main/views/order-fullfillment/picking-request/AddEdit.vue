<template>
    <a-modal
        :open="visible"
        :closable="false"
        :centered="true"
        :title="pageTitle"
        @ok="onSubmit"
    >
        <a-form layout="vertical">
            <a-row :gutter="16">
                <a-col :xs="24" :sm="24" :md="24" :lg="24">
                    <a-form-item
                        :label="$t('picking_request.user')"
                        name="parent_id"
                        :help="rules.parent_id ? rules.parent_id.message : null"
                        :validateStatus="rules.parent_id ? 'error' : null"
                    >

                        <a-select
                            v-model:value="
                                formData.user_id
                            "
                            :placeholder="
                                $t('picking_request.user')
                            "
                            style="width: 100%"
                        >
                            <a-select-option
                                v-for="user in users"
                                :key="user.xid"
                                :value="user.xid"
                            >
                                {{ user.name }}
                            </a-select-option>
                        </a-select>
                    </a-form-item>
                </a-col>
            </a-row>
            

            
        </a-form>
        <template #footer>
            <a-button key="submit" type="primary" :loading="loading" @click="onSubmit">
                <template #icon>
                    <SaveOutlined />
                </template>
                {{ addEditType == "add" ? $t("common.create") : $t("common.update") }}
            </a-button>
            <a-button key="back" @click="onClose">
                {{ $t("common.cancel") }}
            </a-button>
        </template>
    </a-modal>
</template>
<script>
import { defineComponent, ref, computed, watch } from "vue";
import { PlusOutlined, LoadingOutlined, SaveOutlined } from "@ant-design/icons-vue";
import { useI18n } from "vue-i18n";
import apiAdmin from "../../../../common/composable/apiAdmin";
import Upload from "../../../../common/core/ui/file/Upload.vue";
import common from "../../../../common/composable/common";
import { forEach } from "lodash-es";

export default defineComponent({
    props: ["formData", "data", "visible", "url", "addEditType", "selectedIds"],
    components: {
        PlusOutlined,
        LoadingOutlined,
        SaveOutlined,
        Upload,
    },
    setup(props, { emit }) {
        const { addEditRequestAdmin, loading, rules } = apiAdmin();
        const { getRecursiveCategories, slugify } = common();
        const { t } = useI18n();
        const users = ref([]);

        const getUser = () => {
            const usersPromise = axiosAdmin.get("users?limit=1000&fields=xid,name");
            Promise.all([usersPromise]).then(
                ([usersResponse]) => {
                    users.value = usersResponse.data;
                }
            );
        }

        const pageTitle = computed(() => {
            return props.addEditType == "add" ? t("picking_request.user") : t("picking_request.user");
        });

        const onSubmit = () => {
            console.log("Selected IDs:", props.selectedIds);
            addEditRequestAdmin({
                url: props.url,
                data: {
                        ...props.formData,
                        selected_ids: props.selectedIds,
                        },
                successMessage: props.successMessage,
                success: (res) => {
                    emit("addEditSuccess", res.xid);
                },
            });
        };


        const onClose = () => {
            rules.value = {};
            emit("closed");
        };

        watch(props, (newVal, oldVal) => {
            if (newVal.addEditType == "add") {
                getUser();
            } else {
                getUser(newVal.data.xid);
            }
        });

        return {
            loading,
            rules,
            onClose,
            onSubmit,
            pageTitle,
            users,
            slugify,
        };
    },
});
</script>
