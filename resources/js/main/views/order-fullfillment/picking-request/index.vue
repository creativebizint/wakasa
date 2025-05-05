<template>
    <AdminPageHeader>
        <template #header>
            <a-page-header :title="$t(`menu.picking_request`)" class="p-0" />
        </template>
        <template #breadcrumb>
            <a-breadcrumb separator="-" style="font-size: 12px">
                <a-breadcrumb-item>
                    <router-link :to="{ name: 'admin.dashboard.index' }">
                        {{ $t(`menu.dashboard`) }}
                    </router-link>
                </a-breadcrumb-item>
                <a-breadcrumb-item>
                    {{ $t(`menu.picking_request`) }}
                </a-breadcrumb-item>
            </a-breadcrumb>
        </template>
    </AdminPageHeader>

    <admin-page-filters>
        <a-row :gutter="[16, 16]">
            <a-col :xs="24" :sm="24" :md="12" :lg="10" :xl="10">
                <a-space>
                    <template
                        v-if="
                            permsArray.includes('picking_request_create') ||
                            permsArray.includes('admin')
                        "
                    >
                        <a-space>
                            <a-button type="primary" @click="addItem">
                                <PlusOutlined />
                                {{ $t("menu.picking_request") }}
                            </a-button>
                        </a-space>
                    </template>                    
                </a-space>
            </a-col>
            <a-col :xs="24" :sm="24" :md="12" :lg="14" :xl="14">
                <a-row :gutter="[16, 16]" justify="end">
                    <a-col :xs="24" :sm="24" :md="12" :lg="8" :xl="6">
                        <a-input-search
                            style="width: 100%"
                            v-model:value="filters.searchString"
                            show-search
                            :placeholder="
                                $t('common.placeholder_search_text', [
                                    $t('stock.invoice_number'),
                                ])
                            "
                        />
                    </a-col>
                </a-row>
            </a-col>
        </a-row>
    </admin-page-filters>

    <admin-page-table-content>
        <AddEdit
            :addEditType="addEditType"
            :visible="addEditVisible"
            :url="addEditUrl"
            @addEditSuccess="addEditSuccess"
            @closed="onCloseAddEdit"
            :formData="formData"
            :data="viewData"
            :destroyOnClose="true"
            :selectedIds="selectedRowKeys"
        />

        <a-row>
            <a-col :span="24">
                <div class="table-responsive">
                    <a-table
                        :row-selection="rowSelection"
                        :columns="columns"
                        :row-key="(record) => record.xid"
                        :data-source="filteredPickingRequests"
                        :defaultExpandAllRows="true"
                        bordered
                        size="middle"
                        
                    >
                        <template #bodyCell="{ column, text, record }">
                            <template v-if="column.dataIndex === 'action'">
                                <a-button
                                    v-if="
                                        permsArray.includes('categories_edit') ||
                                        permsArray.includes('admin')
                                    "
                                    type="primary"
                                    @click="editItem(record)"
                                    style="margin-left: 4px"
                                >
                                    <template #icon><EditOutlined /></template>
                                </a-button>
                                <a-button
                                    v-if="
                                        (permsArray.includes('categories_delete') ||
                                            permsArray.includes('admin')) &&
                                        (!record.children || record.children.length == 0)
                                    "
                                    type="primary"
                                    @click="showDeleteConfirm(record.xid)"
                                    style="margin-left: 4px"
                                >
                                    <template #icon><DeleteOutlined /></template>
                                </a-button>
                            </template>
                        </template>
                    </a-table>
                </div>
            </a-col>
        </a-row>
    </admin-page-table-content>
</template>
<script>
import { onMounted, ref, createVNode, unref, computed } from "vue";
import fields from "./fields";
import {
    PlusOutlined,
    EditOutlined,
    DeleteOutlined,
    ExclamationCircleOutlined,
} from "@ant-design/icons-vue";
import { Modal, notification } from "ant-design-vue";
import { useStore } from "vuex";
import { useI18n } from "vue-i18n";
import { forEach } from "lodash-es";
import common from "../../../../common/composable/common";
import AddEdit from "./AddEdit.vue";
import AdminPageHeader from "../../../../common/layouts/AdminPageHeader.vue";
import QueueImport from "../../../../common/core/ui/QueueImport.vue";

export default {
    components: {
        PlusOutlined,
        EditOutlined,
        DeleteOutlined,
        ExclamationCircleOutlined,
        AddEdit,
        AdminPageHeader,
        QueueImport,
    },
    setup() {
        const store = useStore();
        const { initData, columns } = fields();
        const { permsArray } = common();
        const { t } = useI18n();
        const sampleFileUrl = window.config.category_sample_file;
        const exportUrl = window.config.category_export_url;

        const detailsVisible = ref(false);
        const viewData = ref({});

        const addEditVisible = ref(false);
        const addEditType = ref("add");
        const addEditUrl = ref("picking-request");
        const allPickingRequests = ref([]);

        const formData = ref({});

        const selectedRowKeys = ref([]);

        const filters = ref({
            searchString: "",
            searchColumn: "invoice_number",
        });

       
        // Computed property for filtered data
        const filteredPickingRequests = computed(() => {
            if (!filters.value.searchString) {
                return allPickingRequests.value; // Return all data if no search string
            }

            return allPickingRequests.value.filter((record) => {
                const value = record[filters.value.searchColumn] || "";
                return value
                    .toString()
                    .toLowerCase()
                    .includes(filters.value.searchString.toLowerCase());
            });
        });

        onMounted(() => {
            getPickingRequest();
        });

        const onRowSelectionChange = (selectedRowKeyValues) => {
            selectedRowKeys.value = selectedRowKeyValues;
        };

        const getCheckboxProps = (record) => {
            return {
                disabled: !record.children || record.children.length == 0 ? false : true,
                name: record.xid,
            };
        };

        const rowSelection = computed(() => {
            return {
                selectedRowKeys: unref(selectedRowKeys),
                onChange: onRowSelectionChange,
                getCheckboxProps: getCheckboxProps,
            };
        });

        const getPickingRequest = () => {
            axiosAdmin
                .get(
                    `picking-request`
                )
                .then((response) => {
                    const pickingRequestsArray = [];
                    allPickingRequests.value = response.data;
                });
        };

        const viewItem = (item) => {
            viewData.value = item;
            detailsVisible.value = true;
        };

        const addItem = () => {
            addEditUrl.value = "picking-request";
            addEditType.value = "add";
            addEditVisible.value = true;
        };

        const addEditSuccess = (id) => {
            // If add action is performed then move page to first
            if (addEditType.value == "add") {
                formData.value = {
                    selected_ids: null,
                    user_id: null,
                };
            }

            getPickingRequest();
            addEditVisible.value = false;
        };

        const onCloseAddEdit = () => {
            formData.value = { ...initData };
            addEditVisible.value = false;
        };

        const editItem = (item) => {
            formData.value = {
                name: item.name,
                slug: item.slug,
                image: item.image,
                image_url: item.image_url,
                parent_id: item.x_parent_id,
                _method: "PUT",
            };

            viewData.value = item;
            addEditUrl.value = `categories/${item.xid}`;
            addEditType.value = "edit";
            addEditVisible.value = true;
        };

        const showDeleteConfirm = (id) => {
            Modal.confirm({
                title: t("common.delete") + "?",
                icon: createVNode(ExclamationCircleOutlined),
                content: t("category.delete_message"),
                centered: true,
                okText: t("common.yes"),
                okType: "danger",
                cancelText: t("common.no"),
                onOk() {
                    axiosAdmin.delete(`categories/${id}`).then(() => {
                        getPickingRequest();
                        notification.success({
                            message: t("common.success"),
                            description: t("category.deleted"),
                        });
                    });
                },
                onCancel() {},
            });
        };

        const showSelectedDeleteConfirm = () => {
            Modal.confirm({
                title: t("common.delete") + "?",
                icon: createVNode(ExclamationCircleOutlined),
                content: t("category.delete_message"),
                centered: true,
                okText: t("common.yes"),
                okType: "danger",
                cancelText: t("common.no"),
                onOk() {
                    const allDeletePromise = [];
                    forEach(selectedRowKeys.value, (selectedRow) => {
                        allDeletePromise.push(
                            axiosAdmin.delete(`categories/${selectedRow}`)
                        );
                    });

                    Promise.all(allDeletePromise).then((successResponse) => {
                        // Update Visible Subscription Modules
                        store.dispatch("auth/updateVisibleSubscriptionModules");

                        getPickingRequest();

                        notification.success({
                            message: t("common.success"),
                            description: t(`category.deleted`),
                            placement: "bottomRight",
                        });
                    });
                },
                onCancel() {},
            });
        };

        return {
            columns,
            addEditSuccess,
            formData,
            editItem,
            addEditVisible,
            addItem,
            onCloseAddEdit,
            addEditUrl,
            addEditType,
            showDeleteConfirm,
            detailsVisible,
            viewItem,
            viewData,
            allPickingRequests,
            permsArray,
            sampleFileUrl,
            getPickingRequest,

            selectedRowKeys,
            rowSelection,
            showSelectedDeleteConfirm,
            exportUrl,
            filteredPickingRequests, // Return the computed property
            filters,
        };
    },
};
</script>
