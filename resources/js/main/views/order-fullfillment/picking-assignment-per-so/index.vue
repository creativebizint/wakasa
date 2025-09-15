<template>
    <AdminPageHeader>
        <template #header>
            <a-page-header :title="$t(`menu.picking_assignment`)" class="p-0" />
        </template>
        <template #breadcrumb>
            <a-breadcrumb separator="-" style="font-size: 12px">
                <a-breadcrumb-item>
                    <router-link :to="{ name: 'admin.dashboard.index' }">
                        {{ $t(`menu.dashboard`) }}
                    </router-link>
                </a-breadcrumb-item>
                <a-breadcrumb-item>
                    {{ $t(`menu.picking_assignment`) }}
                </a-breadcrumb-item>
            </a-breadcrumb>
        </template>
    </AdminPageHeader>

    <admin-page-filters>
        <a-row :gutter="[16, 16]">
            <a-col :xs="24" :sm="24" :md="12" :lg="10" :xl="10">
                <a-space>
                    <a-button
                        v-if="
                            table.selectedRowKeys.length > 0 &&
                            (permsArray.includes('picking_view') ||
                                permsArray.includes('admin'))
                        "
                        type="primary"
                        @click="showAssigntoMeConfirm"
                        danger
                    >
                        <template #icon></template>
                        {{ $t("common.assign to me") }}
                    </a-button>
                </a-space>
            </a-col>
            
            <a-col :xs="24" :sm="24" :md="12" :lg="14" :xl="14">
                <a-row :gutter="[16, 16]" justify="end">
                    <a-col :xs="24" :sm="24" :md="12" :lg="8" :xl="6">
                        <a-input-search
                            style="width: 100%"
                            v-model:value="filters.item_id"
                            show-search
                            :placeholder="
                                $t('common.placeholder_search_text', [
                                    $t('product.item_id'),
                                ])
                            "
                            @search="onItemIdSearch"
                            @change="onItemIdSearch"
                        />
                    </a-col>
                    
<!--                    <a-col :xs="24" :sm="24" :md="12" :lg="12" :xl="8">
                        <a-input-group compact>
                            <a-select
                                style="width: 25%"
                                v-model:value="table.searchColumn"
                                :placeholder="$t('common.select_default_text', [''])"
                            >
                                <a-select-option
                                    v-for="filterableColumn in filterableColumns"
                                    :key="filterableColumn.key"
                                >
                                    {{ filterableColumn.value }}
                                </a-select-option>
                            </a-select>
                            <a-input-search
                                style="width: 75%"
                                v-model:value="table.searchString"
                                show-search
                                @change="onTableSearch"
                                @search="onTableSearch"
                                :loading="table.filterLoading"
                            />
                        </a-input-group>
                    </a-col>-->
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
            :pageTitle="$t('menu.picking_assignment')"
            :successMessage="successMessage"
        />

        <a-row>
            <a-col :span="24">
                <div class="table-responsive">
                    <a-table
                        :row-selection="{
                            selectedRowKeys: table.selectedRowKeys,
                            onChange: onRowSelectChange,
                            getCheckboxProps: (record) => ({
                                disabled: false,
                                name: record.xid,
                            }),
                        }"
                        :columns="columns"
                        :row-key="(record) => record.xid"
                        :data-source="table.data"
                        :pagination="table.pagination"
                        :loading="table.loading"
                        @change="handleTableChange"
                        bordered
                        size="middle"
                    >
                        <template #bodyCell="{ column, text, record }">
                            <template v-if="column.dataIndex === 'image_url'">
                                <a-image :width="32" :src="text" />
                            </template>
                            <template v-if="column.dataIndex === 'name'">
                                {{record.name}}
                            </template>
                            <template v-if="column.dataIndex === 'created_at'">
                                {{formatDate(record.created_at)}}
                            </template>
                            <template v-if="column.dataIndex === 'status'">
                                <div v-if="record.status == '1'">
                                    <a-tag color="yellow">
                                        {{ $t(`common.${"open"}`) }}
                                    </a-tag>
                                </div>
                                <div v-if="record.status == '2'">
                                    <a-tag color="green">
                                        {{ $t(`common.${"complete"}`) }}
                                    </a-tag>
                                </div>
                            </template>
                            <template v-if="column.dataIndex === 'unit_quantity'">
                                {{record.quantity}}
                            </template>
                            <template v-if="column.dataIndex === 'qty_scanned'">
                                {{record.quantity_scanned}}
                            </template>
                            <template v-if="column.dataIndex === 'action'">
                                <a-button
                                    type="primary"
                                    @click="editItem(record)"
                                    style="margin-left: 4px"
                                >
                                    <template #icon><EyeOutlined /></template>
                                </a-button>

                                <!--
                                <a-button
                                    v-if="
                                        permsArray.includes('parts_edit') ||
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
                                        permsArray.includes('parts_delete') ||
                                        permsArray.includes('admin')
                                    "
                                    type="primary"
                                    @click="showDeleteConfirm(record.xid)"
                                    style="margin-left: 4px"
                                >
                                    <template #icon><DeleteOutlined /></template>
                                </a-button>
                                -->
                            </template>
                        </template>
                    </a-table>
                </div>
            </a-col>
        </a-row>
    </admin-page-table-content>
</template>
<script>
import { onMounted,ref } from "vue";
import { PlusOutlined, EditOutlined, DeleteOutlined, EyeOutlined } from "@ant-design/icons-vue";
import fields from "./fields";
import crud from "../../../../common/composable/crud";
import common from "../../../../common/composable/common";
import AddEdit from "./AddEdit.vue";
import AdminPageHeader from "../../../../common/layouts/AdminPageHeader.vue";
import QueueImport from "../../../../common/core/ui/QueueImport.vue";
import { useRoute } from "vue-router";
import { Modal } from 'ant-design-vue'; // Import Modal for confirmation
import apiAdmin from "../../../../common/composable/apiAdmin";

export default {
    components: {
        EyeOutlined,
        PlusOutlined,
        EditOutlined,
        DeleteOutlined,
        AddEdit,
        AdminPageHeader,
        QueueImport,
    },
    setup() {
        const { addEditRequestAdmin, loading, rules } = apiAdmin();
        const { addEditUrl, initData, columns, filterableColumns } = fields();
        const crudVariables = crud();
        const { permsArray,formatDate } = common();
        const sampleFileUrl = window.config.part_sample_file;
        const exportUrl = window.config.part_export_url;
        const route = useRoute();
        const filters = ref({
            item_id: ""
        });
        onMounted(() => {
            setUrlData();
        });
        const onItemIdSearch = () => {
            setUrlData();
        };

        const setUrlData = () => {
            const id = route.params.id;
            crudVariables.tableUrl.value = {
                url: `picking-assignment-item?`,
                extraFilters: {
                    order_id: id,
                    item_id: filters.value.item_id
                },
                order: 'id desc',
                offset:0,
                limit:10,
            };
            
            crudVariables.table.filterableColumns = filterableColumns;

            crudVariables.fetch({
                page: 1,
            });

            crudVariables.crudUrl.value = addEditUrl;
            crudVariables.langKey.value = "part";
            crudVariables.initData.value = { ...initData };
            crudVariables.formData.value = { ...initData };
        };
        
        // Function to show confirmation and handle assignment
        const showAssigntoMeConfirm = () => {
            Modal.confirm({
                title: 'Do you want to assign picking to you?',
                okText: 'Yes',
                okType: 'primary',
                cancelText: 'No',
                onOk() {
                    // Prepare data to send
                    const selectedIds = crudVariables.table.selectedRowKeys;;
                    if (selectedIds.length === 0) {
                        Modal.error({
                            title: 'Error',
                            content: 'Please select at least one item to assign.',
                        });
                        return;
                    }

                    var data = {
                        order_id: route.params.id,
                        item_ids: selectedIds
                    }

            addEditRequestAdmin({
                url: `assign-picking`,
                data: data,
                successMessage: 'ok',
                success: (res) => {
                    console.log(res);
                },
            });
            
            
                },
                onCancel() {
                    // Do nothing or add custom cancel logic
                },
            });
        };

        return {
            columns,
            filterableColumns,
            permsArray,
            ...crudVariables,
            sampleFileUrl,
            setUrlData,
            exportUrl,
            formatDate,
            route,
            filters,
            onItemIdSearch,
            showAssigntoMeConfirm,
        };
    },
};
</script>
