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
                        :label="$t('shelf_numbers.value')"
                        name="name"
                        :help="rules.name ? rules.name.message : null"
                        :validateStatus="rules.name ? 'error' : null"
                        class="required"
                    >
                        <a-input
                            v-model:value="formData.value"
                            :placeholder="
                                $t('common.placeholder_default_text', [$t('shelf_number.value')])
                            "
                        />
                    </a-form-item>
                </a-col>
                
                <a-col :xs="24" :sm="24" :md="24" :lg="24">
                    <a-form-item
                        :label="$t('shelf_numbers.product_placement_shelf_group')"
                        name="$t('shelf_numbers.product_placement_shelf_group')"
                    >
                        <a-select
                            v-model:value="
                                formData.product_placement_shelf_group_id
                            "
                            :placeholder="
                                $t('shelf_numbers.product_placement_shelf_group')
                            "
                            style="width: 100%"
                        >
                            <a-select-option
                                v-for="shelfGroup in shelfGroups"
                                :key="shelfGroup.xid"
                                :value="shelfGroup.xid"
                            >
                                {{ shelfGroup.value + ' [Floor: '+shelfGroup.product_placement_floor.value+']' }}
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
import { onMounted, ref, defineComponent } from "vue";
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
        const shelfGroups = ref([]);
        
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

        const getShelfGroup = () => {
            const shelfGroupsPromise = axiosAdmin.get("shelf-groups?limit=1000&fields=xid,value,product_placement_floor{xid,value}");
            Promise.all([shelfGroupsPromise]).then(
                ([shelfGroupsResponse]) => {
                    shelfGroups.value = shelfGroupsResponse.data;
                }
            );
        }
        
        const onClose = () => {
            rules.value = {};
            emit("closed");
        };

        onMounted(() => {
            getShelfGroup();
        });
        
        return {
            loading,
            rules,
            onClose,
            onSubmit,
            slugify,
            shelfGroups,
            
            drawerWidth: window.innerWidth <= 991 ? "90%" : "45%",
        };
    },
});
</script>
