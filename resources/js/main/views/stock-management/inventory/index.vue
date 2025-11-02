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
                <a-space>
                    <template
                        v-if="
                            permsArray.includes(`${orderPageObject.permission}_create`) ||
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
                            (permsArray.includes(`${orderPageObject.permission}_view`) ||
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
        </a-row>    
        <a-row :gutter="[16, 16]" justify="end">
  <a-col :xs="24" :sm="24" :md="12" :lg="14" :xl="14">
    <a-row :gutter="[16, 16]" justify="end">
      <a-col :xs="4" :sm="4" :md="4" :lg="4" :xl="4">
        <a-input-search style="width: 100%" v-model:value="filters.searchString" show-search :placeholder="$t('common.placeholder_search_text', [$t(`${orderType}.invoice_number`)])" />
      </a-col>
      <a-col :xs="4" :sm="4" :md="4" :lg="4" :xl="4" style="display:none">
        <a-select v-model:value="filters.status" :placeholder="$t('common.select_default_text', [$t(`common.status`)])" :allowClear="true" style="width: 100%" optionFilterProp="title" show-search>
          <a-select-option :key="'Ordered'" :title="'Ordered'" :value="'Ordered'">Ordered</a-select-option>
          <a-select-option :key="'Picking'" :title="'Picking'" :value="'Picking'">Picking</a-select-option>
          <a-select-option :key="'Qc'" :title="'Qc'" :value="'Qc'">QC</a-select-option>
        </a-select>
      </a-col>
      <a-col :xs="4" :sm="4" :md="4" :lg="4" :xl="4" style="display:none">
        <a-select v-model:value="filters.priority" :placeholder="$t('common.select_default_text', [$t(`common.priority`)])" :allowClear="true" style="width: 100%;display:none" optionFilterProp="title" show-search>
          <a-select-option :key="'ditunggu'" :title="'ditunggu'" :value="'ditunggu'">ditunggu</a-select-option>
          <a-select-option :key="'pesawat'" :title="'pesawat'" :value="'pesawat'">pesawat</a-select-option>
          <a-select-option :key="'segera'" :title="'segera'" :value="'segera'">segera</a-select-option>
          <a-select-option :key="'normal'" :title="'normal'" :value="'normal'">normal</a-select-option>
        </a-select>
      </a-col>
      <a-col :xs="4" :sm="4" :md="4" :lg="4" :xl="4">
        <a-select v-model:value="filters.user_id" :placeholder="$t('common.select_default_text', [$t(`${orderType}.user`)])" :allowClear="true" style="width: 100%" optionFilterProp="title" show-search>
          <a-select-option v-for="user in users" :key="user.xid" :title="user.name" :value="user.xid">{{ !user.code ? user.name : user.code }}</a-select-option>
        </a-select>
      </a-col>
      <a-col :xs="4" :sm="4" :md="4" :lg="4" :xl="4">
        <DateRangePicker ref="serachDateRangePicker" @dateTimeChanged="(changedDateTime) => (filters.dates = changedDateTime)" />
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

            //* ADDENDUM
            warehouse_id: undefined,
        });

        const sampleFileUrl = ref([]);

        onMounted(() => {
            console.log("window.config:", window.config);
            console.log("Permissions:", permsArray.value);
            fetchUsers();
            fetchWarehouses();
            console.log("Users:", users.value);
            console.log("Warehouses:", warehouses.value);
            sampleFileUrl.value =
                window.config[orderType.value+`_sample_file`];
        });

        const fetchUsers = () => {
            const usersPromise = axiosAdmin.get(
                `${orderPageObject.value.userType}?limit=10000`
            );

            Promise.all([usersPromise]).then(([usersResponse]) => {
                users.value = usersResponse.data;
            })
            .catch((error) => {
                console.error("Error fetching users:", error);
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
            })
            .catch((error) => {
                console.error("Error fetching users:", error);
            });
        };

        watch(
            () => filters.value,
            (newFilters) => {
                console.log("Filters updated:", newFilters);
            },
            { deep: true }
        );

        watch(
            () => route.meta.orderType,
            (newVal, oldVal) => {
                //console.log("OrderType changed:", newVal, oldVal);
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
