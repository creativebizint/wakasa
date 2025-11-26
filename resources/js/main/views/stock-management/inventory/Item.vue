<template>
    <AdminPageHeader>
        <template #header>
            <a-page-header
                :title="$t(`menu.barcode_registration`)"
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
                    {{ $t(`menu.barcode_registration`) }}
                </a-breadcrumb-item>
            </a-breadcrumb>
        </template>
    </AdminPageHeader>

    <a-card class="page-content-container">
        <a-row :gutter="8">
            <a-col :xs="24" :sm="24" :md="12" :lg="12">
                <a-form-item
                    :label="$t('stock.invoice_number')"
                    name="invoice_number"
                    :help="rules.invoice_number ? rules.invoice_number.message : null"
                    :validateStatus="rules.invoice_number ? 'error' : null"
                >
                    <a-input-number
                        v-model:value="formData.invoice_number"
                        :placeholder="
                            $t('common.placeholder_default_text', [
                                $t('stock.invoice_number'),
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

        <a-form layout="vertical">
            <a-row :gutter="16">
                <a-col :xs="24" :sm="24" :md="24" :lg="24">
                    <a-table
                        :row-key="(record) => record.xid"
                        :dataSource="selectedProducts"
                        :columns="orderItemBarcodeIn"
                        :pagination="false"
                        :rowClassName="(record) => (record.qr_scanned_in < record.quantity) && (!record.note || record.note.trim() === '') ? '' : 'fully-scanned-row'"
                    >
                        <template #bodyCell="{ column, record }">
                            <template v-if="column.dataIndex === 'product_item_id'">
                                <a-typography-link 
                                v-if="(record.qr_scanned_in < record.quantity) && (!record.note || record.note.trim() === '') "
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
                            <template v-if="column.dataIndex === 'qty_scanned'">
                                {{record.qr_scanned_in}}
                            </template>
                            <template v-if="column.dataIndex === 'note'">
                                <a-button
                                    v-if="record.qr_scanned_in < record.quantity && (!record.note || record.note.trim() === '')"
                                    type="primary"
                                    size="small"
                                    @click="openNoteModal(record)"
                                    >
                                    <template #icon>
                                        <plus-outlined />
                                    </template>
                                    Complete with Note
                                </a-button>

                                <!-- Case 2: Has note → Show the note (with edit option) -->
                                <div v-else-if="record.note && record.note.trim() !== ''">
                                    <a-typography-text type="secondary">
                                        {{ record.note }}
                                    </a-typography-text>
                                    <a-button
                                        type="link"
                                        size="small"
                                        @click="openNoteModal(record)"
                                        style="padding: 0 4px; margin-left: 8px;"
                                    >
                                        <edit-outlined />
                                    </a-button>
                                </div>

                                <!-- Case 3: Fully scanned (or equal) → Show nothing or optional check -->
                                <span v-else>
                                    <check-circle-outlined style="color: #52c41a;" />
                                </span>
                            </template>
                        </template>
                    </a-table>
                </a-col>
            </a-row>

        </a-form>
    </a-card>

    <a-modal
    :open="noteModalVisible"
    title="Add / Edit Note"
    @cancel="closeNoteModal"
    :footer="null"
    width="500px"
>
    <a-textarea
        v-model:value="noteInput"
        placeholder="Enter your note here..."
        :rows="5"
        :maxLength="500"
        showCount
    />
    <div style="margin-top: 16px; text-align: right;">
        <a-button @click="closeNoteModal" style="margin-right: 8px;">
            Cancel
        </a-button>
        <a-button type="primary" @click="saveNote">
            Save Note
        </a-button>
    </div>
</a-modal>


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
<style>
/* Blue background for fully scanned rows */
.fully-scanned-row {
    background-color: #DDDDFF !important; /* Light blue (AntD primary light) */
}

/* Optional: darker blue on hover for better UX */
.fully-scanned-row:hover > td {
    background-color: #DDFFDD !important;
}

/* If you want a stronger blue */
.fully-scanned-row {
    background-color: #DDDDFF !important;
    color: #000 !important;
}

.fully-scanned-row:hover > td {
    background-color: #DDFFDD !important;
}
</style>
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
import { Modal, message } from "ant-design-vue";   // ← Add this import
//
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
        // ———————————————————— NOTE MODAL LOGIC ————————————————————
        const noteModalVisible = ref(false);
        const currentEditingRecord = ref(null);
        const noteInput = ref("");

        const openNoteModal = (record) => {
            currentEditingRecord.value = record;
            console.log('record',currentEditingRecord.value);
            noteInput.value = record.note || "";
            noteModalVisible.value = true;
        };

        const saveNote = () => {
    if (!currentEditingRecord.value) return;

    const payload = {
        id: currentEditingRecord.value.item_id, // use xid or item_id
        note: noteInput.value.trim(),
    };

    // Show loading feedback
    const hideLoading = message.loading('Saving note...', 0);

    axiosAdmin.post('inventory-detail/barcode/complete-with-note', payload)
        .then((response) => {
            hideLoading();
            message.success('Note saved successfully');

            // Update the record in selectedProducts so UI updates instantly
            currentEditingRecord.value.note = noteInput.value.trim();

            // Close modal
            noteModalVisible.value = false;
            currentEditingRecord.value = null;
            noteInput.value = "";
        })
        .catch((error) => {
            hideLoading();
            const errorMsg = error.response?.data?.message || 'Failed to save note';
            message.error(errorMsg);
            console.error('Note save error:', error);
        });
};

        const closeNoteModal = () => {
            noteModalVisible.value = false;
            currentEditingRecord.value = null;
            noteInput.value = "";
        };
        // ————————————————————————————————————————————————————————
        
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
        const { orderItemBarcodeIn } = fields();
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

            orderItemBarcodeIn,

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
            
            // ← Add these to the return object
            openNoteModal,
            noteModalVisible,
            noteInput,
            saveNote,
            closeNoteModal,
        };
    },
};
</script>
