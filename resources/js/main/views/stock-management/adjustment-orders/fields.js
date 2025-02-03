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
    const hashableColumns = ["warehouse_id"];

    onMounted(() => {
        orderType.value = "stock-adjustment-orders";
    });

    const initData = {
        date: dayjs().utc().format("YYYY-MM-DDTHH:mm:ssZ"),
        notes: "",
        warehouse_id: undefined,
        created_by: undefined,
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
            title: t("product.item_code"),
            dataIndex: "item_code",
        },
        {
            title: t("product.name"),
            dataIndex: "name",
        },
        {
            title: t("product.brand"),
            dataIndex: "brand",
        },
        {
            title: t("product.category"),
            dataIndex: "category",
        },
        {
            title: t("product.group"),
            dataIndex: "group",
        },
        {
            title: t("product.color"),
            dataIndex: "color",
        },
        {
            title: t("invoice.notes"),
            dataIndex: "notes",
        },
        {
            title: t("product.quantity"),
            dataIndex: "unit_quantity",
        },
        {
            title: t("common.action"),
            dataIndex: "action",
        },
    ];

    const orderItemDetailsColumns = [
        {
            title: "#",
            dataIndex: "no",
        },
        {
            title: t("product.item_code"),
            dataIndex: "item_code",
        },
        {
            title: t("product.name"),
            dataIndex: "name",
        },
        {
            title: t("product.brand"),
            dataIndex: "brand",
        },
        {
            title: t("product.category"),
            dataIndex: "category",
        },
        {
            title: t("product.group"),
            dataIndex: "group",
        },
        {
            title: t("product.color"),
            dataIndex: "color",
        },
        {
            title: t("invoice.notes"),
            dataIndex: "notes",
        },
        {
            title: t("product.quantity"),
            dataIndex: "quantity",
        },
    ];

    const filterableColumns = [
        {
            key: "invoice_number",
            value: t("stock.invoice_number"),
        },
    ];

    const pageObject = computed(() => {
        return {
            type: "stock-adjustment-orders",
            langKey: "stock_adjustment",
            menuKey: "stock_adjustment",
            userType: "customers",
            permission: "stock_adjustment",
        };
    });

    const setupTableColumns = () => {
        columns.value = [
            {
                title: t("stock_adjustment.invoice_number"),
                dataIndex: "invoice_number",
            },
            {
                title: t("stock_adjustment.adjustment_date"),
                dataIndex: "date",
            },
            {
                title: t(`common.created_by`),
                dataIndex: "created_by",
            },
            {
                title: t("warehouse.warehouse"),
                dataIndex: "warehouse",
            },
            {
                title: t("invoice.total_items"),
                dataIndex: "total_items",
            },
            {
                title: t("invoice.total_quantities"),
                dataIndex: "total_quantities",
            },
            {
                title: t("common.action"),
                dataIndex: "action",
            },
        ];
    };

    const orderPaymentsColumns = [
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

    const adjustmentTypes = [
        {
            key: "add",
            value: t("stock_adjustment.adjustment_add"),
        },
        {
            key: "subtract",
            value: t("stock_adjustment.adjustment_subtract"),
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
        orderItemDetailsColumns,
        adjustmentTypes,
    };
};

export default fields;
