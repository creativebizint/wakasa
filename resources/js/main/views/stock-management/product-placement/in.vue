<template>
    <AdminPageHeader>
        <template #header>
            <a-page-header :title="$t(`menu.stock_in`)" class="p-0" /> {{ $t(`menu.stock_in`) }}
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
                    {{ $t(`menu.stock_in`) }}
                </a-breadcrumb-item>                
            </a-breadcrumb>
        </template>
    </AdminPageHeader>

    <admin-page-table-content>
        <a-card class="page-content-container mt-20 mb-20">
            <a-form layout="vertical">
                <a-row :gutter="16">
                    <a-col :xs="24" :sm="24" :md="6" :lg="6">
                        <a-form-item
                            :label="$t(`stock_in.invoice_number`)"
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
                                        $t('stock_in.invoice_number'),
                                    ])
                                "
                            />
                            <small class="small-text-message">
                                {{ $t("stock_in.invoice_number_blank") }}
                            </small>
                        </a-form-item>
                    </a-col>


                    <!--* ADDENDUM -->
                    <a-col :xs="24" :sm="24" :md="4" :lg="4" :xl="4">
                        <WarehouseSearch
                            :labelPrefix="warehouseSearchLabelPrefix"
                            :orderPageObject="allWarehouses"
                            :rules="rules"
                            :warehousesList="[]"
                            :editOrderDisable="false"
                            @onSuccess="(outputWarehouse) => (formData.warehouse_id = outputWarehouse)"
                        />
                    </a-col>
                    
                    <a-col :xs="24" :sm="24" :md="2" :lg="2" :xl="2">
                        <a-form-item
                            :label="$t(`stock_in.floor`)"
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
                                required
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
                        </a-form-item>    
                    </a-col>
                    
                    
                    <a-col :xs="24" :sm="24" :md="4" :lg="4" :xl="4">
                        <a-form-item
                            :label="$t(`stock_in.shelf_group`)"
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
                                @change="getShelfNumber" required
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
                            :label="$t(`stock_in.shelf_number`)"
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
                                    :value="data.xid" required
                                >
                                    {{ data.shelf_number }}
                                </a-select-option>
                            </a-select>
                        </a-form-item>
                    </a-col>

                    <a-col :xs="24" :sm="24" :md="2" :lg="2" :xl="2">
                        <a-form-item
                            :label="$t(`stock_in.row`)"
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
                                @change="setUrlData" required
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


            
                    <a-col :xs="24" :sm="24" :md="6" :lg="6">
                        <a-form-item
                            :label="$t(`stock_in.placement_date`)"
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
                        <a-form-item
                            :label="$t('product.product')"
                            name="orderSearchTerm"
                            :help="
                                rules.product_items ? rules.product_items.message : null
                            "
                            :validateStatus="rules.product_items ? 'error' : null"
                        >
                            <span style="display: flex">
                                <a-select
                                    :value="null"
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
                                            fetchProducts(searchedValue);
                                        }
                                    "
                                    size="large"
                                    option-label-prop="label"
                                    @focus="products = []"
                                    @select="searchValueSelected"
                                    @inputKeyDown="inputValueChanged"
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
                                    >
                                        => {{ product.name }} [{{ product.color.name }}]
                                    </a-select-option>
                                </a-select>
                                <!-- <ProductAddButton size="large" /> -->
                            </span>
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
                                <template v-if="column.dataIndex === 'name'">
                                    {{ record.name }} <br />
                                    <small>
                                        <a-typography-text code>
                                            {{ $t("product.avl_qty") }}
                                            {{
                                                orderPageObject.type == 'purchases' 
                                                ? `${(record.product_stock_quantity - record.placement_qty)}${record.unit_short_name}`
                                                : `(${(record.stock_quantity - record.placement_qty)})${record.unit_short_name}`
                                            }}
                                        </a-typography-text>
                                    </small>
                                </template>
                                <template v-if="column.dataIndex === 'brand'">
                                    {{ record.brand ? record.brand.name : '-' }}
                                </template>
                                <template v-if="column.dataIndex === 'category'">
                                    {{ record.category ? record.category.name : '-' }}
                                </template>
                                <template v-if="column.dataIndex === 'group'">
                                    {{ record.group ? record.group.name : '-'}}
                                </template>
                                <template v-if="column.dataIndex === 'color'">
                                    {{ record.color ? record.color.name : '-' }}
                                </template>
                                <template v-if="column.dataIndex === 'unit_quantity'">
                                    <a-input-number
                                        id="inputNumber"
                                        v-model:value="record.quantity"
                                        @change="quantityChanged(record)"
                                        :min="0"
                                    />
                                </template>
                                <template v-if="column.dataIndex === 'single_unit_price'">
                                    {{ formatAmountCurrency(record.single_unit_price) }}
                                </template>
                                <template v-if="column.dataIndex === 'retail_counter_price'">
                                    {{ formatAmountCurrency(record.retail_counter_price) }}
                                </template>
                                <template v-if="column.dataIndex === 'special_counter_price'">
                                    {{ formatAmountCurrency(record.special_counter_price) }}
                                </template>
                                <template v-if="column.dataIndex === 'discount_counter_price'">
                                    {{ record.discount_counter_price + (record.discount_counter_price == 'SP' ? '' : '%') }}
                                </template>
                                <template v-if="column.dataIndex === 'retail_online_price'">
                                    {{ formatAmountCurrency(record.retail_online_price) }}
                                </template>
                                <template v-if="column.dataIndex === 'special_online_price'">
                                    {{ formatAmountCurrency(record.special_online_price) }}
                                </template>
                                <template v-if="column.dataIndex === 'discount_online_price'">
                                    {{ record.discount_online_price + (record.discount_online_price == 'SP' ? '' : '%') }}
                                </template>
                                <!-- <template v-if="column.dataIndex === 'total_discount'">
                                    {{ formatAmountCurrency(record.total_discount) }}
                                </template>
                                <template v-if="column.dataIndex === 'total_tax'">
                                    {{ formatAmountCurrency(record.total_tax) }}
                                </template> -->
                                <template v-if="column.dataIndex === 'subtotal'">
                                    {{ formatAmountCurrency(record.subtotal) }}
                                </template>
                                <template v-if="column.dataIndex === 'action'">
                                    <!-- <a-button
                                        type="primary"
                                        @click="editItem(record)"
                                        style="margin-left: 4px"
                                    >
                                        <template #icon><EditOutlined /></template>
                                    </a-button> -->
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
                                           productsAmount.totalqty
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
import { onMounted, ref, toRefs } from "vue";
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
import common from "../../../../common/composable/common";
import fields from "./fields_in";
import TaxAddButton from "../../settings/taxes/AddButton.vue";
import WarehouseAddButton from "../../settings/warehouses/AddButton.vue";
import ProductAddButton from "../../product-manager/products/AddButton.vue";
import DateTimePicker from "../../../../common/components/common/calendar/DateTimePicker.vue";
import AdminPageHeader from "../../../../common/layouts/AdminPageHeader.vue";
import UserSearch from "./UserSearch.vue";
import WarehouseSearch from "./WarehouseSearch.vue";

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
        WarehouseSearch,
    },
    setup() {
        const { addEditRequestAdmin, loading, rules } = apiAdmin();
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
        const { orderItemColumns } = fields();
        const warehouseId = ref([]);
        const floors = ref([]);
        const shelfGroups = ref([]);
        const shelfNumbers = ref([]);
        const rows = ref([]);
        const {
            state,
            orderType,
            orderPageObject,
            selectedProducts,
            formData,
            productsAmount,
            taxes,

            recalculateValues,
            fetchProducts,
            searchValueSelected,
            quantityChanged,
            recalculateFinalTotal,
            showDeleteConfirm,
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

            inputValueChanged,
        } = stockManagement();
        const { t } = useI18n();
        const warehouses = ref([]);
        const allUnits = ref([]);
        const router = useRouter();
        const allOrderStatus = ref([]);
        const taxUrl = "taxes?limit=10000";
        const unitUrl = "units?limit=10000";
        const warehouseUrl = `warehouses?filters=id ne "${selectedWarehouse.value.xid}"&hashable=${selectedWarehouse.value.xid}&limit=10000`;
        const warehouseSearchLabelPrefix = ref([]);

        onMounted(() => {
            const taxesPromise = axiosAdmin.get(taxUrl);
            const unitsPromise = axiosAdmin.get(unitUrl);
            const warehousesPromise = axiosAdmin.get(warehouseUrl);

            Promise.all([taxesPromise, unitsPromise, warehousesPromise]).then(
                ([taxResponse, unitResponse, warehousesResponse]) => {
                    taxes.value = taxResponse.data;
                    allUnits.value = unitResponse.data;
                    warehouses.value = warehousesResponse.data;
                }
            );
            orderType.value = 'product-placement';

            warehouseSearchLabelPrefix.value = "to";
            getFloor();
        });

        const onSubmit = () => {

            const newFormDataObject = {
                ...formData.value,
                order_type: 'product-placement',
                total: formData.value.subtotal,
                total_items: selectedProducts.value.length,
                product_items: selectedProducts.value,
            };

            addEditRequestAdmin({
                url: orderType.value,
                data: newFormDataObject,
                successMessage: t(`stock_in.created`),
                success: (res) => {
                    router.push({
                        name: `admin.stock_management.index`,
                    });
                },
            });
        };

        const getFloor = () => {
            var selectedWarehouseId = warehouseId.value;
            const floorsPromise = axiosAdmin.get("product-placement/floor");
            Promise.all([floorsPromise]).then(
                ([floorsResponse]) => {
                    floors.value = floorsResponse.data;
                }
            );
        }
        
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
            fetchProducts,
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
            inputValueChanged,
            getFloor,
            getShelfGroup,
            getShelfRow,
            getShelfNumber,
        };
    },
};
</script>
