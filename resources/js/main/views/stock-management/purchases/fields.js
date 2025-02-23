import { ref, computed, onMounted } from "vue";
import { useStore } from "vuex";
import { useI18n } from "vue-i18n";
import { useRoute } from "vue-router";
import common from "../../../../common/composable/common";

const fields = () => {
    const { dayjs } = common();
    const store = useStore();
    const { t } = useI18n();
    const route = useRoute();
    const orderType = ref(route.meta.orderType);
    const columns = ref([]);
    const hashableColumns = [
        "user_id",
        "warehouse_id",
        "from_warehouse_id",
        "staff_user_id",
    ];

    onMounted(() => {
        if (route.meta && route.meta.orderType) {
            orderType.value = route.meta.orderType;
        } else {
            orderType.value = "online-orders";
        }
    });

    const initData = {
        order_date: dayjs().utc().format("YYYY-MM-DDTHH:mm:ssZ"),
        user_id: undefined,
        notes: "",
        order_status: undefined,
        tax_id: undefined,
        warehouse_id: undefined,
        from_warehouse_id: undefined,
        staff_user_id: undefined,
        discount: 0,
        shipping: 0,
        subtotal: 0,
    };

    const initPaymentData = {
        date: undefined,
        payment_mode_id: undefined,
        amount: "",
        notes: "",
    };

    const orderItemColumns = [
        {
            title: "#",
            dataIndex: "sn",
        },
        {
            title: t("product.name"),
            dataIndex: "name",
        },
        {
            title: t("product.quantity"),
            dataIndex: "unit_quantity",
        },
        {
            title: t("product.unit_price"),
            dataIndex: "single_unit_price",
        },
        {
            title: t("product.discount"),
            dataIndex: "total_discount",
        },
        {
            title: t("product.tax"),
            dataIndex: "total_tax",
        },
        {
            title: t("product.subtotal"),
            dataIndex: "subtotal",
        },
        {
            title: t("common.action"),
            dataIndex: "action",
        },
    ];

    const orderItemDetailsColumns = [
        {
            title: t("product.product_id"),
            dataIndex: "product_id",
        },
        {
            title: t("product.product_code"),
            dataIndex: "product_code",
        },
        {
            title: t("product.product_name"),
            dataIndex: "name",
        },
        {
            title: t("product.product_description"),
            dataIndex: "description",
        },
        {
            title: t("product.subgroup2"),
            dataIndex: "subgroup2",
        },
        {
            title: t("product.text1"),
            dataIndex: "text1",
        },
        {
            title: t("product.sat"),
            dataIndex: "sat",
        },
        {
            title: t("product.quantity"),
            dataIndex: "quantity",
        },
//        {
//            title: t("product.unit_price"),
//            dataIndex: "single_unit_price",
//        },
//        {
//            title: t("product.discount"),
//            dataIndex: "total_discount",
//        },
//        {
//            title: t("product.tax"),
//            dataIndex: "total_tax",
//        },
//        {
//            title: t("product.subtotal"),
//            dataIndex: "subtotal",
//        },
    ];

    const filterableColumns = [
        {
            key: "invoice_number",
            value: t("stock.invoice_number")
        },
    ];

    const pageObject = computed(() => {
        var pageObjectDetails = {};

        if (orderType.value == "purchases") {
            pageObjectDetails = {
                type: "purchases",
                langKey: "purchase",
                menuKey: "purchases",
                userType: "suppliers",
                permission: "purchases",
            };
        }
        else if (orderType.value == "inventory_in") {
            pageObjectDetails = {
                type: "purchases",
                langKey: "purchase",
                menuKey: "purchases",
                userType: "suppliers",
                permission: "purchases",
            };
        }
        else if (orderType.value == "inventory_out") {
            pageObjectDetails = {
                type: "inventory_out",
                langKey: "inventory_out",
                menuKey: "inventory_out",
                userType: "customers",
                permission: "inventory_out",
            };
        }
        else if (orderType.value == "sales") {
            pageObjectDetails = {
                type: "sales",
                langKey: "sales",
                menuKey: "sales",
                userType: "customers",
                permission: "sales",
            };
        } else if (orderType.value == "purchase-returns") {
            pageObjectDetails = {
                type: "purchase-returns",
                langKey: "purchase_returns",
                menuKey: "purchase_returns",
                userType: "suppliers",
                permission: "purchase_returns",
            };
        } else if (orderType.value == "sales-returns") {
            pageObjectDetails = {
                type: "sales-returns",
                langKey: "sales_returns",
                menuKey: "sales_returns",
                userType: "customers",
                permission: "sales_returns",
            };
        } else if (orderType.value == "online-orders") {
            pageObjectDetails = {
                type: "online-orders",
                langKey: "online_orders",
                menuKey: "online_orders",
                userType: "customers",
                permission: "online_orders",
            };
        } else if (orderType.value == "quotations") {
            pageObjectDetails = {
                type: "quotations",
                langKey: "quotation",
                menuKey: "sales",
                userType: "customers",
                permission: "quotations",
            };
        } else if (orderType.value == "stock-transfers") {
            pageObjectDetails = {
                type: "stock-transfers",
                langKey: "stock_transfer",
                menuKey: "stock_transfer",
                userType: "customers",
                permission: "stock_transfers",
            };
        }

        return pageObjectDetails;
    });

    const setupTableColumns = () => {
        var allColumns = [
            {
                title: t(`stock.invoice_number`),
                dataIndex: "invoice_number",
                sorter:true
            },
//            {
//                title: t(
//                    `${pageObject.value.langKey}.${pageObject.value.langKey}_date`
//                ),
//                dataIndex: "order_date",
//            },
            {
                title: t(`common.created_by`),
                dataIndex: "staff_user_id",
            },
        ];

        if (pageObject.value.type == 'stock-transfers') {
            allColumns.push({
                title: t("stock_transfer.warehouse"),
                dataIndex: "warehouse",
                sorter:true,
                sorter_field:"orders.warehouse_id"
            });
        }

        //* ADDENDUM
        if (pageObject.value.type == "purchases") {
            allColumns.push({
                title: t("stock_transfer.to_warehouse"),
                dataIndex: "warehouse",
            });
        }
        
        allColumns.push({
            title: t(`${pageObject.value.langKey}.${pageObject.value.langKey}_date`),
            dataIndex: "order_date",
            sorter:true
        });

        if (pageObject.value.type != 'stock-transfers') {
            allColumns.push({
                title: t(`${pageObject.value.langKey}.user`),
                dataIndex: "user_id",
                sorter:true,
                sorter_field:"orders.user_id"
            });
        }

        columns.value = [
            ...allColumns,
            {
                title: t(`${pageObject.value.langKey}.${pageObject.value.langKey}_status`),
                dataIndex: "order_status",
                sorter:true,
            },
            {
                title: t("invoice.total_items"),
                dataIndex: "total_items",
            },
            {
                title: t("invoice.total_quantities"),
                dataIndex: "total_quantities",
            },    
            //{
            //    title: t("payments.total_amount"),
            //    dataIndex: "total_amount",
            //    sorter:true,
            //    sorter_field:"orders.total"
            //},
            {
                title: t("common.action"),
                dataIndex: "action",
            },
        ];
    };

    const orderPaymentsColumns = [
        {
            title: t("payments.transaction_number"),
            dataIndex: "payment_number",
        },
        {
            title: t("payments.date"),
            dataIndex: "date",
        },
        {
            title: t("payments.amount"),
            dataIndex: "amount",
        },
        {
            title: t("payments.payment_mode"),
            dataIndex: "payment_mode_id",
        },
      
    ];

    return {
        initData,
        initPaymentData,
        columns,
        hashableColumns,
        setupTableColumns,
        filterableColumns,
        pageObject,
        orderType,
        orderItemColumns,
        orderPaymentsColumns,
        orderItemDetailsColumns
    }
}

export default fields;
