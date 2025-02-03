<template>
    <AdminPageHeader>
        <template #header>
            <a-page-header :title="$t(`menu.stock_management`)" class="p-0" /> {{ $t(`menu.stock_management`) }}
        </template>
        <template #breadcrumb>
            <a-breadcrumb separator="-" style="font-size: 12px">
                <a-breadcrumb-item>
                    <router-link :to="{ name: 'admin.dashboard.index' }">
                        {{ $t(`menu.dashboard`) }}
                    </router-link>
                </a-breadcrumb-item>
                <a-breadcrumb-item>
                    {{ $t(`menu.stock_management`) }}
                </a-breadcrumb-item>                
            </a-breadcrumb>
        </template>
    </AdminPageHeader>

    <admin-page-filters>
        <a-row :gutter="[16, 16]">
            <a-col :span="24">
                <a-space>
                        <router-link
                            :to="{
                                name: `admin.stock_management.in`,
                            }"
                        >
                            <a-button type="primary">
                                <PlusOutlined />
                                {{$t(`stock_management.stock_in`)}}
                            </a-button>
                        </router-link>
                        <router-link
                            :to="{
                                name: `admin.stock_management.out`,
                            }"
                        >
                            <a-button type="primary">
                                <PlusOutlined />
                                {{ $t(`stock_management.stock_out`) }}
                            </a-button>
                        </router-link>
                    
                </a-space>
            </a-col>

            <a-col :xs="24" :sm="24" :md="4" :lg="4" :xl="4">
                {{$t(`stock_management.product`)}}
                <a-input-search
                    v-model:value="table.searchString"
                    show-search
                    @change="onTableSearch"
                    @search="onTableSearch"
                    style="width: 100%"
                    :loading="table.filterLoading"
                    :placeholder="$t('common.search')"
                />
            </a-col>
            <a-col :xs="24" :sm="24" :md="12" :lg="12" :xl="8">
                {{$t(`stock_management.date`)}}
                <DateRangePicker
                    @dateTimeChanged="
                        (changedDateTime) => {
                            formData.dates = changedDateTime;
                        }
                    "
                    @change="setUrlData"
                />
            </a-col>
            <a-col :xs="24" :sm="24" :md="4" :lg="4" :xl="4">
                {{$t(`stock_management.warehouse`)}}
                <a-select
                    v-model:value="warehouseId"
                    :placeholder="
                        $t('common.select_default_text', [$t('stock_management.warehouse')])
                    "
                    :allowClear="true"
                    style="width: 100%"
                    optionFilterProp="title"
                    show-search
                    @change="getFloor"
                >
                    <a-select-option
                        v-for="data in allWarehouses"
                        :key="data.xid"
                        :title="data.name"
                        :value="data.xid"
                    >
                        {{ data.name }}
                    </a-select-option>
                </a-select>
            </a-col>
    
            <a-col :xs="24" :sm="24" :md="4" :lg="4" :xl="4">
                {{$t(`stock_management.floor`)}}
                <a-select
                    v-model:value="formData.floor"
                    :placeholder="
                        $t('common.select_default_text', [$t('stock_management.floor')])
                    "
                    :allowClear="true"
                    style="width: 100%"
                    optionFilterProp="title"
                    show-search
                    @change="getShelfGroup"
                >
                    <a-select-option
                        v-for="data in floors"
                        :key="data.xid"
                        :title="data.floor"
                        :value="data.xid                                                                                                                                    "
                    >
                        {{ data.floor }}
                    </a-select-option>
                </a-select>
            </a-col>
                    
            <a-col :xs="24" :sm="24" :md="4" :lg="4" :xl="4">
                {{$t(`stock_management.shelf_group`)}}
                <a-select
                    v-model:value="formData.shelf_group"
                    :placeholder="
                        $t('common.select_default_text', [$t('stock_management.shelf_group')])
                    "
                    :allowClear="true"
                    style="width: 100%"
                    optionFilterProp="title"
                    show-search
                    @change="getShelfNumber"
                >
                    <a-select-option
                        v-for="data in shelfGroups"
                        :key="data.xid"
                        :title="data.shelf_group"
                        :value="data.xid"
                    >
                        {{ data.shelf_group }}
                    </a-select-option>
                </a-select>
            </a-col>
            <a-col :xs="24" :sm="24" :md="4" :lg="4" :xl="4">
                {{$t(`stock_management.shelf_number`)}}
                <a-select
                    v-model:value="formData.shelf_number"
                    :placeholder="
                        $t('common.select_default_text', [$t('stock_management.shelf_number')])
                    "
                    :allowClear="true"
                    style="width: 100%"
                    optionFilterProp="title"
                    show-search
                    @change="getShelfRow"
                >
                    <a-select-option
                        v-for="data in shelfNumbers"
                        :key="data.xid"
                        :title="data.shelf_number"
                        :value="data.xid"
                    >
                        {{ data.shelf_number }}
                    </a-select-option>
                </a-select>
            </a-col>
            <a-col :xs="24" :sm="24" :md="4" :lg="4" :xl="4">
                {{$t(`stock_management.row`)}}
                <a-select
                    v-model:value="formData.row"
                    :placeholder="
                        $t('common.select_default_text', [$t('stock_management.row')])
                    "
                    :allowClear="true"
                    style="width: 100%"
                    optionFilterProp="title"
                    show-search
                    @change="setUrlData"
                >
                    <a-select-option
                        v-for="data in rows"
                        :key="data.xid"
                        :title="data.row"
                        :value="data.xid"
                    >
                        {{ data.row }}
                    </a-select-option>
                </a-select>
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
                            <template v-if="column.dataIndex === 'product_id'">
                                {{ record.product ? record.product.name : "-" }}
                            </template>
                            <template v-if="column.dataIndex === 'warehouse_id'">
                                {{ record.product ? record.warehouse.name : "-" }}
                            </template>
                        </template>
                    </a-table>
                </div>
            </a-col>
        </a-row>
    </admin-page-table-content>
</template>
<script>
import { onMounted, ref } from "vue";
import { EyeOutlined, PlusOutlined, EditOutlined, DeleteOutlined } from "@ant-design/icons-vue";
import crud from "../../../../common/composable/crud";
import common from "../../../../common/composable/common";
import fields from "./fields";
import AddEdit from "./AddEdit.vue";
import AdminPageHeader from "../../../../common/layouts/AdminPageHeader.vue";
import { useRoute } from "vue-router";
import DateRangePicker from "../../../../common/components/common/calendar/DateRangePicker.vue";

export default {
    components: {
        EyeOutlined,
        PlusOutlined,
        EditOutlined,
        DeleteOutlined,
        AddEdit,
        AdminPageHeader,
        DateRangePicker,
    },
    setup() {
        const { permsArray, appSetting, allWarehouses } = common();
        const { url, addEditUrl, initData, columns, filterableColumns, hashableColumns } = fields();
        const crudVariables = crud();
        const route = useRoute();
        const warehouseId = ref([]);
        const floors = ref([]);
        const shelfGroups = ref([]);
        const shelfNumbers = ref([]);
        const rows = ref([]);
        var filters = ref([]);
        var formData = ref({
            floor: undefined,
            shelf_group: undefined,
            shelf_number: undefined,
            row: undefined,
            dates: [],
        });
        onMounted(() => {
            getInitialData();
            setUrlData();
        });

        const getShelfGroup = () => {
            var floor = formData.value.floor;
            const shelfGroupsPromise = axiosAdmin.get("product-placement/"+floor+"/shelf-group");
            Promise.all([shelfGroupsPromise]).then(
                ([shelfGroupsResponse]) => {
                    shelfGroups.value = shelfGroupsResponse.data;
                }
            );
        }
        const getShelfNumber = () => {
            var shelf_group = formData.value.shelf_group;
            const shelfNumbersPromise = axiosAdmin.get("product-placement/"+shelf_group+"/shelf-number");
            Promise.all([shelfNumbersPromise]).then(
                ([shelfNumbersResponse]) => {
                    shelfNumbers.value = shelfNumbersResponse.data;
                }
            );
        }
        const getShelfRow = () => {
            var shelf_number = formData.value.shelf_number;
            const rowsPromise = axiosAdmin.get("product-placement/"+shelf_number+"/row");
            Promise.all([rowsPromise]).then(
                ([rowsResponse]) => {
                    rows.value = rowsResponse.data;
                }
            );
        }
        
        const getFloor = () => {
            var selectedWarehouseId = warehouseId.value;
            const floorsPromise = axiosAdmin.get("product-placement/floor");
            Promise.all([floorsPromise]).then(
                ([floorsResponse]) => {
                    floors.value = floorsResponse.data;
                }
            );
        }
        
        const setUrlData = () => {
            var selectedWarehouseId = warehouseId.value;
            var shelf_number = formData.value.shelf_number;
            var shelf_group = formData.value.shelf_group;
            var floor = formData.value.floor;
            var row = formData.value.row;            
            var dates = formData.value.dates;            
            var url ="product-placement?fields=id,xid,x_product_id,x_unit_id,x_warehouse_id, floor,shelf_group,shelf_number,row,product{id,xid,name},warehouse{id,xid,name}&type=summary";

            
            var arr = {
                'product_placements.warehouse_id' : selectedWarehouseId,
                'floor' : floor,
                'shelf_group' : shelf_group,
                'shelf_number' : shelf_number,
                'row' : row,
            }
            
            if(JSON.parse(JSON.stringify(dates)).length > 1){
               var date_arr = JSON.parse(JSON.stringify(dates)); 
               var start_date_arr = date_arr[0].split(' '); 
               var end_date_arr = date_arr[1].split(' '); 
               console.log(start_date_arr);
               console.log(end_date_arr);
               var start_date = start_date_arr[0];
               var end_date = end_date_arr[0];
            }
            else{
                var start_date = undefined;
                var end_date = undefined;
            }

            filters = ref(arr);
            crudVariables.tableUrl.value = {
                url,
                filters,
                extraFilters: {
                    start_date: start_date,
                    end_date: end_date,
                }
            };

            crudVariables.table.filterableColumns = filterableColumns;
            crudVariables.table.sorter = { field: "products.name", order: "asc" };
            crudVariables.hashableColumns.value = [...hashableColumns];
            crudVariables.fetch({
                page: 1,
            });
        }

        const getInitialData = () => {

        };

        return {
            
            floors,
            shelfGroups,
            shelfNumbers,
            rows,
            appSetting,
            permsArray,
            columns,
            ...crudVariables,
            filterableColumns,
            warehouseId,
            setUrlData,
            getFloor,
            getShelfGroup,
            getShelfRow,
            getShelfNumber,
            allWarehouses,
            filters,
            formData,
            hashableColumns,
            DateRangePicker
        };
    },
};
</script>
