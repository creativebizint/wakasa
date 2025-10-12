<template>
    <AdminPageHeader>
        <template #header>
            <a-page-header :title="$t(`menu.placement_out_priority`)" class="p-0" />
        </template>
        <template #breadcrumb>
            <a-breadcrumb separator="-" style="font-size: 12px">
                <a-breadcrumb-item>
                    <router-link :to="{ name: 'admin.dashboard.index' }">
                        {{ $t(`menu.dashboard`) }}
                    </router-link>
                </a-breadcrumb-item>
                <a-breadcrumb-item>
                    {{ $t(`menu.placement_out_priority`) }}
                </a-breadcrumb-item>
            </a-breadcrumb>
        </template>
    </AdminPageHeader>

    <admin-page-filters>
        <a-row :gutter="[16, 16]">
            <a-col :xs="24" :sm="24" :md="12" :lg="10" :xl="10">
                <a-space>
                    <a-button
                        v-if="
                            selectedRowIds.length > 0 &&
                            (permsArray.includes('order_fullfillment_view') ||
                                permsArray.includes('admin'))
                        "
                        type="primary"
                        @click="showUnassignConfirm"
                        danger
                    >
                        <template #icon></template>
                        {{ $t("common.unassign") }}
                    </a-button>
                </a-space>
            </a-col>    
            <a-col :xs="24" :sm="24" :md="12" :lg="14" :xl="14">
                <a-row :gutter="[16, 16]" justify="end">
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
            :priority="priority"
            @onRowSelection="(selectedIds) => (selectedRowIds = selectedIds)"
        />
    </admin-page-table-content>
</template>

<script>
import { onMounted, watch, ref } from "vue";
import { PlusOutlined, DeleteOutlined } from "@ant-design/icons-vue";
import { useRoute } from "vue-router";
import { Modal, notification } from "ant-design-vue"; // Ensure Modal and notification are imported
import common from "../../../../common/composable/common";
import OrderTable from "../../../components/order/RegistrationCodeTableOut.vue";
import DateRangePicker from "../../../../common/components/common/calendar/DateRangePicker.vue";
import AdminPageHeader from "../../../../common/layouts/AdminPageHeader.vue";
import QueueImport from "../../../../common/core/ui/QueueImport.vue";

// Fallback for axios if not globally available
const axiosAdmin = window.axiosAdmin || (typeof axios !== 'undefined' ? axios : null);

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
        
        const priority = 1;
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
            warehouse_id: undefined,
        });

        const sampleFileUrl = ref([]);

        onMounted(() => {
            fetchUsers();
            fetchWarehouses();
            sampleFileUrl.value = window.config[`${orderType.value}_sample_file`];
            console.log('Component mounted, orderType:', orderType.value); // Debug mount
        });

        const fetchUsers = () => {
            if (!axiosAdmin) {
                console.error('axiosAdmin is not defined');
                return;
            }
            const usersPromise = axiosAdmin.get(`suppliers?limit=10000`);

            Promise.all([usersPromise]).then(([usersResponse]) => {
                users.value = usersResponse.data;
            }).catch(error => {
                console.error('Error fetching users:', error);
            });
        };

        const fetchWarehouses = () => {
            if (!axiosAdmin) {
                console.error('axiosAdmin is not defined');
                return;
            }
            const warehousesPromise = axiosAdmin.get("warehouses?limit=10000");

            Promise.all([warehousesPromise]).then(([warehousesResponse]) => {
                const warehouses_all = [{ name: "All", profile_image: "", xid: "" }];
                const warehouses__ = warehouses_all.concat(warehousesResponse.data);
                warehouses.value = warehouses__;
            }).catch(error => {
                console.error('Error fetching warehouses:', error);
            });
        };

        watch(
            () => route.meta.orderType,
            (newVal) => {
                if (
                    [
                        "purchases",
                        "place_in",
                        "inventory_in",
                        "inventory_out",
                        "purchase-returns",
                        "sales",
                        "sales-returns",
                        "quotations",
                    ].includes(newVal)
                ) {
                    orderType.value = route.meta.orderType;
                    priority.value = 1;
alert('dddd');
                    filters.value = {
                        payment_status: "all",
                        user_id: undefined,
                        dates: [],
                        searchColumn: "invoice_number",
                        searchString: "",
                        item_id: "",
                        warehouse_id: undefined,
                    };

                    fetchUsers();
                    fetchWarehouses();

                    if (serachDateRangePicker.value) {
                        serachDateRangePicker.value.resetPicker();
                    }
                }

                sampleFileUrl.value = window.config[`${orderType.value}_sample_file`];
                console.log('Route meta changed, new orderType:', newVal); // Debug watch
            }
        );

        const showUnassignConfirm = () => {
            console.log('showUnassignConfirm clicked, selectedRowIds:', selectedRowIds.value); // Debug click
            if (!Modal) {
                console.error('Modal is not available');
                return;
            }

            Modal.confirm({
                title: 'Do you want to unassign the selected items?',
                okText: 'Yes',
                okType: 'primary',
                cancelText: 'No',
                onOk() {
                    console.log('Confirm OK, selectedRowIds:', selectedRowIds.value); // Debug confirm
                    const selectedIds = selectedRowIds.value;
                    if (selectedIds.length === 0) {
                        Modal.error({
                            title: 'Error',
                            content: 'Please select at least one item to unassign.',
                        });
                        return;
                    }

//                    if (!route.params.id) {
//                        Modal.error({
//                            title: 'Error',
//                            content: 'Order ID is missing.',
//                        });
//                        return;
//                    }

                    const data = {
                        item_ids: selectedIds,
                    };

                    if (!axiosAdmin) {
                        console.error('axiosAdmin is not defined, cannot make API call');
                        Modal.error({
                            title: 'Error',
                            content: 'API client is not available.',
                        });
                        return;
                    }

                    axiosAdmin.post(`unassign-picking`, data)
                        .then((res) => {
                            console.log('Unassign response:', res);
                            if (orderTableRef.value && orderTableRef.value.setUrlData) {
                                orderTableRef.value.setUrlData(); // Refresh table
                            } else {
                                console.warn('orderTableRef or setUrlData not available');
                            }
                            notification.success({
                                message: 'Success',
                                description: 'Items have been unassigned successfully.',
                                placement: 'bottomRight',
                            });
                        })
                        .catch((error) => {
                            console.error('Unassign error:', error);
                            Modal.error({
                                title: 'Error',
                                content: 'Failed to unassign items. Please try again.',
                            });
                        });
                },
                onCancel() {
                    console.log('Confirm cancelled'); // Debug cancel
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
            priority,
            serachDateRangePicker,
            selectedRowIds,
            orderTableRef,
            warehouses,
            sampleFileUrl,
            showUnassignConfirm,
        };
    },
};
</script>