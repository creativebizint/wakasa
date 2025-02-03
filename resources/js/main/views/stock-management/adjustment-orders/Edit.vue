<template>
    <AdminPageHeader>
        <template #header>
            <a-page-header
                :title="$t(`menu.${orderPageObject.menuKey}`)"
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
                    <router-link
                        :to="{
                            name: `admin.stock.${orderPageObject.type}.index`,
                        }"
                    >
                        {{ $t(`menu.${orderPageObject.menuKey}`) }}
                    </router-link>
                </a-breadcrumb-item>
                <a-breadcrumb-item>
                    {{ $t("common.edit") }}
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

        <a-form layout="vertical">
            <a-row :gutter="16">
                <a-col :xs="24" :sm="24" :md="6" :lg="6">
                    <a-form-item
                        :label="$t(`stock.invoice_number`)"
                        name="invoice_number"
                        :help="
                            rules.invoice_number
                                ? rules.invoice_number.message
                                : null
                        "
                        :validateStatus="rules.invoice_number ? 'error' : null"
                    >
                        <a-input
                            v-model:value="formData.invoice_number"
                            :placeholder="
                                $t('common.placeholder_default_text', [
                                    $t('stock.invoice_number'),
                                ])
                            "
                            :disabled="editOrderDisable"
                        />
                    </a-form-item>
                </a-col>

                <a-col :xs="24" :sm="24" :md="6" :lg="6">
                    <WarehouseSearch
                        :labelPrefix="warehouseSearchLabelPrefix"
                        :orderPageObject="allWarehouses"
                        :rules="rules"
                        :warehousesList="userWarehouses"
                        :editOrderDisable="false"
                        @onSuccess="
                            (outputWarehouse) =>
                                (formData.warehouse_id = outputWarehouse)
                        "
                    />
                </a-col>

                <a-col :xs="24" :sm="24" :md="6" :lg="6">
                    <a-form-item
                        :label="$t('stock_adjustment.adjustment_type')"
                        name="adjustment_type"
                        :help="
                            rules.adjustment_type
                                ? rules.adjustment_type.message
                                : null
                        "
                        :validateStatus="rules.adjustment_type ? 'error' : null"
                        class="required"
                    >
                        <a-select
                            v-model:value="formData.adjustment_type"
                            :placeholder="
                                $t('common.select_default_text', [
                                    $t('stock_adjustment.adjustment_type'),
                                ])
                            "
                        >
                            <a-select-option
                                v-for="adjustmentType in adjustmentTypes"
                                :key="adjustmentType.key"
                                :value="adjustmentType.key"
                            >
                                {{ adjustmentType.value }}
                            </a-select-option>
                        </a-select>
                    </a-form-item>
                </a-col>

                <a-col :xs="24" :sm="24" :md="6" :lg="6">
                    <a-form-item
                        :label="$t(`${orderPageObject.langKey}.date`)"
                        name="date"
                        :help="rules.date ? rules.date.message : null"
                        :validateStatus="rules.date ? 'error' : null"
                        class="required"
                    >
                        <DateTimePicker
                            v-if="formData.date"
                            :dateTime="formData.date"
                            @dateTimeChanged="
                                (changedDateTime) =>
                                    (formData.date = changedDateTime)
                            "
                            :disabled="editOrderDisable"
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
                            rules.product_items
                                ? rules.product_items.message
                                : null
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
                                :disabled="editOrderDisable"
                                @inputKeyDown="inputValueChanged"
                            >
                                <template #suffixIcon
                                    ><SearchOutlined
                                /></template>
                                <template
                                    v-if="productFetching"
                                    #notFoundContent
                                >
                                    <a-spin size="small" />
                                </template>
                                <a-select-option
                                    v-for="product in products"
                                    :key="product.xid"
                                    :value="product.xid"
                                    :label="product.name"
                                    :product="product"
                                >
                                    => {{ product.name }} [{{
                                        product.color.name
                                    }}]
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
                        :columns="orderItemColumns"
                        :pagination="false"
                    >
                        <template #bodyCell="{ column, record }">
                            <template v-if="column.dataIndex === 'item_code'">
                                {{ record.item_code }}
                            </template>
                            <template v-if="column.dataIndex === 'name'">
                                {{ record.name }} <br />
                                <small>
                                    <a-typography-text code>
                                        {{ $t("product.avl_qty") }}
                                        {{
                                            `${record.stock_quantity}${record.unit_short_name}`
                                        }}
                                    </a-typography-text>
                                </small>
                            </template>
                            <template v-if="column.dataIndex === 'brand'">
                                {{ record.brand ? record.brand.name : "-" }}
                            </template>
                            <template v-if="column.dataIndex === 'category'">
                                {{
                                    record.category ? record.category.name : "-"
                                }}
                            </template>
                            <template v-if="column.dataIndex === 'group'">
                                {{ record.group ? record.group.name : "-" }}
                            </template>
                            <template v-if="column.dataIndex === 'color'">
                                {{ record.color ? record.color.name : "-" }}
                            </template>
                            <template v-if="column.dataIndex === 'notes'">
                                <a-input
                                    id="inputNotes"
                                    v-model:value="record.notes"
                                />
                            </template>
                            <template
                                v-if="column.dataIndex === 'unit_quantity'"
                            >
                                <a-input-number
                                    id="inputNumber"
                                    v-model:value="record.quantity"
                                    @change="quantityChanged(record)"
                                    :min="
                                        record.stock_quantity === 0 &&
                                        formData.adjustment_type === 'subtract'
                                            ? 0
                                            : 1
                                    "
                                    :max="
                                        formData.adjustment_type === 'subtract'
                                            ? record.stock_quantity
                                            : 999
                                    "
                                    :disabled="editOrderDisable"
                                />
                            </template>

                            <template v-if="column.dataIndex === 'action'">
                                <div v-if="editOrderDisable">-</div>
                                <div v-else>
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
                                        <template #icon
                                            ><DeleteOutlined
                                        /></template>
                                    </a-button>
                                </div>
                            </template>
                        </template>
                    </a-table>
                </a-col>
            </a-row>

            <a-row :gutter="16" class="mt-30">
                <a-col :xs="24" :sm="24" :md="16" :lg="16">
                    <a-row :gutter="16">
                        <a-col :xs="24" :sm="24" :md="24" :lg="24">
                            <a-form-item
                                :label="$t(`stock.notes`)"
                                name="notes"
                                :help="rules.notes ? rules.notes.message : null"
                                :validateStatus="rules.notes ? 'error' : null"
                            >
                                <a-textarea
                                    v-model:value="formData.notes"
                                    :placeholder="
                                        $t('common.select_default_text', [
                                            $t('stock.notes'),
                                        ])
                                    "
                                    :auto-size="{ minRows: 2, maxRows: 3 }"
                                    :disabled="editOrderDisable"
                                />
                            </a-form-item>
                        </a-col>
                    </a-row>
                </a-col>
                <a-col :xs="24" :sm="24" :md="8" :lg="8">
                    <a-row :gutter="16" class="mt-20 mb-20">
                        <a-progress
                            :percent="ordersProgress.percent"
                            :status="ordersProgress.status"
                        />
                        <a-typography-text type="danger">
                            {{ ordersProgress.message }}
                        </a-typography-text>
                        <a-button
                            type="primary"
                            :loading="ordersProgress.loading"
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
                        :validateStatus="
                            addEditRules.unit_price ? 'error' : null
                        "
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
                        :validateStatus="
                            addEditRules.discount_rate ? 'error' : null
                        "
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
                        :help="
                            addEditRules.tax_id
                                ? addEditRules.tax_id.message
                                : null
                        "
                        :validateStatus="addEditRules.tax_id ? 'error' : null"
                    >
                        <span style="display: flex">
                            <a-select
                                v-model:value="addEditFormData.tax_id"
                                :placeholder="
                                    $t('common.select_default_text', [
                                        $t('product.tax'),
                                    ])
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
                            <!-- <TaxAddButton @onAddSuccess="taxAdded" /> -->
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
                            addEditRules.tax_type
                                ? addEditRules.tax_type.message
                                : null
                        "
                        :validateStatus="addEditRules.tax_type ? 'error' : null"
                    >
                        <a-select
                            v-model:value="addEditFormData.tax_type"
                            :placeholder="
                                $t('common.select_default_text', [
                                    $t('product.tax_type'),
                                ])
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
import { onMounted, ref, toRefs, computed } from "vue";
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
import { notification } from "ant-design-vue";
import { useI18n } from "vue-i18n";
import { useRouter } from "vue-router";
import { useStore } from "vuex";
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

            //* ADDENDUM
            allWarehouses,
            priceTypes,
            salesLabels,
        } = common();
        const { orderItemColumns, adjustmentTypes } = fields();
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

            //* ADDENDUM
            subtotalChanged,
        } = stockManagement();
        const { t } = useI18n();
        const store = useStore();
        const ordersProgress = computed(() => store.state.auth.ordersProgress);
        const toWarehouses = ref([]);
        const fromWarehouses = ref([]);
        const allUnits = ref([]);
        const users = ref([]);
        const orderId = route.params.id;
        const router = useRouter();
        const allOrderStatus = ref([]);
        const taxUrl = "taxes?limit=10000";
        const unitUrl = "units?limit=10000";
        const warehouseUrl = `warehouses?filters=id ne "${selectedWarehouse.value.xid}"&hashable=${selectedWarehouse.value.xid}&limit=10000`;
        const editOrderDisable = ref(false);

        //* ADDENDUM
        const userSearchLabelPrefix = ref([]);
        const warehouseSearchLabelPrefix = ref([]);
        const userWarehouses = ref([]);

        onMounted(() => {
            store.commit("auth/updateOrdersProgress", {
                percent: 0,
                status: "active",
                message: "",
                loading: false,
            });

            const orderPromise = axiosAdmin.get(
                `${orderType.value}/${orderId}`
            );
            const taxesPromise = axiosAdmin.get(taxUrl);
            const unitsPromise = axiosAdmin.get(unitUrl);
            const warehousesPromise = axiosAdmin.get(warehouseUrl);

            Promise.all([
                orderPromise,
                taxesPromise,
                unitsPromise,
                warehousesPromise,
            ]).then(
                ([
                    orderResponse,
                    taxResponse,
                    unitResponse,
                    warehousesResponse,
                ]) => {
                    const orderResponseData = orderResponse.data;
                    console.log(orderResponseData);
                    formData.value = {
                        invoice_number: orderResponseData.order.invoice_number,
                        date: orderResponseData.order.date,
                        warehouse_id: orderResponseData.order.x_warehouse_id,
                        notes: orderResponseData.order.notes,
                        adjustment_type:
                            orderResponseData.order.adjustment_type,
                    };
                    selectedProductIds.value = orderResponseData.ids;
                    selectedProducts.value = orderResponseData.items;
                    calculateProductAmount();

                    users.value = orderResponseData.user;
                    taxes.value = taxResponse.data;
                    allUnits.value = unitResponse.data;
                    userWarehouses.value = orderResponseData.warehouse;

                    editOrderDisable.value = false;
                }
            );

            if (orderType.value == "purchases") {
                allOrderStatus.value = purchaseOrderStatus;
                formData.value.order_status = "received";
                formData.value.label = "purchases";
                warehouseSearchLabelPrefix.value = "to";
            } else if (orderType.value == "sales") {
                allOrderStatus.value = salesOrderStatus;
                formData.value.order_status = "delivered";
                warehouseSearchLabelPrefix.value = "from";
            } else if (orderType.value == "sales-returns") {
                allOrderStatus.value = salesReturnStatus;
                formData.value.order_status = "received";
                warehouseSearchLabelPrefix.value = "to";
            } else if (orderType.value == "purchase-returns") {
                allOrderStatus.value = purchaseReturnStatus;
                formData.value.order_status = "completed";
                formData.value.label = "purchases";
                warehouseSearchLabelPrefix.value = "from";
            } else if (orderType.value == "quotations") {
                allOrderStatus.value = [];
                warehouseSearchLabelPrefix.value = "to";
            } else if (orderType.value == "stock-transfers") {
                allOrderStatus.value = salesOrderStatus;
                formData.value.order_status = "delivered";
                formData.value.label = "stock-transfers";
                warehouseSearchLabelPrefix.value = "from";
            }
        });

        const onSubmit = () => {
            store.commit("auth/updateOrdersProgress", {
                percent: 0,
                status: "active",
                message: "",
                loading: true,
            });

            const newFormDataObject = {
                ...formData.value,
                total: formData.value.subtotal,
                total_items: selectedProducts.value.length,
                product_items: selectedProducts.value,
                removed_items: removedOrderItemsIds.value,
                discount: 0,
                _method: "PUT",
            };

            addEditRequestAdmin({
                url: `${orderType.value}/${orderId}`,
                data: newFormDataObject,
                // successMessage: t(`${orderPageObject.value.langKey}.updated`),
                success: (res) => {
                    updateOrdersProgress(res);
                },
                error: (_) => {
                    store.commit("auth/updateOrdersProgress", {
                        percent: 0,
                        status: "active",
                        message: "",
                        loading: false,
                    });
                },
            });
        };

        const updateOrdersProgress = (res) => {
            console.log(res);
            setTimeout(() => {
                store.commit("auth/updateOrdersProgress", {
                    percent: res.progress.percent,
                    status: "active",
                    message: "",
                    loading: true,
                });

                if (res.finished) {
                    notification.success({
                        placement: appSetting.value.rtl
                            ? "bottomLeft"
                            : "bottomRight",
                        message: t("common.success"),
                        description: t(
                            `${orderPageObject.value.langKey}.updated`
                        ),
                    });

                    store.commit("auth/updateOrdersProgress", {
                        percent: 100,
                        status: "success",
                        message: "",
                        loading: false,
                    });

                    setTimeout(() => {
                        router.push({
                            name: `admin.stock.${orderType.value}.index`,
                        });
                    }, 500);
                } else {
                    axiosAdmin
                        .post("queue/import-progress", {
                            id: res.id,
                            finished: res.finished,
                            cache_key: res.cache_key,
                            progress: res.progress,
                        })
                        .then((progressRes) => {
                            updateOrdersProgress(progressRes.data);
                        })
                        .catch((err) => {
                            store.commit("auth/updateOrdersProgress", {
                                percent: res.progress.percent,
                                status: "exception",
                                message: err.data.error.message,
                                loading: false,
                            });
                        });
                }
            }, 2000);
        };

        const fromWarehouseChanged = (selectedWarehouseId) => {
            axiosAdmin.post("change-warehouse", {
                warehouse_id: selectedWarehouseId,
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
            adjustmentTypes,

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

            //unitAdded,
            //taxAdded,
            //warehouseAdded,

            editOrderDisable,

            //* ADDENDUM
            allWarehouses,
            toWarehouses,
            fromWarehouses,
            fromWarehouseChanged,
            userWarehouses,
            userSearchLabelPrefix,
            warehouseSearchLabelPrefix,
            priceTypes,
            salesLabels,
            subtotalChanged,

            inputValueChanged,
            ordersProgress,
        };
    },
};
</script>
