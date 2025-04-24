import { ref } from "vue";
import { useI18n } from "vue-i18n";
import { useRoute } from "vue-router";

const fields = () => {
    const route = useRoute();
    const url = "product-placement-in-history?";
    const hashableColumns = ["id"];
    const { t } = useI18n();
    const initData = {
        id: "",
        invoice_number: "",
        createdby_name: "",
        warehouse_name: "",
        invoice_type: "",
        placement_type: "",
        placement_date: "",
        total_items: 0,
        total_quantity: 0,
        items : undefined,
        notes : "",
    };

    const columns = [
        {
            title: t("stock_in.invoice_number"),
            dataIndex: "invoice_number",
            sorter: true,
        },
        {
            title: t("common.created_by"),
            dataIndex: "created_by",
            sorter: true,
        },
        {
            title: t("stock_in.warehouse"),
            dataIndex: "warehouse_name",
            sorter: true,
        },
        {
            title: t("stock_in.placement_date"),
            dataIndex: "placement_date",
            sorter: true,
        },
        {
            title: t("stock_in.notes"),
            dataIndex: "notes",
            sorter: true,
        },
        {
            title: t("stock_in.total_items"),
            dataIndex: "total_items",
            sorter: true,
        },
        {
            title: t("stock_in.total_quantity"),
            dataIndex: "total_quantity",
            sorter: true,
        },
        {
            title: t("common.action"),
            dataIndex: "action",
        },
    ];

    const filterableColumns = [
        {
            key: "invoice_number",
            value: t("stock_in.item_code"),
        }
    ];

    return {
        url,
        initData,
        columns,
        filterableColumns,
        hashableColumns
    }
}

export default fields;
