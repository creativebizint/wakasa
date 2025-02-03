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
                        :label="$t('shelf_groups.value')"
                        name="name"
                        :help="rules.name ? rules.name.message : null"
                        :validateStatus="rules.name ? 'error' : null"
                        class="required"
                    >
                        <a-input
                            v-model:value="formData.value"
                            :placeholder="
                                $t('common.placeholder_default_text', [$t('shelf_groups.name')])
                            "
                        />
                    </a-form-item>
                </a-col>
                
                <a-col :xs="24" :sm="24" :md="24" :lg="24">
                    <a-form-item
                        :label="$t('shelf_groups.product_placement_floor')"
                        name="$t('shelf_groups.product_placement_floor')"
                    >
                        <a-select
                            v-model:value="
                                formData.product_placement_floor_id
                            "
                            :placeholder="
                                $t('shelf_groups.product_placement_floor')
                            "
                            style="width: 100%"
                        >
                            <a-select-option
                                v-for="floor in floors"
                                :key="floor.xid"
                                :value="floor.xid"
                            >
                                {{ floor.value }}
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
import { defineComponent, ref,onMounted  } from "vue";
import { PlusOutlined, LoadingOutlined, SaveOutlined } from "@ant-design/icons-vue";
import apiAdmin from "../../../../common/composable/apiAdmin";
import Upload from "../../../../common/core/ui/file/Upload.vue";
import common from "../../../../common/composable/common";

export default defineComponent({
    props: [
        "formData",
        "data",
        "visible",
        "url",
        "addEditType",
        "pageTitle",
        "successMessage",
    ],
    components: {
        PlusOutlined,
        LoadingOutlined,
        SaveOutlined,
        Upload,
    },
    setup(props, { emit }) {
        const { addEditRequestAdmin, loading, rules } = apiAdmin();
        const { slugify } = common();
        const floors  = ref([]);
        
        const onSubmit = () => {
            addEditRequestAdmin({
                url: props.url,
                data: props.formData,
                successMessage: props.successMessage,
                success: (res) => {
                    emit("addEditSuccess", res.xid);
                },
            });
        };

        const getFloor = () => {
            const floorsPromise = axiosAdmin.get("floors?limit=1000");
            Promise.all([floorsPromise]).then(
                ([floorsResponse]) => {
                    floors.value = floorsResponse.data;
                }
            );
        }
        
        const onClose = () => {
            rules.value = {};
            emit("closed");
        };

        onMounted(() => {
            getFloor();
        });
        
        return {
            loading,
            rules,
            onClose,
            onSubmit,
            slugify,
            floors,
            drawerWidth: window.innerWidth <= 991 ? "90%" : "45%",
        };
    },
});
</script>
