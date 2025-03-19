<template>
    <AdminPageHeader>
        <template #header>
            <a-page-header
                :title="$t(`menu.inventory_in`)"
                @back="() => $router.go(-1)"
                class="p-0"
            >
                
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
                    {{ $t("common.edit") }}
                </a-breadcrumb-item>
            </a-breadcrumb>
        </template>
    </AdminPageHeader>

    <a-card class="page-content-container">
        <a-form layout="vertical">
            
            <a-row :gutter="16">
                <a-col :xs="24" :sm="24" :md="24" :lg="24">
                    <a-table
                        :row-key="(record) => record.xid"
                        :dataSource="selectedProducts"
                        :columns="orderItemBarcode"
                        :pagination="false"
                    >
                        <template #bodyCell="{ column, record }">
                            <template v-if="column.dataIndex === 'product_item_id'">
                                <a-typography-link 
                                @click="
                                                () =>
                                                    $router.push({
                                                        name: `admin.inventory_in.barcode`,
                                                        params: {
                                                            id: record.item_id,
                                                        },
                                                    })
                                            ">
                                    {{ record.product_item_id }}
                                </a-typography-link>
                                                                
                            </template>
                            <template v-if="column.dataIndex === 'unit_quantity'">
                                {{record.quantity}}
                            </template>
                        </template>
                    </a-table>
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
        const { orderItemBarcode } = fields();
        const {
            state,
            orderType,
            orderPageObject,
            route,
            selectedProducts,
            selectedProductIds,
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
            const orderPromise = axiosAdmin.get(`${orderType.value}/${orderId}`);
            const taxesPromise = axiosAdmin.get(taxUrl);
            const unitsPromise = axiosAdmin.get(unitUrl);
            const warehousesPromise = axiosAdmin.get(warehouseUrl);

            Promise.all([
                orderPromise,
                taxesPromise,
                unitsPromise,
                warehousesPromise,
            ]).then(([orderResponse, taxResponse, unitResponse, warehousesResponse]) => {
                const orderResponseData = orderResponse.data;
                formData.value = {
                    invoice_number: orderResponseData.order.invoice_number,
                    order_date: orderResponseData.order.order_date,
                    user_id: orderResponseData.order.x_user_id,
                    warehouse_id: orderResponseData.order.x_warehouse_id,
                    notes: orderResponseData.order.notes,
                    terms_condition: orderResponseData.order.terms_condition,
                    order_status: orderResponseData.order.order_status,
                    tax_id: orderResponseData.order.x_tax_id,
                    tax_rate: orderResponseData.order.tax_rate,
                    tax_amount: orderResponseData.order.tax_amount,
                    discount: orderResponseData.order.discount
                        ? orderResponseData.order.discount
                        : 0,
                    shipping: orderResponseData.order.shipping
                        ? orderResponseData.order.shipping
                        : 0,
                    subtotal: orderResponseData.order.total,
                };
                selectedProductIds.value = orderResponseData.ids;
                selectedProducts.value = orderResponseData.items;
                calculateProductAmount();

                users.value = orderResponseData.user;
                taxes.value = taxResponse.data;
                allUnits.value = unitResponse.data;
                warehouses.value = warehousesResponse.data;
                userWarehouses.value = orderResponseData.warehouse;

                if (orderResponseData.order.payment_status != "unpaid") {
                    editOrderDisable.value = true;
                }
            });

            if (orderType.value == "purchases") {
                allOrderStatus.value = purchaseOrderStatus;
            } else if (orderType.value == "sales") {
                allOrderStatus.value = salesOrderStatus;
            } else if (orderType.value == "sales-returns") {
                allOrderStatus.value = salesReturnStatus;
            } else if (orderType.value == "purchase-returns") {
                allOrderStatus.value = purchaseReturnStatus;
            } else if (orderType.value == "quotations") {
                allOrderStatus.value = [];
            } else if (orderType.value == "stock-transfers") {
                allOrderStatus.value = salesOrderStatus;
            }
        });

        const onSubmit = () => {
            const newFormDataObject = {
                ...formData.value,
                total: formData.value.subtotal,
                total_items: selectedProducts.value.length,
                product_items: selectedProducts.value,
                removed_items: removedOrderItemsIds.value,
                _method: "PUT",
            };

            addEditRequestAdmin({
                url: `${orderType.value}/${orderId}`,
                data: newFormDataObject,
                successMessage: t(`${orderPageObject.value.langKey}.updated`),
                success: (res) => {
                    router.push({
                        name: `admin.inventory_in.index`,
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

        const warehouseAdded = () => {
            axiosAdmin.get(warehouseUrl).then((response) => {
                warehouses.value = response.data;
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

            orderItemBarcode,

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

            editOrderDisable,
            inputValueChanged,

            //addition
            userWarehouses,
        };
    },
};
</script>
