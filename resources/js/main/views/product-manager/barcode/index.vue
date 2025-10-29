<template>
    <AdminPageHeader>
        <template #header>
            <a-page-header :title="$t(`menu.barcode`)" class="p-0" />
        </template>
        <template #breadcrumb>
            <a-breadcrumb separator="-" style="font-size: 12px">
                <a-breadcrumb-item>
                    <router-link :to="{ name: 'admin.dashboard.index' }">
                        {{ $t(`menu.dashboard`) }}
                    </router-link>
                </a-breadcrumb-item>
                <a-breadcrumb-item>
                    {{ $t(`menu.product_manager`) }}
                </a-breadcrumb-item>
                <a-breadcrumb-item>
                    {{ $t(`menu.barcode`) }}
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
                            permsArray.includes('barcode_create') ||
                            permsArray.includes('admin')
                        "
                    >
                        <a-space>
                            <a-button type="primary" @click="addItem">
                                <PlusOutlined />
                                {{ $t("barcode.add") }}
                            </a-button>
                            <QueueImport
                                :pageTitle="$t('barcode.import')"
                                :sampleFileUrl="sampleFileUrl"
                                context="barcode"
                                bus="master"
                                importUrl="barcode/import"
                                @onUploadSuccess="setUrlData"
                            />
                            <a-typography-link
                                :href="exportUrl"
                                target="_blank"
                            >
                                <a-button type="primary">
                                    <FileExcelOutlined />
                                    {{ $t("common.export") }}
                                    {{ $t("menu.barcode") }}
                                </a-button>
                            </a-typography-link>
                        </a-space>
                    </template>
                    <a-button
                        v-if="
                            table.selectedRowKeys.length > 0 &&
                            (permsArray.includes('barcode_delete') ||
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
                        <a-input-group compact>
                            <a-select
                                style="width: 50%"
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
                                style="width: 50%"
                                v-model:value="table.searchString"
                                show-search
                                @change="onTableSearch"
                                @search="onTableSearch"
                                :loading="table.filterLoading"
                            />
                        </a-input-group>
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
                            <template v-if="column.dataIndex === 'isactive'">
                                {{
                                    record.isactive === -1 
                                    ? $t("common.not_in_use") 
                                    : record.isactive === 0 
                                        ? $t("barcode.inactive") 
                                        : $t("barcode.active")
                                }}
                            </template>
                            <template v-if="column.dataIndex === 'invoice_number'">
                                <template v-if="record.order_item">
                                    <!--<a-typography-link 
                                        @click="
                                            () =>
                                                $router.push({
                                                    name: 'admin.inventory_in.edit',
                                                    params: { id: record.order_item.order.xid },
                                                })
                                        ">
                                        {{ record.order_item.order.invoice_number }}
                                    </a-typography-link>-->
                                    {{ record.order_item.order.invoice_number }}
                                </template>
                            </template>
                            <template v-if="column.dataIndex === 'sales_order_number'">
                                <template v-if="record.order_item_out">
                                    {{ record.order_item_out.order.invoice_number }}
                                </template>
                            </template>
                            <template v-if="column.dataIndex === 'kemasan_jual_qty'">
                                <template v-if="record.item_id">
                                    {{ record.product.kemasan_jual_qty }}
                                </template>
                            </template>
                            <template v-if="column.dataIndex === 'action'">
                                <a-button
                                    v-if="
                                        permsArray.includes('barcode_edit') ||
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
                                        permsArray.includes('barcode_delete') ||
                                        permsArray.includes('admin')
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
import { onMounted } from "vue";
import { PlusOutlined, EditOutlined, DeleteOutlined } from "@ant-design/icons-vue";
import fields from "./fields";
import crud from "../../../../common/composable/crud";
import common from "../../../../common/composable/common";
import AddEdit from "./AddEdit.vue";
import AdminPageHeader from "../../../../common/layouts/AdminPageHeader.vue";
import QueueImport from "../../../../common/core/ui/QueueImport.vue";

export default {
    components: {
        PlusOutlined,
        EditOutlined,
        DeleteOutlined,
        AddEdit,
        AdminPageHeader,
        QueueImport,
    },
    setup() {
        const { addEditUrl, initData, columns, filterableColumns } = fields();
        const crudVariables = crud();
        const { permsArray } = common();
        const sampleFileUrl = window.config.barcode_sample_file;
        const exportUrl = window.config.barcode_export_url;

        onMounted(() => {
            setUrlData();
        });

        const setUrlData = () => {
            crudVariables.tableUrl.value = {
                url: "barcode?fields=id,xid,string,isactive,order_item,item_id,order_item:order{id,xid,invoice_number},order_item_out,order_item_out:order{id,xid,invoice_number},reg_bungkus_id,fk_reg_bungkus_id,nik,box_id,qty_bungkus,reason,comment,product{id,xid,name,kemasan_jual_qty}",
            };
            crudVariables.table.filterableColumns = filterableColumns;

            crudVariables.fetch({
                page: 1,
            });

            crudVariables.crudUrl.value = addEditUrl;
            crudVariables.langKey.value = "barcode";
            crudVariables.initData.value = { ...initData };
            crudVariables.formData.value = { ...initData };
        };

        return {
            columns,
            filterableColumns,
            permsArray,
            ...crudVariables,
            sampleFileUrl,
            setUrlData,
            exportUrl
        };
    },
};
</script>
