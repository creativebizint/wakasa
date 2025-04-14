<template>
    <AdminPageHeader>
        <template #header>
            <a-page-header :title="$t(`menu.barcode_registration`)" class="p-0" />
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
                        orderPageObject.type == "inventory_out" ||
                        orderPageObject.type == "sales-returns" ||
                        orderPageObject.type == "quotations"
                            ? $t(`menu.inventory_out`)
                            : $t(`menu.inventory_in`)
                    }}
                </a-breadcrumb-item>
                <a-breadcrumb-item>
                    {{ $t(`menu.barcode_registration`) }}
                </a-breadcrumb-item>
            </a-breadcrumb>
        </template>
    </AdminPageHeader>

    <admin-page-filters>
        <a-row :gutter="[16, 16]">
            <a-col :xs="24" :sm="24" :md="12" :lg="10" :xl="10">
                <a-space>

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
                    <a-col :xs="24" :sm="24" :md="12" :lg="8" :xl="6">
                        <a-input-search
                            style="width: 100%"
                            v-model:value="filters.item_id"
                            show-search
                            :placeholder="
                                $t('common.placeholder_search_text', [
                                    $t('product.item_id'),
                                ])
                            "
                        />
                    </a-col>
                    <a-col :xs="24" :sm="24" :md="8" :lg="8" :xl="6">
                        <a-select
                            v-model:value="filters.user_id"
                            :placeholder="
                                $t('common.select_default_text', [
                                    $t(`${orderType}.user`),
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
import OrderTable from "../../../components/order/RegistrationCodeTable.vue";
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

        const warehouses = ref([]);
        const users = ref([]);
        const serachDateRangePicker = ref(null);

        const selectedRowIds = ref([]);
        const orderTableRef = ref(null);

        const filters = ref({
            payment_status: "all",
            user_id: undefined,
            dates: [],
            searchColumn: "invoice_number",
            searchString: "",
            item_id: "",

            //* ADDENDUM
            warehouse_id: undefined,
        });

        const sampleFileUrl = ref([]);

        onMounted(() => {
            fetchUsers();
            fetchWarehouses();
            sampleFileUrl.value =
                window.config[orderType.value+`_sample_file`];
        });

        const fetchUsers = () => {
            const usersPromise = axiosAdmin.get(
                `${orderPageObject.value.userType}?limit=10000`
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
                    newVal == "inventory_in" ||
                    newVal == "inventory_out" ||
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
                        item_id: "",
                    };

                    fetchUsers();
                    fetchWarehouses();

                    serachDateRangePicker.value.resetPicker();
                }

                sampleFileUrl.value =
                window.config[orderType.value+`_sample_file`];

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
