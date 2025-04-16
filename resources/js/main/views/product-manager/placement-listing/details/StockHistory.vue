<template>
    <a-row>
        <a-col :span="24">
            <div v-if="!table.loading" class="table-responsive">
                <a-table
                    :columns="stockHistoryColumns"
                    :row-key="(record) => record.xid"
                    :data-source="table.data"
                    :pagination="table.pagination"
                    :loading="table.loading"
                    @change="handleTableChange"
                >
                    <template #bodyCell="{ column, record }">
                        <template v-if="column.dataIndex === 'order_date'">
                            {{
                                record.order_date != "0000-00-00 00:00:00"
                                    ? formatDateTime(record.order_date)
                                    : "-"
                            }}
                        </template>
                        <template v-if="column.dataIndex === 'order_type'">
                            {{ getOrderTypeFromstring(record.order_type) }}
                        </template>
                        <template v-if="column.dataIndex === 'from'">
                            <span
                                v-if="
                                    record.order_type === 'purchases' ||
                                    record.order_type === 'sales-returns'
                                "
                            >
                                {{ record.user }}
                            </span>
                            <span
                                v-else-if="
                                    record.order_type === 'purchase-returns' ||
                                    record.order_type === 'sales'
                                "
                            >
                                {{ record.warehouse }}
                            </span>
                            <span
                                v-else-if="
                                    record.order_type === 'stock-transfers' ||
                                    record.order_type ===
                                        'stock-transfer-returns'
                                "
                            >
                                {{ record.from_warehouse }}
                            </span>
                            <span v-else> - </span>
                        </template>
                        <template v-if="column.dataIndex === 'to'">
                            <span
                                v-if="
                                    record.order_type === 'purchases' ||
                                    record.order_type === 'sales-returns' ||
                                    record.order_type === 'stock-transfers' ||
                                    record.order_type ===
                                        'stock-transfer-returns'
                                "
                            >
                                {{ record.warehouse }}
                            </span>
                            <span
                                v-else-if="
                                    record.order_type === 'purchase-returns' ||
                                    record.order_type === 'sales'
                                "
                            >
                                {{ record.user }}
                            </span>
                            <span v-else> - </span>
                        </template>
                        <template v-if="column.dataIndex === 'quantity_in'">
                            <span v-if="record.operation === 'add'">
                                {{ record.quantity }}
                            </span>
                            <span v-else> 0 </span>
                            {{ record.unit }}
                        </template>
                        <template v-if="column.dataIndex === 'quantity_out'">
                            <span v-if="record.operation === 'subtract'">
                                {{ record.quantity }}
                            </span>
                            <span v-else> 0 </span>
                            {{ record.unit }}
                        </template>
                        <template v-if="column.dataIndex === 'balance'">
                            {{ record.balance }} {{ record.unit }}
                        </template>
                    </template>
                </a-table>
            </div>
        </a-col>
    </a-row>
</template>

<script>
import { defineComponent, ref, onMounted, watch } from "vue";
import datatable from "../../../../../common/composable/datatable";
import common from "../../../../../common/composable/common";
import fields from "./fields";

export default defineComponent({
    props: ["filters"],
    setup(props) {
        const { stockHistoryColumns, stockHistoryHashableColumns } = fields();
        const {
            formatDate,
            formatDateTime,
            formatAmountCurrency,
            getOrderTypeFromstring,
        } = common();
        const datatableVariables = datatable();

        onMounted(() => {
            datatableVariables.tableUrl.value = {
                url: `stock-changes?product_id=${props.filters.product.xid}`,
            };
            datatableVariables.hashable.value = [
                ...stockHistoryHashableColumns,
            ];

            datatableVariables.fetch({
                page: 1,
            });
        });

        return {
            props,
            stockHistoryColumns,
            ...datatableVariables,

            formatDate,
            formatDateTime,
            formatAmountCurrency,
            getOrderTypeFromstring,
        };
    },
});
</script>
