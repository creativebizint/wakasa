<template>
    <AdminPageHeader>
        <template #header>
            <a-page-header :title="$t(`menu.stock_in`)" class="p-0" />
        </template>
        <template #breadcrumb>
            <a-breadcrumb separator="-" style="font-size: 12px">
                <a-breadcrumb-item>
                    <router-link :to="{ name: 'admin.dashboard.index' }">
                        {{ $t(`menu.dashboard`) }}
                    </router-link>
                </a-breadcrumb-item>
                <a-breadcrumb-item>
                    {{ $t(`menu.stock_in`) }}
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
                            permsArray.includes('stock_managements_create') ||
                            permsArray.includes('admin')
                        "
                    >
                        <a-space>
                            <QueueImport
                                :pageTitle="$t('stock_in.import')"
                                :sampleFileUrl="sampleFileUrl"
                                context="stock-in"
                                bus="placements"
                                @onUploadSuccess="setUrlData"
                            />
                            <a-typography-link
                                @click="exportExcel"
                                target="_blank"
                            >
                                <a-button type="primary">
                                    <FileExcelOutlined />
                                    {{ $t("stock_in.export") }}
                                </a-button>
                            </a-typography-link>
                        </a-space>
                    </template>
                </a-space>
            </a-col>
            <a-col :xs="24" :sm="24" :md="12" :lg="12" :xl="8">
                <DateRangePicker
                    @dateTimeChanged="
                        (changedDateTime) => {
                            filters.dates = changedDateTime;
                        }
                    "
                    @change="setUrlData"
                />
            </a-col>
            <a-col :xs="24" :sm="24" :md="12" :lg="12" :xl="6">
                <a-row :gutter="[16, 16]" justify="end">
                    <a-input-color compact>
                        <a-input-search
                            style="width: 100%"
                            v-model:value="table.searchString"
                            show-search
                            @change="onTableSearch"
                            @search="onTableSearch"
                            :loading="table.filterLoading"
                        />
                    </a-input-color>
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
                            <template
                                v-if="column.dataIndex === 'placement_date'"
                            >
                                {{ formatDate(record.placement_date) }}
                            </template>
                            <template v-if="column.dataIndex === 'created_by'">
                                {{ record.createdby_name }}
                            </template>

                            <template v-if="column.dataIndex === 'action'">
                                <a-button
                                    v-if="
                                        permsArray.includes(
                                            'stock_managements_edit'
                                        ) || permsArray.includes('admin')
                                    "
                                    type="primary"
                                    @click="editItem(record)"
                                    style="margin-left: 4px"
                                >
                                    <template #icon><EyeOutlined /></template>
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
import { onMounted, ref, reactive } from "vue";
import {
    PlusOutlined,
    EditOutlined,
    DeleteOutlined,
    FileExcelOutlined,
    EyeOutlined,
} from "@ant-design/icons-vue";
import fields from "./fields_in_history";
import crud from "../../../../common/composable/crud";
import common from "../../../../common/composable/common";
import AddEdit from "./AddEdit.vue";
import AdminPageHeader from "../../../../common/layouts/AdminPageHeader.vue";
import DateRangePicker from "../../../../common/components/common/calendar/DateRangePicker.vue";
import QueueImport from "../../../../common/core/ui/QueueImport.vue";

export default {
    components: {
        PlusOutlined,
        EditOutlined,
        DeleteOutlined,
        EyeOutlined,
        FileExcelOutlined,
        AddEdit,
        AdminPageHeader,
        DateRangePicker,
        QueueImport,
    },
    setup() {
        const {
            addEditUrl,
            initData,
            columns,
            filterableColumns,
            hashableColumns,
        } = fields();
        const crudVariables = crud();
        const { formatDate, permsArray } = common();
        const sampleFileUrl = window.config.stock_in_sample_file;
        const exportUrl = window.config.stock_in_export_url;

        const filters = reactive({
            invoice_number: undefined,
            dates: [],
        });
        const brands = ref([]);

        onMounted(() => {
            getInitialData();
            // setUrlData();
        });

        const setUrlData = () => {
            crudVariables.tableUrl.value = {
                url: "product-placement-in-history?",
                filters,
            };
            crudVariables.table.filterableColumns = filterableColumns;

            crudVariables.fetch({
                page: 1,
            });

            crudVariables.crudUrl.value = addEditUrl;
            crudVariables.initData.value = { ...initData };
            crudVariables.formData.value = { ...initData };
            crudVariables.hashableColumns.value = [...hashableColumns];
        };

        const getInitialData = () => {
            const brandsPromise = axiosAdmin.get("brands?limit=10000");

            Promise.all([brandsPromise]).then(
                ([brandsResponse]) => (brands.value = brandsResponse.data)
            );
        };

        const exportExcel = () => {
            var dates =
                typeof filters.dates != "undefined"
                    ? JSON.parse(JSON.stringify(filters.dates))
                    : "";
            var start_date = typeof dates[0] !== "undefined" ? dates[0] : "";
            var end_date = typeof dates[1] !== "undefined" ? dates[1] : "";
            var url =
                exportUrl +
                "?start_date=" +
                start_date +
                "&end_date=" +
                end_date;
            console.log(url);
            window.location = url;
        };

        return {
            columns,
            filterableColumns,
            permsArray,
            ...crudVariables,
            sampleFileUrl,
            setUrlData,
            getInitialData,
            formatDate,

            filters,
            brands,
            exportExcel,
        };
    },
};
</script>
