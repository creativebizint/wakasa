<template>
    <AdminPageHeader>
        <template #header>
            <a-page-header :title="$t(`menu.warehouses`)" class="p-0" />
        </template>
        <template #breadcrumb>
            <a-breadcrumb separator="-" style="font-size: 12px">
                <a-breadcrumb-item>
                    <router-link :to="{ name: 'admin.dashboard.index' }">
                        {{ $t(`menu.dashboard`) }}
                    </router-link>
                </a-breadcrumb-item>
                <a-breadcrumb-item>
                    {{ $t(`menu.parties`) }}
                </a-breadcrumb-item>
                <a-breadcrumb-item>
                    {{ $t(`menu.warehouses`) }}
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
                            permsArray.includes('warehouses_create') ||
                            permsArray.includes('admin')
                        "
                    >
                        <a-button type="primary" @click="addItem">
                            <PlusOutlined />
                            {{ $t("warehouse.add") }}
                        </a-button>
                        <QueueImport
                            :pageTitle="$t('warehouse.import_warehouses')"
                            :sampleFileUrl="sampleFileUrl"
                            context="warehouses"
                            bus="warehouses"
                            @onUploadSuccess="setUrlData"
                        />
                        <a-typography-link :href="exportUrl" target="_blank">
                            <a-button type="primary">
                                <FileExcelOutlined />
                                {{ $t("common.export") }}
                                {{ $t(`menu.warehouses`) }}
                            </a-button>
                        </a-typography-link>
                    </template>
                    <a-button
                        v-if="
                            table.selectedRowKeys.length > 0 &&
                            (permsArray.includes('warehouses_delete') ||
                                permsArray.includes('admin'))
                        "
                        type="primary"
                        @click="showSelectedDeleteConfirm"
                        danger
                    >
                        <template #icon><DeleteOutlined /></template>
                        {{ $t("common.delete") }}
                    </a-button>
                </a-space>
            </a-col>
            <a-col :xs="24" :sm="24" :md="12" :lg="14" :xl="14">
                <a-row :gutter="[16, 16]" justify="end">
                    <a-col :xs="24" :sm="24" :md="16" :lg="12" :xl="10">
                        <a-input-group compact>
                            <a-select
                                style="width: 25%"
                                v-model:value="table.searchColumn"
                                :placeholder="
                                    $t('common.select_default_text', [''])
                                "
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
            :pageTitle="pageTitle"
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
                                disabled:
                                    (permsArray.includes('warehouses_delete') ||
                                        permsArray.includes('admin')) &&
                                    appSetting.x_warehouse_id != record.xid
                                        ? false
                                        : true,
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
                        <template #bodyCell="{ column, record }">
                            <template v-if="column.dataIndex === 'logo'">
                                <a-image :width="48" :src="record.logo_url" />
                            </template>
                            <template v-if="column.dataIndex === 'store_id'">
                                {{ record.store ? record.store.name : "-" }}
                            </template>
                            <template v-if="column.dataIndex === 'code'">
                                {{ record.code }}
                            </template>
                            <template
                                v-if="
                                    column.dataIndex === 'online_store_enabled'
                                "
                            >
                                <OnlineStoreStatus
                                    :status="record.online_store_enabled"
                                    :x_warehouse_id="record.xid"
                                    @success="fetch"
                                />
                                <!-- <template v-if="record.online_store_enabled == 1">
                                    <br />
                                    <router-link
                                        :to="{
                                            name: 'front.homepage',
                                            params: {
                                                warehouse: record.slug,
                                            },
                                        }"
                                        target="_blank"
                                    >
                                        <a-button type="link" class="p-0 mt-5">
                                            {{
                                                $t("warehouse.view_online_store")
                                            }}
                                        </a-button>
                                    </router-link>
                                </template> -->
                            </template>
                            <template v-if="column.dataIndex === 'action'">
                                <a-button
                                    v-if="
                                        permsArray.includes(
                                            'warehouses_edit'
                                        ) || permsArray.includes('admin')
                                    "
                                    type="primary"
                                    @click="editItem(record)"
                                    style="margin-left: 4px"
                                >
                                    <template #icon><EditOutlined /></template>
                                </a-button>
                                <a-button
                                    v-if="
                                        (permsArray.includes(
                                            'warehouses_delete'
                                        ) ||
                                            permsArray.includes('admin')) &&
                                        appSetting.x_warehouse_id != record.xid
                                    "
                                    type="primary"
                                    @click="showDeleteConfirm(record.xid)"
                                    style="margin-left: 4px"
                                >
                                    <template #icon
                                        ><DeleteOutlined
                                    /></template>
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
import { onMounted } from "vue";
import {
    EyeOutlined,
    PlusOutlined,
    EditOutlined,
    DeleteOutlined,
    FileExcelOutlined,
} from "@ant-design/icons-vue";
import crud from "../../../../common/composable/crud";
import common from "../../../../common/composable/common";
import fields from "./fields";
import AddEdit from "./AddEdit.vue";
import AdminPageHeader from "../../../../common/layouts/AdminPageHeader.vue";
import OnlineStoreStatus from "./OnlineStoreStatus.vue";
import QueueImport from "../../../../common/core/ui/QueueImport.vue";

export default {
    components: {
        EyeOutlined,
        PlusOutlined,
        EditOutlined,
        DeleteOutlined,
        AddEdit,
        AdminPageHeader,
        OnlineStoreStatus,
        QueueImport,
        FileExcelOutlined,
    },
    setup() {
        const { permsArray, appSetting } = common();
        const {
            url,
            addEditUrl,
            initData,
            columns,
            filterableColumns,
            hashableColumns,
        } = fields();
        const crudVariables = crud();
        const sampleFileUrl = window.config.warehouse_sample_file;
        const exportUrl = "/warehouse/export";

        onMounted(() => {
            setUrlData();
        });

        const setUrlData = () => {
            crudVariables.tableUrl.value = {
                url,
            };
            crudVariables.table.filterableColumns = filterableColumns;

            crudVariables.fetch({
                page: 1,
            });

            crudVariables.crudUrl.value = addEditUrl;
            crudVariables.langKey.value = "warehouse";
            crudVariables.initData.value = { ...initData };
            crudVariables.formData.value = { ...initData };
            crudVariables.hashableColumns.value = [...hashableColumns];
        };

        return {
            appSetting,
            permsArray,
            columns,
            ...crudVariables,
            filterableColumns,
            sampleFileUrl,
            setUrlData,
            exportUrl,
        };
    },
};
</script>
