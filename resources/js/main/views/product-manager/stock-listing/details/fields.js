import { useI18n } from "vue-i18n";

const fields = () => {
    const { t } = useI18n();
    const stockHistoryHashableColumns = ["product_id"];
    const orderItemsHashableColumns = ["product_id"];

    const productOrderColumns = [
        {
            title: t("stock.order_date"),
            dataIndex: "order_date",
        },
        {
            title: t("stock.invoice_number"),
            dataIndex: "invoice_number",
        },
        {
            title: t("stock.order_type"),
            dataIndex: "order_type",
        },
        {
            title: t("product.quantity"),
            dataIndex: "quantity",
        },
    ];

    const stockHistoryColumns = [
        {
            title: t("stock.transaction_date"),
            dataIndex: "order_date",
        },
        {
            title: t("stock.invoice_number"),
            dataIndex: "invoice_number",
        },
        {
            title: t("stock.order_type"),
            dataIndex: "order_type",
        },
        {
            title: t("common.from"),
            dataIndex: "from",
        },
        {
            title: t("common.to"),
            dataIndex: "to",
        },
        {
            title: t("product.quantity") + " In",
            dataIndex: "quantity_in",
        },
        {
            title: t("product.quantity") + " Out",
            dataIndex: "quantity_out",
        },
        {
            title: t("common.balance"),
            dataIndex: "balance",
        },
    ];

    return {
        productOrderColumns,
        stockHistoryColumns,
        stockHistoryHashableColumns,
        orderItemsHashableColumns,
    };
};

export default fields;
