<template>
    <AdminPageHeader>
        <template #header>
            <a-page-header :title="$t(`menu.${orderType}`)" class="p-0" />
        </template>
        <template #breadcrumb>
            <a-breadcrumb separator="-" style="font-size: 12px">
                <a-breadcrumb-item>
                    <router-link :to="{ name: 'admin.dashboard.index' }">
                        {{ $t(`menu.dashboard`) }}
                    </router-link>
                </a-breadcrumb-item>
                <a-breadcrumb-item>
                    {{
                        $t(`menu.${orderType}`)
                    }}
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
                            permsArray.includes(`inventory_in_create`) ||
                            permsArray.includes('admin')
                        "
                    >
                        <router-link
                            :to="{
                                name: `admin.${orderType}.create`,
                            }"
                        >
                            <a-button type="primary">
                                <PlusOutlined />
                                {{ $t(`${orderType}.add`) }}
                            </a-button>
                        </router-link>
                    </template>
                    <QueueImport
                        :pageTitle="$t(`${orderType}.import`)"
                        :sampleFileUrl="sampleFileUrl"
                        :context="orderType"
                        :bus="orderType"
                        @onUploadSuccess="orderTableRef.setUrlData()"
                    />
                    <a-button
                        v-if="
                            selectedRowIds.length > 0 &&
                            (permsArray.includes(`inventory_in_view`) || permsArray.includes(`inventory_out_view`) ||
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
                            v-model:value="filters.user_id"
                            :placeholder="
                                $t('common.select_default_text', [
                                    $t(`order_in.user`),
                                ])
                            "
                            :allowClear="true"
                            style="width: 100%"
                            optionFilterProp="title"
                            show-search
                        >
                            <a-select-option
                                v-for="user in users"
                                :key="user.xid"
                                :title="user.name"
                                :value="user.xid"
                            >
                                {{ user.name }}
                            </a-select-option>
                        </a-select>
                    </a-col>

                    <!--* ADDENDUM -->
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
                                (changedDateTime) => (filters.dates = changedDateTime)
                            "
                        />
                    </a-col>
                </a-row>
            </a-col>
        </a-row>
    </admin-page-filters>

    <admin-page-table-content>
        <OrderTable
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
import OrderTable from "../../../components/order/OrderTable.vue";
import DateRangePicker from "../../../../common/components/common/calendar/DateRangePicker.vue";
import AdminPageHeader from "../../../../common/layouts/AdminPageHeader.vue";
import QueueImport from "../../../../common/core/ui/QueueImport.vue";

export default {
    components: {
        PlusOutlined,
        DeleteOutlined,

        OrderTable,
        DateRangePicker,
        AdminPageHeader,
        QueueImport,
    },
    setup() {
        const {
            formatAmountCurrency,
            orderType,
            orderPageObject,
            orderStatus,
            permsArray,
        } = common();
        const route = useRoute();

        const users = ref([]);
        const warehouses = ref([]);
        const serachDateRangePicker = ref(null);

        const selectedRowIds = ref([]);
        const orderTableRef = ref(null);

        const filters = ref({
            payment_status: "all",
            user_id: undefined,
            dates: [],
            searchColumn: "invoice_number",
            searchString: "",
        });

        const sampleFileUrl = ref([]);

        onMounted(() => {
            fetchUsers();
            fetchWarehouses();
            sampleFileUrl.value =
                window.config[`stock_in_sample_file`];
        });

        const fetchUsers = () => {
            const usersPromise = axiosAdmin.get(
                `suppliers?limit=10000`
            );

            Promise.all([usersPromise]).then(([usersResponse]) => {
                users.value = usersResponse.data;
            });
        };

        const fetchWarehouses = () => {
            const warehousesPromise = axiosAdmin.get("warehouses?limit=10000");

            Promise.all([warehousesPromise]).then(([warehousesResponse]) => {
                var warehouses_all = [
                    { name: "All", profile_image: "", xid: "" },
                ];
                var warehouses__ = warehouses_all.concat(
                    warehousesResponse.data
                );
                warehouses.value = warehouses__;
            });
        };

        watch(
            () => route.meta.orderType,
            (newVal, oldVal) => {
                if (
                    newVal == "purchases" ||
                    newVal == "purchase-returns" ||
                    newVal == "sales" ||
                    newVal == "sales-returns" ||
                    newVal == "quotations"
                ) {
                    orderType.value = route.meta.orderType;

                    filters.value = {
                        payment_status: "all",
                        user_id: undefined,
                        dates: [],
                        searchColumn: "invoice_number",
                        searchString: "",

                        //* ADDENDUM
                        warehouse_id: undefined,
                    };

                    fetchUsers();
                    fetchWarehouses();

                    serachDateRangePicker.value.resetPicker();
                }

                sampleFileUrl.value =
                    window.config[`order_in_sample_file`];
            }
        );

        return {
            orderPageObject,

            permsArray,
            orderStatus,
            formatAmountCurrency,

            users,

            filters,
            orderType,
            serachDateRangePicker,

            selectedRowIds,
            orderTableRef,

            //* ADDENDUM
            warehouses,
            sampleFileUrl,
        };
    },
};
</script>
