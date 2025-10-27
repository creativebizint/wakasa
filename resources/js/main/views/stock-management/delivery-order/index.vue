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
                    {{ $t(`menu.${orderType}`) }}
                </a-breadcrumb-item>
            </a-breadcrumb>
        </template>
    </AdminPageHeader>

    <admin-page-filters>
        <a-row :gutter="[16, 16]">
            <a-col :xs="24" :sm="24" :md="12" :lg="10" :xl="10">
<!--                <a-space>
                    <template
                        v-if="
                            permsArray.includes(`${orderPageObject.permission}_create`) ||
                            permsArray.includes('admin')
                        "
                    >
                        <router-link
                            :to="{
                                name: `admin.delivery_order.create`,
                            }"
                        >
                            <a-button type="primary">
                                <PlusOutlined />
                                {{ $t(`${orderType}.add`) }}
                            </a-button>
                        </router-link>
                    </template>

                </a-space>-->
                
                    <a-space>
                    <a-button
                        type="primary"
                        @click="lockConfirm"
                        danger
                    >
                        <template #icon></template>
                        {{ $t("common.lock") }}
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
                                    $t(`${orderType}.invoice_number`),
                                ])
                            "
                        />
                    </a-col>
                    <a-col :xs="24" :sm="24" :md="12" :lg="8" :xl="6">
                        <a-input-search
                            style="width: 100%"
                            v-model:value="filters.invoice_number"
                            show-search
                            :placeholder="
                                $t('common.placeholder_search_text', [
                                    $t(`common.invoice_number`),
                                ])
                            "
                            @search="onInvoiceSearch"
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
import OrderTable from "../../../components/order/OrderTable.vue";
import DateRangePicker from "../../../../common/components/common/calendar/DateRangePicker.vue";
import AdminPageHeader from "../../../../common/layouts/AdminPageHeader.vue";
import QueueImport from "../../../../common/core/ui/QueueImport.vue";
import { Modal } from 'ant-design-vue'; // Import Modal for confirmationimport { Modal } from 'ant-design-vue'; // Import Modal for confirmation
import apiAdmin from "../../../../common/composable/apiAdmin";

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
        const { addEditRequestAdmin, loading, rules } = apiAdmin();
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
            invoice_number: "",

            //* ADDENDUM
            warehouse_id: undefined,
        });

        const sampleFileUrl = ref([]);

        onMounted(() => {
            fetchUsers();
            fetchWarehouses();
            sampleFileUrl.value = window.config[orderType.value+`_sample_file`];
        
            // Set invoice_number from query parameter 'reference'
            const refference = route.query.refference;
            if (refference) {
                filters.value.invoice_number = refference;
                console.log('Set filters.invoice_number from query:', refference);
                // Trigger table filter
                if (orderTableRef.value && orderTableRef.value.fetchOrders) {
                    orderTableRef.value.fetchOrders();
                }
            }    
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
            () => route.query.refference,
            (newReference) => {
                console.log('Route query changed to:', newReference, 'at', new Date().toISOString());
                filters.value.invoice_number = newReference || undefined;
                console.log('filters.invoice_number updated to:', filters.value.invoice_number, 'at', new Date().toISOString());
                nextTick(() => {
                    if (orderTableRef.value?.fetchOrders) {
                        console.log('Triggering fetchOrders at:', new Date().toISOString());
                        orderTableRef.value.fetchOrders();
                    }
                });
            }
        );

        watch(
            () => filters.value,
            () => {
                if (orderTableRef.value?.fetchOrders) {
                    console.log('Filters changed, triggering fetchOrders at:', new Date().toISOString());
                    orderTableRef.value.fetchOrders();
                }
            },
            { deep: true }
        );

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
                    };

                    fetchUsers();
                    fetchWarehouses();

                    serachDateRangePicker.value.resetPicker();
                }

                sampleFileUrl.value =
                window.config[orderType.value+`_sample_file`];

            }
        );

        const lockConfirm = () => {
            Modal.confirm({
                title: 'Do you want to lock delivery order?',
                okText: 'Yes',
                okType: 'primary',
                cancelText: 'No',
                onOk() {
                    // Prepare data to send
                    const selectedIds = orderTableRef.value?.table?.selectedRowKeys || [];
                if (selectedIds.length === 0) {
                    Modal.error({
                        title: 'Error',
                        content: 'Please select at least one item to assign.',
                    });
                    return;
                }

                var data = {
                    item_ids: selectedIds.join(",")
                }

                addEditRequestAdmin({
                    url: `lock-daftar-packing`,
                    data: data,
                    successMessage: 'ok',
                    success: (res) => {
                        console.log(res);
                        orderTableRef.value.setUrlData();                        
                    },
                });
            
            
                },
                onCancel() {
                    // Do nothing or add custom cancel logic
                },
            });
        };
        
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
            lockConfirm
        };
    },
};
</script>
