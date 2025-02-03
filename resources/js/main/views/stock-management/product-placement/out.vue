<template>
    <AdminPageHeader>
        <template #header>
            <a-page-header :title="$t(`menu.stock_out`)" class="p-0" /> {{ $t(`menu.stock_out`) }}
        </template>
        <template #breadcrumb>
            <a-breadcrumb separator="-" style="font-size: 12px">
                <a-breadcrumb-item>
                    <router-link :to="{ name: 'admin.dashboard.index' }">
                        {{ $t(`menu.dashboard`) }}
                    </router-link>
                </a-breadcrumb-item>
                <a-breadcrumb-item>
                    <router-link :to="{ name: 'admin.stock_management.index' }">
                        {{ $t(`menu.stock_management`) }}
                    </router-link>
                </a-breadcrumb-item>                
                <a-breadcrumb-item>
                    {{ $t(`menu.stock_out`) }}
                </a-breadcrumb-item>                
            </a-breadcrumb>
        </template>
    </AdminPageHeader>

    <admin-page-table-content>
        <a-card class="page-content-container mt-20 mb-20">
            <a-form layout="vertical">
                <a-row :gutter="16">
                    <a-col :span="24">
                        <h2>Stock Lookup</h2>
                    </a-col>
                </a-row>
                <a-row :gutter="16">
                    <a-col :xs="24" :sm="24" :md="4" :lg="4" :xl="4">
                        <a-form-item
                            :label="$t(`stock_out.warehouse`)"
                            name="warehouse_id"
                            :help="
                                rules.warehouse_id ? rules.warehouse_id.message : null
                            "
                            :validateStatus="rules.warehouse_id ? 'error' : null"
                            class="required"
                        >

                            <a-select
                                v-model:value="formData.warehouse_id"
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
                        </a-form-item>
                    </a-col>
                    
                    <a-col :xs="24" :sm="24" :md="4" :lg="4" :xl="4">
                        <a-form-item
                            :label="$t(`stock_management.product`)"
                            name="product"
                            :help="
                                rules.product ? rules.product.message : null
                            "
                            :validateStatus="rules.product ? 'error' : null"
                            class="required"
                        >

                        <a-select
                                    v-model:value="formData.product"
                                    :searchValue="orderSearchTerm"
                                    show-search
                                    :filter-option="false"
                                    :placeholder="$t('product.search_scan_product')"
                                    style="width: 100%"
                                    :not-found-content="
                                        productFetching ? undefined : null
                                    "
                                    @search="
                                        (searchedValue) => {
                                            orderSearchTerm = searchedValue;
                                            findProduct(searchedValue);
                                        }
                                    "
                                    option-label-prop="label"
                                >
                                    <template #suffixIcon><SearchOutlined /></template>
                                    <template v-if="productFetching" #notFoundContent>
                                        <a-spin size="small" />
                                    </template>
                                    <a-select-option
                                        v-for="product in products"
                                        :key="product.xid"
                                        :value="product.xid"
                                        :label="product.name"
                                        :product="product"
                                        @click="searchData"
                                    >
                                        => {{ product.name }}
                                    </a-select-option>
                                </a-select>

                        </a-form-item>
                    </a-col>

<!--                    <a-col :xs="24" :sm="24" :md="2" :lg="2" :xl="2">
                        <a-form-item
                            :label="$t(`stock_out.floor`)"
                            name="floor"
                            :help="
                                rules.floor ? rules.floor.message : null
                            "
                            :validateStatus="rules.floor ? 'error' : null"
                            class="required"
                        >
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
                                :value="data.xid"
                            >
                                {{ data.floor }}
                            </a-select-option>
                        </a-select>
                        </a-form-item>
                    </a-col>

                    <a-col :xs="24" :sm="24" :md="4" :lg="4" :xl="4">
                        <a-form-item
                            :label="$t(`stock_out.shelf_group`)"
                            name="shelf_group"
                            :help="
                                rules.shelf_group ? rules.shelf_group.message : null
                            "
                            :validateStatus="rules.shelf_group ? 'error' : null"
                            class="required"
                        >
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
                        </a-form-item>
                    </a-col>

                    <a-col :xs="24" :sm="24" :md="4" :lg="4" :xl="4">
                        <a-form-item
                            :label="$t(`stock_out.shelf_number`)"
                            name="shelf_number"
                            :help="
                                rules.shelf_number ? rules.shelf_number.message : null
                            "
                            :validateStatus="rules.shelf_number ? 'error' : null"
                            class="required"
                        >
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
                        </a-form-item>
                    </a-col>

                    <a-col :xs="24" :sm="24" :md="2" :lg="2" :xl="2">
                        <a-form-item
                            :label="$t(`stock_out.row`)"
                            name="row"
                            :help="
                                rules.row ? rules.row.message : null
                            "
                            :validateStatus="rules.row ? 'error' : null"
                            class="required"
                        >
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
                        </a-form-item>
                    </a-col>

                    <a-col :xs="24" :sm="24" :md="2" :lg="2" :xl="2">
                        <a-form-item><br>
                            <a-button type="primary" @click="searchData">
                                <SearchOutlined/>
                                {{ $t(`common.search`) }}
                            </a-button>
                        </a-form-item>
                    </a-col>-->
                </a-row>

                <admin-page-table-content>
                    <a-row>
                        <a-col :span="24">
                            <div class="table-responsive">
                                <a-table
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
                                        <template v-if="column.dataIndex === 'item_code'">
                                            <a-button
                                                type="primary"
                                                @click="addItem(record)"
                                                style="margin-left: 4px"
                                            >
                                            {{ record.item_code}}
                                            </a-button>
                                        </template>
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
                    <a-row>
                        <a-button
                        v-if="selectedRowKeys.length > 0"
                        type="primary"
                        @click="addSelectedItem"
                        danger
                    >
                        {{ $t("common.Add Item") }}
                    </a-button>
                    </a-row>
                </admin-page-table-content>
                <hr>
                <a-row :gutter="16">
                    <a-col :span="24">
                        <h2>Stock Out</h2>
                    </a-col>
                </a-row>
                <a-row :gutter="16">
                    <a-col :xs="24" :sm="24" :md="6" :lg="6">
                        <a-form-item
                            :label="$t(`stock_out.invoice_number`)"
                            name="invoice_number"
                            :help="
                                rules.invoice_number ? rules.invoice_number.message : null
                            "
                            :validateStatus="rules.invoice_number ? 'error' : null"
                        >
                            <a-input
                                v-model:value="formData.invoice_number"
                                :placeholder="
                                    $t('common.placeholder_default_text', [
                                        $t('stock_out.invoice_number'),
                                    ])
                                "
                            />
                            <small class="small-text-message">
                                {{ $t("stock_out.invoice_number_blank") }}
                            </small>
                        </a-form-item>
                    </a-col>

                    <a-col :xs="24" :sm="24" :md="6" :lg="6">
                        <a-form-item
                            :label="$t(`stock_out.placement_date`)"
                            name="placement_date"
                            :help="rules.placement_date ? rules.placement_date.message : null"
                            :validateStatus="rules.placement_date ? 'error' : null"
                            class="required"
                        >
                            <DateTimePicker
                                :dateTime="formData.placement_date"
                                @dateTimeChanged="
                                    (changedDateTime) =>
                                        (formData.placement_date = changedDateTime)
                                "
                            />
                        </a-form-item>
                    </a-col>
                </a-row>
                <a-row :gutter="16">
                    <a-col :xs="24" :sm="24" :md="24" :lg="24">
                        <a-table
                            :row-key="(record) => record.xid"
                            :dataSource="selectedProducts"
                            :columns="orderItemColumns"
                            :pagination="false"
                        >
                            <template #bodyCell="{ column, record }">
                                <template v-if="column.dataIndex === 'item_code'">
                                    {{ record.item_code }} <br />
                                </template>
                                <template v-if="column.dataIndex === 'name'">
                                    {{ record.name }}
                                </template>
                                <template v-if="column.dataIndex === 'brand'">
                                    {{ record.brand_name ? record.brand_name : '-' }}
                                </template>
                                <template v-if="column.dataIndex === 'floor'">
                                    {{ record.floor ? record.floor : '-' }}
                                </template>
                                <template v-if="column.dataIndex === 'shelf_group'">
                                    {{ record.shelf_group ? record.shelf_group : '-' }}
                                </template>
                                <template v-if="column.dataIndex === 'shelf_number'">
                                    {{ record.shelf_number ? record.shelf_number : '-' }}
                                </template>
                                <template v-if="column.dataIndex === 'row'">
                                    {{ record.row ? record.row : '-' }}
                                </template>
                                <template v-if="column.dataIndex === 'action'">
                                    <a-button
                                        type="primary"
                                        @click="showDeleteConfirm(record)"
                                        style="margin-left: 4px"
                                    >
                                        <template #icon><DeleteOutlined /></template>
                                    </a-button>
                                </template>
                            </template>
                            <template #summary>
                                <a-table-summary-row>
                                    <a-table-summary-cell
                                        :col-span="4"
                                    ></a-table-summary-cell>
                                    <a-table-summary-cell>
                                        {{ $t("product.total_qty") }}
                                    </a-table-summary-cell>
                                    <a-table-summary-cell :col-span="2">
                                        {{
                                            allSelectedItems.length
                                        }}
                                    </a-table-summary-cell>
                                </a-table-summary-row>
                            </template>
                        </a-table>
                    </a-col>
                </a-row>

                <a-row :gutter="16" class="mt-30">
                    <a-col :xs="24" :sm="24" :md="16" :lg="16">
                        <a-row :gutter="16">
                            <a-col :xs="24" :sm="24" :md="24" :lg="24">
                                <a-form-item
                                    :label="$t('stock.notes')"
                                    name="notes"
                                    :help="rules.notes ? rules.notes.message : null"
                                    :validateStatus="rules.notes ? 'error' : null"
                                >
                                    <a-textarea
                                        v-model:value="formData.notes"
                                        :placeholder="$t('stock.notes')"
                                        :auto-size="{ minRows: 2, maxRows: 3 }"
                                    />
                                </a-form-item>
                            </a-col>
                        </a-row>
                    </a-col>
                </a-row>
                <a-row :gutter="16" class="mt-20 mb-20">
                    <a-button
                        type="primary"
                        :loading="loading"
                        @click="onSubmit"
                        block
                    >
                        <template #icon> <SaveOutlined /> </template>
                        {{ $t("common.save") }}
                    </a-button>
                </a-row>
            </a-form>
        </a-card>
    </admin-page-table-content>
</template>
<script>
import { onMounted, ref, toRefs, unref, computed } from "vue";
import {
    EyeOutlined,
    PlusOutlined,
    EditOutlined,
    DeleteOutlined,
    ExclamationCircleOutlined,
    SearchOutlined,
    SaveOutlined,
    LoadingOutlined,
} from "@ant-design/icons-vue";
import { useI18n } from "vue-i18n";
import { useRouter } from "vue-router";
import apiAdmin from "../../../../common/composable/apiAdmin";
import stockManagement from "./stockManagement";
import crud from "../../../../common/composable/crud";
import common from "../../../../common/composable/common";
import fields_out from "./fields_out";
import fields from "./fields";
import TaxAddButton from "../../settings/taxes/AddButton.vue";
import WarehouseAddButton from "../../settings/warehouses/AddButton.vue";
import ProductAddButton from "../../product-manager/products/AddButton.vue";
import DateTimePicker from "../../../../common/components/common/calendar/DateTimePicker.vue";
import AdminPageHeader from "../../../../common/layouts/AdminPageHeader.vue";
import UserSearch from "./UserSearch.vue";
import { forEach } from "lodash-es";
export default {
    components: {
        EyeOutlined,
        PlusOutlined,
        EditOutlined,
        DeleteOutlined,
        ExclamationCircleOutlined,
        SearchOutlined,
        SaveOutlined,
        LoadingOutlined,

        TaxAddButton,
        WarehouseAddButton,
        ProductAddButton,
        DateTimePicker,
        AdminPageHeader,
        UserSearch,
    },
    setup() {
        const { addEditRequestAdmin, loading, rules } = apiAdmin();
        const { url, addEditUrl, initData, columns, filterableColumns, hashableColumns } = fields();
        const {
            appSetting,
            formatAmount,
            formatAmountCurrency,
            taxTypes,
            orderStatus,
            purchaseOrderStatus,
            salesOrderStatus,
            salesReturnStatus,
            purchaseReturnStatus,
            permsArray,
            selectedWarehouse,
            
            //* ADDENDUM
            allWarehouses,
        } = common();
        const { orderItemColumns } = fields_out();
        const warehouseId = ref([]);
        const floors = ref([]);
        const shelfGroups = ref([]);
        const shelfNumbers = ref([]);
        const rows = ref([]);
        const crudVariables = crud();
        const {
            state,
            orderType,
            orderPageObject,
            selectedProducts,
            formData,
            productsAmount,
            taxes,

            recalculateValues,
            findProduct,
            fetchProducts,
            fetchProductsIn,
            searchValueSelected,
            quantityChanged,
            recalculateFinalTotal,
            taxChanged,
            editItem,

            // Add Edit
            addEditVisible,
            addEditFormData,
            addEditFormSubmitting,
            addEditRules,
            addEditPageTitle,
            onAddEditSubmit,
            onAddEditClose,

            checkProductInChanged,
        } = stockManagement();
        const { t } = useI18n();
        const warehouses = ref([]);
        const allUnits = ref([]);
        const router = useRouter();
        const allOrderStatus = ref([]);
        const taxUrl = "taxes?limit=10000";
        const unitUrl = "units?limit=10000";
        const warehouseUrl = `warehouses?limit=10000`;
        const warehouseSearchLabelPrefix = ref([]);
        const selectedRowKeys = ref([]);
        const allSelectedItems = [];
        const selectedValue = [];
        const selectedProducts2 = ref([]);
        const selectedProductIds = ref([]);
        const filters = ref({
            floor: undefined,
            shelf_group: undefined,
            shelf_number: undefined,
            row: undefined,
        });
        onMounted(() => {
            orderType.value = 'product-placement';
            warehouseSearchLabelPrefix.value = "from";
            searchData();
        });

        const addItem = (record) => {
            var product = JSON.parse(JSON.stringify(record));
            if(!allSelectedItems.includes(product.xid)){
                product.name = product.product.name;
                allSelectedItems.push(product.xid);
                console.log(product);
                searchValueSelected('', { product: product });
            }
            else{
                alert('already add');
            }
        };
        
        const onRowSelectionChange = (selectedRowKeyValues) => {
            selectedRowKeys.value = selectedRowKeyValues;
            
        };

        const getCheckboxProps = (record) => {
            console.log(JSON.parse(JSON.stringify(record)));
        };

        const addSelectedItem = () => {
            console.log('ss',selectedRowKeys);
            forEach(selectedRowKeys.value, (selectedRow) => {
                if(allSelectedItems.indexOf(selectedRow) < 0){
                    allSelectedItems.push(
                        selectedRow
                    );
                }
            });
        };
        
        const rowSelection = computed(() => {
            return {
                selectedRowKeys: unref(selectedRowKeys),
                onChange: onRowSelectionChange,
                getCheckboxProps: getCheckboxProps,
            };
        });
        
        const showDeleteConfirm = (product) => {
            console.log('bb',product);
            // Delete selected product and rearrange SN
            const newResults = [];
            let counter = 1;
            selectedProducts.value.map((selectedProduct) => {
console.log('111',selectedProduct);
                if (product.item_id && product.item_id != "" && product.item_id != null && product.item_id == selectedProduct.item_id && selectedProduct.item_id != null) {
                    removedOrderItemsIds.value = [...removedOrderItemsIds.value, selectedProduct.item_id];
                }

                if (selectedProduct.xid != product.xid) {
                    newResults.push({
                        ...selectedProduct
                    });

                    counter++;
                }
            });
            selectedProducts.value = newResults;

            // Remove deleted product id from lists
            var index = allSelectedItems.indexOf(product.xid);
            if (index !== -1) {
              allSelectedItems.splice(index, 1);
            }
            const filterProductIdArray = selectedProductIds.value.filter((newId) => {
                return newId != product.xid;
            });
            console.log(filterProductIdArray);
            selectedProductIds.value = filterProductIdArray;
            console.log(selectedProductIds);
            selectedProducts.value.map((selectedProduct) => {
                totalqty = allSelectedItems.length;
            });
        };
    
        const onSubmit = () => {

            const newFormDataObject = {
                ...formData.value,
                order_type: 'product-placement',
                total: formData.value.subtotal,
                total_items: selectedProducts.value.length,
                product_items: selectedProducts.value,
            };

            addEditRequestAdmin({
                url: 'product-placement-out',
                data: newFormDataObject,
                successMessage: t(`stock_out.created`),
                success: (res) => {
                    router.push({
                        name: `admin.stock_management.index`,
                    });
                },
                error:(res)=>{
                    if(typeof res.error.details !== 'undefined'){
                        var rows = document.querySelectorAll("tr[data-row-key='"+res.error.details.xid+"']");
                        rows.forEach(function(row) {
                            row.style.backgroundColor = "#ffAAAA"; 
                        });
                    }
                }
            });
        };

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
            var selectedWarehouseId = formData.value.warehouse_id;
            var shelf_number = formData.value.shelf_number;
            var shelf_group = formData.value.shelf_group;
            var floor = formData.value.floor;
            var row = formData.value.row; 
            
            if(typeof selectedWarehouseId !== 'object' && typeof selectedWarehouseId !== '' && typeof selectedWarehouseId !== 'undefined'){
                const floorsPromise = axiosAdmin.get("product-placement/floor");
                const shelfGroupsPromise = axiosAdmin.get("product-placement/"+selectedWarehouseId+"/shelf-group");
                const shelfNumbersPromise = axiosAdmin.get("product-placement/"+selectedWarehouseId+"/shelf-number");
                const rowsPromise = axiosAdmin.get("product-placement/"+selectedWarehouseId+"/row");

                Promise.all([floorsPromise, shelfGroupsPromise, shelfNumbersPromise, rowsPromise]).then(
                    ([floorsResponse, shelfGroupsResponse, shelfNumbersResponse, rowsResponse]) => {
                        floors.value = floorsResponse.data;
                        shelfGroups.value = shelfGroupsResponse.data;
                        shelfNumbers.value = shelfNumbersResponse.data;
                        rows.value = rowsResponse.data;
                    }
                );
            }
            
        }

        const searchData = () => {
            var url ="product-placement?fields=id,xid,x_product_id,x_unit_id,x_warehouse_id, floor,shelf_group,shelf_number,row,product{id,xid,name,x_brand_id,brand_id},warehouse{id,xid,name}";

            var filters = ref({
                'product_placements.warehouse_id' : formData.value.warehouse_id,
                product_id: formData.value.product,                
            });
            crudVariables.tableUrl.value = {
                url,
                filters,
            };

            crudVariables.table.filterableColumns = filterableColumns;
            crudVariables.table.sorter = { field: "products.name", order: "asc" };
            crudVariables.initData.value = { ...initData };
            crudVariables.formData.value = { ...initData };
            crudVariables.hashableColumns.value = [...hashableColumns];
            if(typeof formData.value.warehouse_id !== 'undefined' && typeof formData.value.product !== 'undefined'){
                crudVariables.fetch({
                    page: 1,
                });  
            }
        }

        const unitAdded = () => {
            axiosAdmin.get(unitUrl).then((response) => {
                allUnits.value = response.data;
            });
        };

        const taxAdded = () => {
            axiosAdmin.get(taxUrl).then((response) => {
                taxes.value = response.data;
            });
        };

        const warehouseAdded = () => {
            axiosAdmin.get(warehouseUrl).then((response) => {
                warehouses.value = response.data;
            });
        };

        return {
            columns,
            ...crudVariables,
            filterableColumns,
            ...toRefs(state),
            warehouseId,
            floors,
            shelfGroups,
            shelfNumbers,
            rows,
            formData,
            productsAmount,
            rules,
            loading,
            warehouses,
            taxes,
            onSubmit,
            fetchProductsIn,
            findProduct,
            searchValueSelected,
            selectedProducts,
            showDeleteConfirm,
            quantityChanged,
            formatAmountCurrency,
            taxChanged,
            recalculateFinalTotal,
            appSetting,
            editItem,
            orderPageObject,

            orderItemColumns,

            // Add Edit
            addEditVisible,
            addEditFormData,
            addEditFormSubmitting,
            addEditRules,
            addEditPageTitle,
            onAddEditSubmit,
            onAddEditClose,
            allOrderStatus,
            taxTypes,
            permsArray,

            unitAdded,
            taxAdded,
            warehouseAdded,
            warehouseSearchLabelPrefix,

            //* ADDENDUM
            allWarehouses,
            checkProductInChanged,
            setUrlData,
            searchData,
            filters,
            hashableColumns,
            
            getFloor,
            getShelfGroup,
            getShelfRow,
            getShelfNumber,
            getCheckboxProps,            
            onRowSelectionChange,
            selectedRowKeys,
            addSelectedItem,
            rowSelection,
            addItem,
            allSelectedItems
        };
    },
};
</script>
