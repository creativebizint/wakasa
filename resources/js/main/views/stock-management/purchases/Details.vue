<template>
    <div>
        <AddEdit
            :addEditType="addEditType"
            :visible="addEditVisible"
            :url="addEditUrl"
            @addEditSuccess="addEditSuccess"
            @closed="onCloseAddEdit"
            :formData="formData"
            :data="selectedItem"
            :editItemAmount="editItemAmount"
            :pageTitle="pageTitle"
            :successMessage="successMessage"
        />

        <div class="order-details">
            <a-row class="mt-10">
                <a-col :xs="24" :sm="24" :md="24" :lg="24">
                    <a-descriptions
                        :title="null"
                        layout="vertical"
                        :contentStyle="{
                            fontWeight: 500,
                            marginBottom: '20px',
                        }"
                    >
                        <a-descriptions-item :label="$t('stock.order_date')">
                            {{ formatDateTime(selectedItem.order_date) }}
                        </a-descriptions-item>
                        
                        <a-descriptions-item
                            :label="$t(selectedItem.order_type+'.invoice_number')"
                        >
                            {{ selectedItem.invoice_number }}
                        </a-descriptions-item>
                        
                        <a-descriptions-item v-if="selectedItem.refference" :label="$t('sales.reference')">
                            {{ selectedItem.refference || '-' }}
                        </a-descriptions-item>
                        
                        <a-descriptions-item v-if="selectedItem.combined_shipment_number" :label="$t('sales.combined_shipment_number')">
                            {{ selectedItem.combined_shipment_number || '-' }}
                        </a-descriptions-item>
                        
                        <a-descriptions-item
                            v-if="selectedItem.user && selectedItem.user.name"
                            :label="
                                selectedItem.order_type == 'purchases' ||
                                selectedItem.order_type == 'purchase-returns'
                                    ? $t('stock.supplier')
                                    : $t('stock.customer')
                            "
                        >
                            {{ selectedItem.user.name }}
                        </a-descriptions-item>
                        
                        <a-descriptions-item
                            v-if="
                                selectedItem.order_type == 'stock-transfers' &&
                                selectedItem.warehouse &&
                                selectedItem.warehouse.name
                            "
                            :label="$t('stock_transfer.to_warehouse')"
                        >
                            {{ selectedItem.warehouse.name }}
                        </a-descriptions-item>
                        
                        <a-descriptions-item
                            v-if="
                                selectedItem.from_warehouse &&
                                selectedItem.from_warehouse.name
                            "
                            :label="$t('stock_transfer.from_warehouse')"
                        >
                            {{ selectedItem.from_warehouse.name }}
                        </a-descriptions-item>
                        
                        <a-descriptions-item :label="$t('stock.status')" :style="{ display: 'none' }">
                            <OrderStatus :data="selectedItem" />
                        </a-descriptions-item>

                        <a-descriptions-item :style="{ display: 'none' }"
                            :label="$t('payments.payment_status')"
                        >
                            <PaymentStatus
                                :paymentStatus="selectedItem.payment_status"
                            />
                        </a-descriptions-item>
                        
                        <a-descriptions-item 
                            :label="$t('common.weight') + ' (Kg)'"
                        >
                            {{selectedItem.weight}}
                        </a-descriptions-item>

                        <a-descriptions-item :label="$t('stock.order_sales_by')" v-if="selectedItem.sales_by && selectedItem.sales_by">
                            {{selectedItem.sales_by}}
                        </a-descriptions-item>

                        <a-descriptions-item
                            :label="$t('stock.order_taken_by')"
                        >
                            {{
                                selectedItem.staff_member &&
                                selectedItem.staff_member.name
                                    ? selectedItem.staff_member.name
                                    : "-"
                            }}
                        </a-descriptions-item>
                        
                        <a-descriptions-item
                            :label="$t('delivery_order.shipping_address')"
                        >
                            {{
                                selectedItem.shipping_address &&
                                selectedItem.shipping_address != ''
                                    ? selectedItem.shipping_address
                                    : "-"
                            }}
                        </a-descriptions-item>
                        
                        <a-descriptions-item
                            :label="$t('delivery_order.shipping_alias')"
                        >
                            {{
                                selectedItem.shipping_alias &&
                                selectedItem.shipping_alias != ''
                                    ? selectedItem.shipping_alias
                                    : "-"
                            }}
                        </a-descriptions-item>
                        
                        <a-descriptions-item
                            :label="$t('delivery_order.city')"
                        >
                            {{
                                selectedItem.city &&
                                selectedItem.city != ''
                                    ? selectedItem.city
                                    : "-"
                            }}
                        </a-descriptions-item>
                        <a-descriptions-item :label="$t('payments.total_amount')" :style="{ display: 'none' }">
                            {{ formatAmountCurrency(selectedItem.total) }}
                        </a-descriptions-item>
                        <a-descriptions-item :label="$t('payments.paid_amount')" :style="{ display: 'none' }">
                            {{ formatAmountCurrency(selectedItem.paid_amount) }}
                        </a-descriptions-item>
                        <a-descriptions-item :label="$t('payments.due_amount')" :style="{ display: 'none' }">
                            {{ formatAmountCurrency(selectedItem.due_amount) }}
                        </a-descriptions-item>
                        <a-descriptions-item :label="$t('stock.discount')" :style="{ display: 'none' }">
                            {{ formatAmountCurrency(selectedItem.discount) }}
                        </a-descriptions-item>
                        <a-descriptions-item :label="$t('stock.shipping')" :style="{ display: 'none' }">
                            {{ formatAmountCurrency(selectedItem.shipping) }}
                        </a-descriptions-item>
                        <a-descriptions-item :label="$t('stock.order_tax')" :style="{ display: 'none' }">
                            {{
                                selectedItem.tax_rate > 0
                                    ? `${selectedItem.tax_rate}%`
                                    : "-"
                            }}
                        </a-descriptions-item>
                    </a-descriptions>
                </a-col>
            </a-row>

            <a-row>
                <a-col :span="24">
                    <a-tabs v-model:activeKey="activeKey">
                        <a-tab-pane
                            key="order_items"
                            :tab="$t('product.order_items')"
                        >
                            <a-row>
                                <a-col :span="24">
                                    <div class="table-responsive">
                                        <a-table
                                            :row-key="(record) => record.xid"
                                            :columns="orderItemDetailsColumns"
                                            :data-source="selectedItem.items"
                                            :pagination="false"
                                        >
                                            <template
                                                #bodyCell="{ column, record }"
                                            >
                                                <template
                                                    v-if="
                                                        column.dataIndex ===
                                                        'product_id'
                                                    "
                                                >
                                                        {{record.product.item_id}}
                                                </template>
                                                <template v-if=" column.dataIndex === 'product_code' ">
                                                        {{record.product.item_code}}
                                                </template>
                                                <template v-if=" column.dataIndex === 'name' ">
                                                        {{record.product.name}}
                                                </template>
                                                <template v-if=" column.dataIndex === 'description' ">
                                                        {{ record.product.description }}
                                                </template>
                                                <template
                                                    v-if="
                                                        column.dataIndex ===
                                                        'subgroup2'
                                                    "
                                                >
                                                        {{
                                                            record.product.subgroup2
                                                        }}
                                                </template>
                                                <template
                                                    v-if="
                                                        column.dataIndex ===
                                                        'text1'
                                                    "
                                                >
                                                        {{
                                                            record.product.text1
                                                        }}
                                                </template>
                                                <template v-if=" column.dataIndex === 'sat' ">
                                                        {{
                                                            record.product.uom_buy_in !== null ? record.product.uom_buy_in.short_name : record.product.unit.short_name
                                                        }}
                                                </template>
                                                <template
                                                    v-if="
                                                        column.dataIndex ===
                                                        'single_unit_price'
                                                    "
                                                >
                                                    {{
                                                        formatAmountCurrency(
                                                            record.single_unit_price
                                                        )
                                                    }}
                                                </template>
                                                <template
                                                    v-if="
                                                        column.dataIndex ===
                                                        'total_discount'
                                                    "
                                                >
                                                    {{
                                                        formatAmountCurrency(
                                                            record.total_discount
                                                        )
                                                    }}
                                                </template>
                                                <template
                                                    v-if="
                                                        column.dataIndex ===
                                                        'total_tax'
                                                    "
                                                >
                                                    {{
                                                        formatAmountCurrency(
                                                            record.total_tax
                                                        )
                                                    }}
                                                </template>
                                                <template
                                                    v-if="
                                                        column.dataIndex ===
                                                        'subtotal'
                                                    "
                                                >
                                                    {{
                                                        formatAmountCurrency(
                                                            record.subtotal
                                                        )
                                                    }}
                                                </template>
                                            </template>
                                            <template #summary>
                                                <a-table-summary-row>
                                                    <a-table-summary-cell
                                                        :col-span="1"
                                                    >
                                                        <a-typography-text
                                                            strong
                                                        >
                                                            {{
                                                                $t(
                                                                    "common.total"
                                                                )
                                                            }}
                                                        </a-typography-text>
                                                    </a-table-summary-cell>
                                                    <a-table-summary-cell
                                                        :col-span="1"
                                                    >
                                                        <a-typography-text
                                                            strong
                                                        >
                                                            {{
                                                                totals.totalQuantity
                                                            }}
                                                        </a-typography-text>
                                                    </a-table-summary-cell>
                                                    <a-table-summary-cell
                                                        :col-span="1"
                                                    >
                                                    </a-table-summary-cell>
                                                    
                                                </a-table-summary-row>
                                            </template>
                                        </a-table>
                                    </div>
                                </a-col>
                            </a-row>
                        </a-tab-pane>
                    </a-tabs>
                </a-col>
            </a-row>
        </div>
    </div>
</template>

<script>
import { ref, createVNode, computed } from "vue";
import {
    LeftOutlined,
    PlusOutlined,
    EditOutlined,
    DeleteOutlined,
} from "@ant-design/icons-vue";
import { useI18n } from "vue-i18n";
import common from "../../../../common/composable/common";
import fields from "./fields";
import UserInfo from "../../../../common/components/user/UserInfo.vue";
import AddEdit from "./AddEdit.vue";
import PaymentStatus from "../../../../common/components/order/PaymentStatus.vue";
import OrderStatus from "../../../../common/components/order/OrderStatus.vue";
import datatable from "../../../../common/composable/datatable";

export default {
    props: ["selectedItem"],
    components: {
        PlusOutlined,
        EditOutlined,
        DeleteOutlined,
        LeftOutlined,
        UserInfo,
        AddEdit,
        PaymentStatus,
        OrderStatus,
    },
    setup(props, { emit }) {
        const {
            initPaymentData,
            orderWeightColumns,
            orderItemDetailsColumns,
        } = fields();
        const { formatAmountCurrency, permsArray, formatDate, formatDateTime } =
            common();
        const { t } = useI18n();
        const datatableVariables = datatable();

        const addEditVisible = ref(false);
        const addEditType = ref("add");
        const addEditUrl = ref("order-weight");
        const formData = ref({});
        const viewData = ref({});
        const editItemAmount = ref(0);
        //const activeKeyName =
        //    permsArray.value.includes("order_payments_view") ||
        //    permsArray.value.includes("admin")
        //        ? "payments"
        //        : "order_items";
        const activeKeyName = "order_items";
        const activeKey = ref(activeKeyName);

        const pageTitle = computed(() => {
            return addEditType.value == "add"
                ? t(`common.update_weight`)
                : t(`common.update_weight`);
        });

        const successMessage = computed(() => {
            return t(`weight.updated`);
        });

        const onClose = () => {
            emit("goBack");
        };

        const addItem = () => {
            addEditUrl.value = `order-weight`;
            addEditType.value = "add";
            formData.value = {
                ...initPaymentData,
                order_id: props.selectedItem.xid,
            };
            addEditVisible.value = true;
            editItemAmount.value = 0;
        };

        const addEditSuccess = (id) => {
            emit("reloadOrder");

            // If add action is performed then move page to first
            if (addEditType.value == "add") {
                formData.value = {
                    order_id: props.selectedItem.xid,
                    weigth: "",
                };
            }
            addEditVisible.value = false;
        };

        const onCloseAddEdit = () => {
            formData.value = {
                ...initPaymentData,
                order_id: props.selectedItem.xid,
            };
            addEditVisible.value = false;
            editItemAmount.value = 0;
        };

        const totals = computed(() => {
            let totalAmount = 0;
            let totalTax = 0;
            let totalDiscount = 0;
            let totalQuantity = 0;
            props.selectedItem.items.forEach((tableRowData) => {
                totalAmount += tableRowData.subtotal;
                totalTax += tableRowData.total_tax;
                totalDiscount += tableRowData.total_discount;
                totalQuantity += tableRowData.quantity;
            });
            return {
                totalAmount,
                totalTax,
                totalDiscount,
                totalQuantity,
            };
        });

        return {
            onClose,

            formatDate,
            formatDateTime,
            formatAmountCurrency,
            orderWeightColumns,
            orderItemDetailsColumns,
            activeKey,
            addEditSuccess,
            formData,
            addEditVisible,
            addItem,
            onCloseAddEdit,
            addEditUrl,
            addEditType,
            viewData,
            permsArray,
            editItemAmount,
            ...datatableVariables,
            pageTitle,
            successMessage,
            totals,
        };
    },
};
</script>

<style lang="less">
.order-details {
    .ant-descriptions-item {
        padding-bottom: 5px;
    }
}
</style>
