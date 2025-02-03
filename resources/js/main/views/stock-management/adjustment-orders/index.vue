<template>
    <AdminPageHeader>
        <template #header>
            <a-page-header :title="$t(`menu.stock_adjustment`)" class="p-0" />
        </template>
        <template #breadcrumb>
            <a-breadcrumb separator="-" style="font-size: 12px">
                <a-breadcrumb-item>
                    <router-link :to="{ name: 'admin.dashboard.index' }">
                        {{ $t(`menu.dashboard`) }}
                    </router-link>
                </a-breadcrumb-item>
                <a-breadcrumb-item>
                    {{ $t(`menu.stock_adjustment`) }}
                </a-breadcrumb-item>
            </a-breadcrumb>
        </template>
    </AdminPageHeader>

    <admin-page-filters>
        <a-row :gutter="[16, 16]">
            <a-col :xs="24" :sm="24" :md="12" :lg="10" :xl="10">
                <a-space>
                    <template
                        v-if="
                            permsArray.includes('stock_adjustments_create') ||
                            permsArray.includes('admin')
                        "
                    >
                        <router-link
                            :to="{
                                name: `admin.stock.${orderPageObject.type}.create`,
                            }"
                        >
                            <a-button type="primary">
                                <PlusOutlined />
                                {{ $t(`${orderPageObject.langKey}.add`) }}
                            </a-button>
                        </router-link>
                    </template>
                    <QueueImport
                        :pageTitle="$t('stock_adjustment.import')"
                        :sampleFileUrl="sampleFileUrl"
                        context="stock-adjustment-orders"
                        bus="stock-adjustment-orders"
                        @onUploadSuccess="orderTableRef.setUrlData()"
                    />
                    <a-button
                        v-if="
                            selectedRowIds.length > 0 &&
                            (permsArray.includes('stock_adjustments_delete') ||
                                permsArray.includes('admin'))
                        "
                        type="primary"
                        @click="orderTableRef.showSelectedDeleteConfirm"
                        danger
                    >
                        <template #icon><DeleteOutlined /></template>
                        {{ $t("common.delete") }}
                    </a-button>
                </a-space>
            </a-col>
            <a-col :xs="24" :sm="24" :md="12" :lg="14" :xl="14">
                <a-row :gutter="[16, 16]" justify="end">
                    <a-col :xs="24" :sm="24" :md="12" :lg="8" :xl="6">
                        <a-input-search
                            style="width: 100%"
                            v-model:value="filters.searchString"
                            show-search
                            :placeholder="
                                $t('common.placeholder_search_text', [
                                    $t('stock.invoice_number'),
                                ])
                            "
                        />
                    </a-col>

                    <a-col :xs="24" :sm="24" :md="8" :lg="8" :xl="6">
                        <a-select
                            v-model:value="filters.warehouse_id"
                            :placeholder="
                                $t('common.select_default_text', [
                                    $t('warehouse.warehouse'),
                                ])
                            "
                            :allowClear="true"
                            style="width: 100%"
                            optionFilterProp="title"
                            show-search
                            @change="warehouseChanged"
                        >
                            <a-select-option
                                v-for="warehouse in warehouses"
                                :key="warehouse.xid"
                                :title="warehouse.name"
                                :value="warehouse.xid"
                            >
                                {{ warehouse.name }}
                            </a-select-option>
                        </a-select>
                    </a-col>

                    <a-col :xs="24" :sm="24" :md="8" :lg="8" :xl="6">
                        <DateRangePicker
                            ref="serachDateRangePicker"
                            @dateTimeChanged="
                                (changedDateTime) =>
                                    (filters.dates = changedDateTime)
                            "
                        />
                    </a-col>
                </a-row>
            </a-col>
        </a-row>
    </admin-page-filters>

    <admin-page-table-content>
        <StockAdjustmentOrderTable
            ref="orderTableRef"
            :orderType="orderType"
            :filters="filters"
            tableSize="middle"
            :bordered="true"
            :selectable="true"
            @onRowSelection="(selectedIds) => (selectedRowIds = selectedIds)"
        />
    </admin-page-table-content>
</template>
<script>
import { onMounted, watch, ref } from "vue";
import { PlusOutlined, DeleteOutlined } from "@ant-design/icons-vue";
import { useRoute } from "vue-router";
import common from "../../../../common/composable/common";
import StockAdjustmentOrderTable from "../../../components/stock-adjustment/StockAdjustmentOrderTable.vue";
import DateRangePicker from "../../../../common/components/common/calendar/DateRangePicker.vue";
import AdminPageHeader from "../../../../common/layouts/AdminPageHeader.vue";
import QueueImport from "../../../../common/core/ui/QueueImport.vue";

export default {
    components: {
        PlusOutlined,
        DeleteOutlined,

        StockAdjustmentOrderTable,
        DateRangePicker,
        AdminPageHeader,
        QueueImport,
    },
    setup() {
        const { formatAmountCurrency, permsArray, orderPageObject, orderType } =
            common();
        const route = useRoute();
        const warehouses = ref([]);
        const serachDateRangePicker = ref(null);

        const selectedRowIds = ref([]);
        const orderTableRef = ref(null);

        const filters = ref({
            dates: [],
            searchColumn: "invoice_number",
            searchString: "",
            warehouse_id: undefined,
        });

        const sampleFileUrl = ref([]);

        onMounted(() => {
            fetchWarehouses();
            warehouseChanged(filters.value.warehouse_id);
            sampleFileUrl.value = window.config["stock-adjustment_sample_file"];
        });

        const fetchWarehouses = () => {
            const warehousesPromise = axiosAdmin.get("warehouses?limit=10000");

            Promise.all([warehousesPromise]).then(([warehousesResponse]) => {
                warehouses.value = warehousesResponse.data;
                warehouseChanged(warehouses.value[0]["xid"]);
            });
        };

        const warehouseChanged = (selectedWarehouseId) => {
            axiosAdmin.post("change-warehouse", {
                warehouse_id: selectedWarehouseId,
            });
        };

        watch(
            () => route.meta.orderType,
            (newVal, oldVal) => {
                if (newVal == "stock-adjustment-orders") {
                    orderType.value = route.meta.orderType;

                    filters.value = {
                        dates: [],
                        searchColumn: "invoice_number",
                        searchString: "",
                        warehouse_id: undefined,
                    };

                    fetchWarehouses();

                    serachDateRangePicker.value.resetPicker();
                }
            }
        );

        return {
            permsArray,
            formatAmountCurrency,
            orderPageObject,
            orderType,

            filters,
            serachDateRangePicker,

            selectedRowIds,
            orderTableRef,

            warehouses,
            warehouseChanged,
            sampleFileUrl,
        };
    },
};
</script>
