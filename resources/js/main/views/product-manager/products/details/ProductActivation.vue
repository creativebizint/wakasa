<template>
    <a-row>
        <a-col :span="24">
            <div v-if="!table.loading" class="table-responsive">
                <a-table
                    :columns="productActivationColumns"
                    :row-key="(record) => record.xid"
                    :data-source="table.data"
                    :pagination="table.pagination"
                    :loading="table.loading"
                    @change="handleTableChange"
                >
                    <template #bodyCell="{ column, record }">
                        <template v-if="column.dataIndex === 'string'">
                            {{record.string}}
                        </template>
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
                    </template>                    
                </a-table>
            </div>
        </a-col>
    </a-row>
</template>

<script>
import { defineComponent, ref, onMounted, computed } from "vue";
import datatable from "../../../../../common/composable/datatable";
import common from "../../../../../common/composable/common";
import fields from "./fields";

export default defineComponent({
    props: ["product"],
    setup(props) {
        const { productActivationColumns, orderItemsHashableColumns } = fields();
        const {
            formatDate,
            formatDateTime,
            formatAmountCurrency,
            getOrderTypeFromstring,
        } = common();
        const datatableVariables = datatable();

        onMounted(() => {
            datatableVariables.tableUrl.value = {
                url: "barcode?fields=id,xid,string,isactive,order_item,item_id,order_item:order{id,xid,invoice_number},order_item_out,order_item_out:order{id,xid,invoice_number},reg_bungkus_id,fk_reg_bungkus_id,nik,box_id,qty_bungkus,reason,comment,product{id,xid,name,kemasan_jual_qty}",
                filters: {
                    item_id: props.product.item_id,
                },
            };
            datatableVariables.table.sorter = {
                field: "updated_at",
                order: "desc",
            };

            datatableVariables.fetch({
                page: 1,
            });
        });

        const totals = computed(() => {
            let totalAmount = 0;
            let totalTax = 0;
            let totalDiscount = 0;
            let totalQuantity = 0;
            datatableVariables.table.data.forEach((tableRowData) => {
                totalAmount += tableRowData.subtotal;
                totalTax += tableRowData.total_tax;
                totalDiscount += tableRowData.total_discount;
                totalQuantity += tableRowData.quantity;
            });
            return {
                totalAmount,
                totalTax,
                totalDiscount,
                totalQuantity
            };
        });

        return {
            productActivationColumns,
            orderItemsHashableColumns,
            ...datatableVariables,
            totals,
            formatDate,
            formatDateTime,
            formatAmountCurrency,
            getOrderTypeFromstring,
        };
    },
});
</script>
