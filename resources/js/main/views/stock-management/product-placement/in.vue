<template>
    <AdminPageHeader>
        <template #header>
            <a-page-header
                :title="$t(`menu.placement_in`)"
                @back="() => $router.go(-1)"
                class="p-0"
            >
                <template #extra>
                    <a-button type="primary" :loading="loading" @click="onSubmit" style="display: none">
                        <template #icon> <SaveOutlined /> </template>
                        {{ $t("common.save") }}
                    </a-button>
                </template>
            </a-page-header>
        </template>
        <template #breadcrumb>
            <a-breadcrumb separator="-" style="font-size: 12px">
                <a-breadcrumb-item>
                    <router-link :to="{ name: 'admin.dashboard.index' }">
                        {{ $t(`menu.dashboard`) }}
                    </router-link>
                </a-breadcrumb-item>
                <a-breadcrumb-item>
                    <router-link :to="{ name: 'admin.inventory_in.index' }">
                    {{
                       $t(`menu.inventory_in`)
                    }}
                    </router-link>
                </a-breadcrumb-item>
                
                <a-breadcrumb-item>
                    {{ $t("menu.barcode") }}
                </a-breadcrumb-item>
            </a-breadcrumb>
        </template>
    </AdminPageHeader>

    <a-card class="page-content-container">
        <a-alert
            v-if="editOrderDisable"
            :description="$t('messages.not_able_to_edit_order')"
            type="warning"
            class="mb-30"
            showIcon
        />

        <a-row :gutter="8">
                <a-col :xs="24" :sm="24" :md="24" :lg="24">
                    <a-form-item
                        :label="$t('product.item_id')"
                        name="item_id"
                        :help="rules.discount ? rules.discount.message : null"
                        :validateStatus="rules.discount ? 'error' : null"
                    >
                        <a-input-number
                            v-model:value="formData.item_id"
                            :placeholder="
                                $t('common.placeholder_default_text', [
                                    $t('product.item_id'),
                                ])
                            "
                            min="0"
                            style="width: 100%"
                            :disabled="true"
                        >

                        </a-input-number>
                    </a-form-item>
                </a-col>
            </a-row>

        <a-row :gutter="8">
                <a-col :xs="24" :sm="24" :md="24" :lg="24">
                    <a-form-item
                        :label="$t('product.quantity_faktur')"
                        name="total_items"
                        :help="rules.total_items ? rules.total_items.message : null"
                        :validateStatus="rules.total_items ? 'error' : null"
                    >
                        <a-input-number
                            v-model:value="formData.total_items"
                            :placeholder="
                                $t('common.placeholder_default_text', [
                                    $t('common.total'),
                                ])
                            "
                            min="0"
                            style="width: 100%"
                            :disabled="true"
                        >

                        </a-input-number>
                    </a-form-item>
                </a-col>
            </a-row>
            <a-row :gutter="8">
                <a-col :xs="24" :sm="24" :md="24" :lg="24">
                    <a-form-item
                        :label="$t('barcode.quantity_scanned')"
                        name="total_items_scanned"
                        :help="rules.total_items ? rules.total_items.message : null"
                        :validateStatus="rules.total_items ? 'error' : null"
                    >
                        <a-input-number
                            v-model:value="formData.total_items_scanned"
                            min="0"
                            style="width: 100%"
                            :disabled="true"
                        >

                        </a-input-number>
                    </a-form-item>
                </a-col>
            </a-row>
                    
        <a-form layout="vertical">
            <a-row :gutter="16">
                <a-col :xs="24" :sm="24" :md="24" :lg="24">
                    <a-form-item
                        :label="$t('menu.barcode')"
                        name="orderSearchTerm"
                        :help="rules.product_items ? rules.product_items.message : null"
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
                                :not-found-content="productFetching ? undefined : null"
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
                                :disabled="editOrderDisable"
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
                                    :label="product.string"
                                    :product="product"
                                >
                                    => {{ product.string }}
                                </a-select-option>
                            </a-select>
                        </span>
                    </a-form-item>
                </a-col>
            </a-row>
            <a-row :gutter="16">
                <a-col :xs="24" :sm="24" :md="24" :lg="24">
                    <a-table
                        :row-key="(record) => record.xid"
                        :dataSource="selectedProducts"
                        :columns="barcodeColumns"
                        :pagination="false"
                    >
                        <template #bodyCell="{ column, record }">                            
                            <template v-if="column.dataIndex === 'action'">
                                <div v-if="editOrderDisable">-</div>
                                <div v-else>
                                    <a-button
                                        type="primary"
                                        @click="showDeleteConfirm(record)"
                                        style="margin-left: 4px"
                                    >
                                        <template #icon><DeleteOutlined /></template>
                                    </a-button>
                                </div>
                            </template>
                        </template>
                        
                    </a-table>
                </a-col>
            </a-row>

            <a-row :gutter="16" class="mt-30">
                <a-col :xs="24" :sm="24" :md="8" :lg="8">
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
                </a-col>
            </a-row>
        </a-form>
    </a-card>

    <a-modal
        :open="addEditVisible"
        :closable="false"
        :centered="true"
        :title="addEditPageTitle"
        @ok="onAddEditSubmit"
    >
        <a-form layout="vertical">
            <a-row :gutter="16">
                <a-col :xs="24" :sm="24" :md="24" :lg="24">
                    <a-form-item
                        :label="$t('product.unit_price')"
                        name="unit_price"
                        :help="
                            addEditRules.unit_price
                                ? addEditRules.unit_price.message
                                : null
                        "
                        :validateStatus="addEditRules.unit_price ? 'error' : null"
                    >
                        <a-input-number
                            v-model:value="addEditFormData.unit_price"
                            :placeholder="
                                $t('common.placeholder_default_text', [
                                    $t('product.unit_price'),
                                ])
                            "
                            min="0"
                            style="width: 100%"
                        >
                            <template #addonBefore>
                                {{ appSetting.currency.symbol }}
                            </template>
                        </a-input-number>
                    </a-form-item>
                </a-col>
            </a-row>
            <a-row :gutter="16">
                <a-col :xs="24" :sm="24" :md="24" :lg="24">
                    <a-form-item
                        :label="$t('product.discount')"
                        name="discount_rate"
                        :help="
                            addEditRules.discount_rate
                                ? addEditRules.discount_rate.message
                                : null
                        "
                        :validateStatus="addEditRules.discount_rate ? 'error' : null"
                    >
                        <a-input-number
                            v-model:value="addEditFormData.discount_rate"
                            :placeholder="
                                $t('common.placeholder_default_text', [
                                    $t('product.discount'),
                                ])
                            "
                            min="0"
                            style="width: 100%"
                        >
                            <template #addonAfter>%</template>
                        </a-input-number>
                    </a-form-item>
                </a-col>
            </a-row>

            <a-row :gutter="16">
                <a-col :xs="24" :sm="24" :md="24" :lg="24">
                    <a-form-item
                        :label="$t('product.tax')"
                        name="tax_id"
                        :help="addEditRules.tax_id ? addEditRules.tax_id.message : null"
                        :validateStatus="addEditRules.tax_id ? 'error' : null"
                    >
                        <span style="display: flex">
                            <a-select
                                v-model:value="addEditFormData.tax_id"
                                :placeholder="
                                    $t('common.select_default_text', [$t('product.tax')])
                                "
                                :allowClear="true"
                                optionFilterProp="title"
                                show-search
                            >
                                <a-select-option
                                    v-for="tax in taxes"
                                    :key="tax.xid"
                                    :value="tax.xid"
                                    :title="tax.name"
                                >
                                    {{ tax.name }} ({{ tax.rate }}%)
                                </a-select-option>
                            </a-select>
                            <TaxAddButton @onAddSuccess="taxAdded" />
                        </span>
                    </a-form-item>
                </a-col>
            </a-row>
            <a-row :gutter="16">
                <a-col :xs="24" :sm="24" :md="24" :lg="24">
                    <a-form-item
                        :label="$t('product.tax_type')"
                        name="tax_type"
                        :help="
                            addEditRules.tax_type ? addEditRules.tax_type.message : null
                        "
                        :validateStatus="addEditRules.tax_type ? 'error' : null"
                    >
                        <a-select
                            v-model:value="addEditFormData.tax_type"
                            :placeholder="
                                $t('common.select_default_text', [$t('product.tax_type')])
                            "
                            :allowClear="true"
                        >
                            <a-select-option
                                v-for="taxType in taxTypes"
                                :key="taxType.key"
                                :value="taxType.key"
                            >
                                {{ taxType.value }}
                            </a-select-option>
                        </a-select>
                    </a-form-item>
                </a-col>
            </a-row>
        </a-form>
        <template #footer>
            <a-button
                key="submit"
                type="primary"
                :loading="addEditFormSubmitting"
                @click="onAddEditSubmit"
            >
                <template #icon>
                    <SaveOutlined />
                </template>
                {{ $t("common.update") }}
            </a-button>
            <a-button key="back" @click="onAddEditClose">
                {{ $t("common.cancel") }}
            </a-button>
        </template>
    </a-modal>
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
    BarcodeOutlined,
} from "@ant-design/icons-vue";
import { useI18n } from "vue-i18n";
import { useRouter } from "vue-router";
import apiAdmin from "../../../../common/composable/apiAdmin";
import common from "../../../../common/composable/common";
import stockManagement from "./stockManagement";
import fields from "./fields";
import TaxAddButton from "../../settings/taxes/AddButton.vue";
import WarehouseAddButton from "../../settings/warehouses/AddButton.vue";
import ProductAddButton from "../../product-manager/products/AddButton.vue";
import DateTimePicker from "../../../../common/components/common/calendar/DateTimePicker.vue";
import AdminPageHeader from "../../../../common/layouts/AdminPageHeader.vue";
import UserSearch from "./UserSearch.vue";

//* ADDENDUM
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
        BarcodeOutlined,

        TaxAddButton,
        WarehouseAddButton,
        ProductAddButton,
        DateTimePicker,
        AdminPageHeader,
        UserSearch,

        //* ADDENDUM
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
        } = common();
        const { barcodeColumns } = fields();
        const {
            state,
            orderType,
            orderPageObject,
            route,
            selectedProducts,
            selectedProductIds,
            maximumBarcode,
            formData,
            productsAmount,
            taxes,

            setTaxes,
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
            removedOrderItemsIds,

            calculateProductAmount,
            inputValueChanged,
        } = stockManagement();
        const { t } = useI18n();
        const warehouses = ref([]);
        const allUnits = ref([]);
        const users = ref([]);
        const orderId = route.params.id;
        const router = useRouter();
        const allOrderStatus = ref([]);
        const taxUrl = "taxes?limit=10000";
        const unitUrl = "units?limit=10000";
        const warehouseUrl = `warehouses?filters=id ne "${selectedWarehouse.value.xid}"&hashable=${selectedWarehouse.value.xid}&limit=10000`;
        const editOrderDisable = ref(false);

        const userSearchLabelPrefix = ref([]);
        const warehouseSearchLabelPrefix = ref([]);
        const userWarehouses = ref([]);


        onMounted(() => {
            const orderPromise = axiosAdmin.get(`inventory-detail/barcode/${orderId}`);
            Promise.all([
                orderPromise                
            ]).then(([orderResponse]) => {
                const orderResponseData = orderResponse;
                selectedProductIds.value = orderResponseData.ids;
                selectedProducts.value = orderResponseData.data;
                const total_item = orderResponseData.total;
                maximumBarcode.value = orderResponseData.order_item.quantity;
                formData.value = {
                    item_id: orderResponseData.order_item.item_id,
                    total_items : orderResponseData.order_item.quantity,
                    total_items_scanned : orderResponseData.order_item.quantity_scanned == null ? 0 : orderResponseData.order_item.quantity_scanned
                };
            });

        });

        const onSubmit = () => {
            if(maximumBarcode.value < selectedProducts.value.length){
                alert('total scan barcode('+selectedProducts.value.length+') > total Item('+ maximumBarcode.value +')');
                return false;
            }

            
            const newFormDataObject = {
                ...formData.value,
                order_item_id: orderId,
                total_items: selectedProducts.value.length,
                product_items: selectedProducts.value,
                removed_items: removedOrderItemsIds.value,
                _method: "POST",
            };

            addEditRequestAdmin({
                url: `inventory-detail/barcode/register`,
                data: newFormDataObject,
                successMessage: t(`barcode.updated`),
                success: (res) => {
                    router.push({
                        name: `admin.barcode_registration.index`,
                    });
                },
            });
        };

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


        const formatOrderDate = (dayjs) => {
            // return dayjs.format(dateFormat);
            return "YYYY-MM-DD hh:mm:ss a";
        };

        return {
            ...toRefs(state),
            formData,
            productsAmount,
            loading,
            rules,
            users,
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

            barcodeColumns,

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


            editOrderDisable,
            inputValueChanged,

            //addition
            userWarehouses,
        };
    },
};
</script>
