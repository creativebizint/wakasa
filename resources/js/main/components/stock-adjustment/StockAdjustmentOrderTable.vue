<template>
    <a-row>
        <a-col :span="24">
            <div class="table-responsive">
                <a-table
                    :row-selection="
                        selectable && orderType != 'online-orders'
                            ? {
                                  selectedRowKeys: table.selectedRowKeys,
                                  onChange: (rowKeys, rowValues) => {
                                      onRowSelectChange(rowKeys);
                                      $emit('onRowSelection', rowKeys);
                                  },
                                  getCheckboxProps: getCheckboxProps,
                              }
                            : null
                    "
                    :columns="columns"
                    :row-key="(record) => record.xid"
                    :data-source="table.data"
                    :pagination="table.pagination"
                    :loading="table.loading"
                    @change="handleTableChange"
                    :bordered="bordered"
                    :size="tableSize"
                >
                    <template #bodyCell="{ column, record, index }">
                        <template v-if="column.dataIndex === 'date'">
                            {{ formatDate(record.date) }}
                        </template>
                        <template
                            v-if="
                                column.dataIndex === 'created_by' &&
                                record.created_by
                            "
                        >
                            <div>
                                <a-badge>
                                    <a-avatar
                                        :size="30"
                                        :src="
                                            record.created_by.profile_image_url
                                        "
                                    />
                                    {{ record.created_by.name }}
                                </a-badge>
                            </div>
                        </template>
                        <template v-if="column.dataIndex === 'warehouse'">
                            <span
                                v-if="record.warehouse && record.warehouse.xid"
                            >
                                {{ record.warehouse.name }}
                            </span>
                        </template>
                        <template v-if="column.dataIndex === 'total_items'">
                            {{ record.total_items }}
                        </template>
                        <template
                            v-if="column.dataIndex === 'total_quantities'"
                        >
                            <a-typography-text
                                v-if="record.adjustment_type == 'add'"
                                type="success"
                                strong
                            >
                                +{{ record.total_quantity }}
                            </a-typography-text>
                            <a-typography-text v-else type="danger" strong>
                                -{{ record.total_quantity }}
                            </a-typography-text>
                        </template>
                        <template v-if="column.dataIndex === 'action'">
                            <a-dropdown placement="bottomRight">
                                <MoreOutlined />
                                <template #overlay>
                                    <a-menu>
                                        <!-- <a-menu-item
                                            key="view"
                                            v-if="
                                                permsArray.includes(
                                                    `${pageObject.permission}_view`
                                                ) ||
                                                permsArray.includes('admin')
                                            "
                                            @click="viewItem(record)"
                                        >
                                            <EyeOutlined />
                                            {{ $t("common.view") }}
                                        </a-menu-item> -->
                                        <a-menu-item
                                            key="edit"
                                            v-if="
                                                permsArray.includes(
                                                    `${pageObject.permission}_edit`
                                                ) ||
                                                permsArray.includes('admin')
                                            "
                                            @click="
                                                () =>
                                                    $router.push({
                                                        name: `admin.stock.${pageObject.type}.edit`,
                                                        params: {
                                                            id: record.xid,
                                                        },
                                                    })
                                            "
                                        >
                                            <EditOutlined />
                                            {{ $t("common.edit") }}
                                        </a-menu-item>
                                        <a-menu-item
                                            key="delete"
                                            v-if="
                                                permsArray.includes(
                                                    `${pageObject.permission}_delete`
                                                ) ||
                                                permsArray.includes('admin')
                                            "
                                            @click="
                                                showDeleteConfirm(record.xid)
                                            "
                                        >
                                            <DeleteOutlined />
                                            {{ $t("common.delete") }}
                                        </a-menu-item>
                                        <!-- <a-menu-item key="download">
                                            <a-typography-link
                                                :href="`${invoiceBaseUrl}/${record.unique_id}/${selectedLang}`"
                                                target="_blank"
                                            >
                                                <DownloadOutlined />
                                                {{ $t("common.download") }}
                                            </a-typography-link>
                                        </a-menu-item> -->
                                    </a-menu>
                                </template>
                            </a-dropdown>
                        </template>
                    </template>
                    <template #expandedRowRender="orderItemData">
                        <a-table
                            v-if="
                                orderItemData &&
                                orderItemData.record &&
                                orderItemData.record.items
                            "
                            :row-key="(record) => record.xid"
                            :columns="orderItemDetailsColumns"
                            :data-source="orderItemData.record.items"
                            :pagination="false"
                        >
                            <template #bodyCell="{ column, record, index }">
                                <template v-if="column.dataIndex === 'no'">
                                    {{ ++index }}
                                </template>
                                <template
                                    v-if="column.dataIndex === 'item_code'"
                                >
                                    {{ record.item_code }}
                                </template>
                                <template v-if="column.dataIndex === 'name'">
                                    <a-badge>
                                        {{ record.name }}
                                    </a-badge>
                                </template>
                                <template v-if="column.dataIndex === 'brand'">
                                    {{
                                        record.brand_name
                                            ? record.brand_name
                                            : "-"
                                    }}
                                </template>
                                <template
                                    v-if="column.dataIndex === 'category'"
                                >
                                    {{
                                        record.category_name
                                            ? record.category_name
                                            : "-"
                                    }}
                                </template>
                                <template v-if="column.dataIndex === 'group'">
                                    {{
                                        record.group_name
                                            ? record.group_name
                                            : "-"
                                    }}
                                </template>
                                <template v-if="column.dataIndex === 'color'">
                                    {{
                                        record.color_name
                                            ? record.color_name
                                            : "-"
                                    }}
                                </template>
                                <template v-if="column.dataIndex === 'notes'">
                                    {{ record.notes }}
                                </template>
                                <template
                                    v-if="column.dataIndex === 'quantity'"
                                >
                                    <a-typography-text
                                        v-if="record.adjustment_type == 'add'"
                                        type="success"
                                        strong
                                    >
                                        +{{ record.quantity }}
                                    </a-typography-text>
                                    <a-typography-text
                                        v-else
                                        type="danger"
                                        strong
                                    >
                                        -{{ record.quantity }}
                                    </a-typography-text>
                                </template>
                            </template>
                        </a-table>
                    </template>
                </a-table>
            </div>
        </a-col>
    </a-row>

    <StockAdjustmentOrderDetails
        :visible="detailsDrawerVisible"
        :order="selectedItem"
        @close="onDetailDrawerClose"
        @goBack="restSelectedItem"
        @reloadOrder="paymentSuccess"
    />

    <ConfirmOrder
        :visible="confirmModalVisible"
        :data="modalData"
        @closed="confirmModalVisible = false"
        @confirmSuccess="initialSetup"
    />

    <ViewOrder
        :visible="viewModalVisible"
        :order="modalData"
        @closed="viewModalVisible = false"
    />
</template>

<script>
import { onMounted, watch, ref, createVNode } from "vue";
import {
    EyeOutlined,
    PlusOutlined,
    EditOutlined,
    DeleteOutlined,
    ExclamationCircleOutlined,
    MoreOutlined,
    DownloadOutlined,
    CheckOutlined,
    StopOutlined,
    SendOutlined,
    SisternodeOutlined,
} from "@ant-design/icons-vue";
import { Modal, notification } from "ant-design-vue";
import { useRoute } from "vue-router";
import { useStore } from "vuex";
import { find, forEach } from "lodash-es";
import { useI18n } from "vue-i18n";
import fields from "../../views/stock-management/adjustment-orders/fields";
import common from "../../../common/composable/common";
import datatable from "../../../common/composable/datatable";
import PaymentStatus from "../../../common/components/order/PaymentStatus.vue";
import OrderStatus from "../../../common/components/order/OrderStatus.vue";
import Details from "../../views/stock-management/purchases/Details.vue";
import UserInfo from "../../../common/components/user/UserInfo.vue";
import StockAdjustmentOrderDetails from "./StockAdjustmentOrderDetails.vue";
import ConfirmOrder from "../../views/stock-management/online-orders/ConfirmOrder.vue";
import ViewOrder from "../../views/stock-management/online-orders/ViewOrder.vue";

export default {
    props: {
        selectable: {
            default: false,
        },
        tableSize: {
            default: "large",
        },
        bordered: {
            default: false,
        },
        orderType: {
            default: "",
        },
        filters: {
            default: {},
        },
        perPageItems: Number,
    },
    emits: ["onRowSelection"],
    components: {
        EyeOutlined,
        PlusOutlined,
        EditOutlined,
        DeleteOutlined,
        MoreOutlined,
        DownloadOutlined,
        ExclamationCircleOutlined,
        SisternodeOutlined,
        CheckOutlined,
        StopOutlined,
        SendOutlined,
        Details,
        UserInfo,
        Details,
        PaymentStatus,
        OrderStatus,
        StockAdjustmentOrderDetails,

        ConfirmOrder,
        ViewOrder,
    },
    setup(props, { emit }) {
        const store = useStore();
        const {
            columns,
            hashableColumns,
            setupTableColumns,
            filterableColumns,
            pageObject,
            orderType,
            orderStatus,
            orderItemDetailsColumns,
        } = fields();
        const datatableVariables = datatable();
        const {
            formatAmountCurrency,
            invoiceBaseUrl,
            permsArray,
            calculateOrderFilterString,
            formatDate,
            selectedWarehouse,
            selectedLang,
            orderStatusColors,

            allWarehouses,
        } = common();
        const route = useRoute();
        const { t } = useI18n();
        const detailsDrawerVisible = ref(false);

        const selectedItem = ref({});

        // For Online Orders
        const confirmModalVisible = ref(false);
        const viewModalVisible = ref(false);
        const modalData = ref({});
        // End For Online Orders

        onMounted(() => {
            warehouseChanged(allWarehouses.value[0]["xid"]);
            initialSetup();
        });

        const getCheckboxProps = (record) => {
            var isDeleteable = true;

            return {
                disabled: !isDeleteable,
                name: record.xid,
            };
        };

        const initialSetup = () => {
            console.log(props);
            orderType.value = props.orderType;
            if (props.perPageItems) {
                datatableVariables.table.pagination.pageSize =
                    props.perPageItems;
            }
            datatableVariables.table.pagination.current = 1;
            datatableVariables.table.pagination.currentPage = 1;
            datatableVariables.hashable.value = hashableColumns;

            setupTableColumns();
            setUrlData();
        };

        const setUrlData = () => {
            //* ADDENDUM
            // if (!props.filters.warehouse_id) {
            //     return;
            // }

            const tableFilter = props.filters;

            const filterString = calculateOrderFilterString(tableFilter);

            var extraFilterObject = {};
            if (tableFilter.dates) {
                extraFilterObject.dates = tableFilter.dates;
            }
            if (tableFilter.transfer_type) {
                extraFilterObject.transfer_type = tableFilter.transfer_type;
            }

            datatableVariables.tableUrl.value = {
                url: `stock-adjustment-orders?fields=xid,warehouse_id,x_warehouse_id,warehouse{id,xid,name},invoice_number,adjustment_type,total_items,total_quantity,date,notes,created_by,x_created_by,createdBy{id,xid,name,code,profile_image_url}`,
                filterString,
                filters: {
                    warehouse_id: tableFilter.warehouse_id,
                },
                extraFilters: extraFilterObject,
            };
            datatableVariables.table.sorter = {
                field: "date",
                order: "desc",
            };
            datatableVariables.table.filterableColumns = filterableColumns;

            if (
                tableFilter.searchColumn &&
                tableFilter.searchString &&
                tableFilter.searchString != ""
            ) {
                datatableVariables.table.searchColumn =
                    tableFilter.searchColumn;
                datatableVariables.table.searchString =
                    tableFilter.searchString;
            } else {
                datatableVariables.table.searchColumn = undefined;
                datatableVariables.table.searchString = "";
            }

            datatableVariables.fetch({
                page: datatableVariables.table.pagination.currentPage,
            });
        };

        const showDeleteConfirm = (id) => {
            Modal.confirm({
                title: t("common.delete") + "?",
                icon: createVNode(ExclamationCircleOutlined),
                content: t(`${pageObject.value.langKey}.delete_message`),
                centered: true,
                okText: t("common.yes"),
                okType: "danger",
                cancelText: t("common.no"),
                onOk() {
                    axiosAdmin.delete(`${props.orderType}/${id}`).then(() => {
                        // Update Visible Subscription Modules
                        updateSubscriptionModules();
                        setUrlData();

                        notification.success({
                            message: t("common.success"),
                            description: t(
                                `${pageObject.value.langKey}.deleted`
                            ),
                        });
                    });
                },
                onCancel() {},
            });
        };

        const showSelectedDeleteConfirm = () => {
            Modal.confirm({
                title: t("common.delete") + "?",
                icon: createVNode(ExclamationCircleOutlined),
                content: t(
                    `${pageObject.value.langKey}.selected_delete_message`
                ),
                centered: true,
                okText: t("common.yes"),
                okType: "danger",
                cancelText: t("common.no"),
                onOk() {
                    const allDeletePromise = [];
                    forEach(
                        datatableVariables.table.selectedRowKeys,
                        (selectedRow) => {
                            allDeletePromise.push(
                                axiosAdmin.delete(
                                    `${props.orderType}/${selectedRow}`
                                )
                            );
                        }
                    );

                    Promise.all(allDeletePromise).then((successResponse) => {
                        // Update Visible Subscription Modules
                        updateSubscriptionModules();

                        resetSelectedRows();
                        setUrlData();

                        notification.success({
                            message: t("common.success"),
                            description: t(
                                `${pageObject.value.langKey}.deleted`
                            ),
                            placement: "bottomRight",
                        });
                    });
                },
                onCancel() {},
            });
        };

        // Update Visible Subscription Modules
        const updateSubscriptionModules = () => {
            store.dispatch("auth/updateVisibleSubscriptionModules");
        };

        const viewItem = (record) => {
            selectedItem.value = record;
            detailsDrawerVisible.value = true;
        };

        const restSelectedItem = () => {
            selectedItem.value = {};
        };

        const paymentSuccess = () => {
            datatableVariables.fetch({
                page: datatableVariables.currentPage.value,
                success: (results) => {
                    const searchResult = find(results, (result) => {
                        return result.xid == selectedItem.value.xid;
                    });

                    if (searchResult != undefined) {
                        selectedItem.value = searchResult;
                    }
                },
            });
        };

        const onDetailDrawerClose = () => {
            detailsDrawerVisible.value = false;
        };

        // For Online Orders
        const confirmOrder = (order) => {
            modalData.value = order;
            confirmModalVisible.value = true;
        };

        const viewOrder = (order) => {
            modalData.value = order;
            viewModalVisible.value = true;
        };

        const changeOrderStatus = (order) => {
            processRequest({
                url: `online-orders/change-status/${order.unique_id}`,
                data: { order_status: order.order_status },
                success: (res) => {
                    // Toastr Notificaiton
                    notification.success({
                        placement: "bottomRight",
                        message: t("common.success"),
                        description: t("online_orders.order_status_changed"),
                    });
                },
                error: (errorRules) => {},
            });
        };

        const convertToSale = (order) => {
            Modal.confirm({
                title: t("quotation.convert_to_sale") + "?",
                icon: createVNode(ExclamationCircleOutlined),
                content: t(`quotation.convert_message`),
                centered: true,
                okText: t("common.yes"),
                okType: "danger",
                cancelText: t("common.no"),
                onOk() {
                    axiosAdmin
                        .post(`quotations/convert-to-sale/${order.unique_id}`)
                        .then(() => {
                            datatableVariables.fetch();

                            // Toastr Notificaiton
                            notification.success({
                                placement: "bottomRight",
                                message: t("common.success"),
                                description: t(
                                    "quotation.quotation_converted_to_sales"
                                ),
                            });
                        });
                },
                onCancel() {},
            });
        };

        const cancelOrder = (order) => {
            Modal.confirm({
                title: t("online_orders.cancel_order") + "?",
                icon: createVNode(ExclamationCircleOutlined),
                content: t(`online_orders.cancel_message`),
                centered: true,
                okText: t("common.yes"),
                okType: "danger",
                cancelText: t("common.no"),
                onOk() {
                    axiosAdmin
                        .post(`online-orders/cancel/${order.unique_id}`)
                        .then(() => {
                            initialSetup();
                            notification.success({
                                message: t("common.success"),
                                description: t(`online_orders.order_cancelled`),
                                placement: "bottomRight",
                            });
                        });
                },
                onCancel() {},
            });
        };

        const confirmDelivery = (order) => {
            Modal.confirm({
                title: t("common.delivered") + "?",
                icon: createVNode(ExclamationCircleOutlined),
                content: t(`online_orders.deliver_message`),
                centered: true,
                okText: t("common.yes"),
                okType: "danger",
                cancelText: t("common.no"),
                onOk() {
                    axiosAdmin
                        .post(`online-orders/delivered/${order.unique_id}`)
                        .then(() => {
                            initialSetup();
                            notification.success({
                                message: t("common.success"),
                                description: t(`online_orders.order_delivered`),
                                placement: "bottomRight",
                            });
                        });
                },
                onCancel() {},
            });
        };
        // End For Online Orders

        const resetSelectedRows = () => {
            datatableVariables.table.selectedRowKeys = [];
            emit("onRowSelection", []);
        };

        //* ADDENDUM
        const warehouseChanged = (selectedWarehouseId) => {
            axiosAdmin.post("change-warehouse", {
                warehouse_id: selectedWarehouseId,
            });
        };

        watch(props, (newVal, oldVal) => {
            // Reset Selected Rows
            resetSelectedRows();

            initialSetup();
            restSelectedItem();
        });

        watch(selectedWarehouse, (newVal, oldVal) => {
            resetSelectedRows();

            datatableVariables.table.pagination.current = 1;
            setUrlData();
        });

        watch(
            () => datatableVariables.table.data,
            (newVal, oldVal) => {
                if (newVal.length > 0) {
                    axiosAdmin
                        .post("stock-adjustment-order-items-data", {
                            stock_adjustment_order_id: newVal.map(
                                (el) => el.xid
                            ),
                        })
                        .then((response) => {
                            console.log(response);
                            datatableVariables.table.data.map((el) => {
                                el.items = response.data[el.xid];
                                return el;
                            });
                        });

                    console.log(datatableVariables.table.data);
                }
            }
        );

        return {
            columns,
            ...datatableVariables,
            filterableColumns,
            pageObject,

            formatDate,
            orderStatus,
            orderStatusColors,

            setUrlData,
            formatAmountCurrency,
            invoiceBaseUrl,
            permsArray,

            selectedItem,
            viewItem,
            restSelectedItem,
            paymentSuccess,

            showDeleteConfirm,
            showSelectedDeleteConfirm,

            detailsDrawerVisible,
            onDetailDrawerClose,
            orderItemDetailsColumns,
            selectedLang,
            initialSetup,

            convertToSale,

            // For Online Orders
            confirmOrder,
            cancelOrder,
            viewOrder,
            confirmDelivery,
            changeOrderStatus,
            confirmModalVisible,
            viewModalVisible,
            modalData,
            // End For Online Orders

            getCheckboxProps,

            allWarehouses,
        };
    },
};
</script>
