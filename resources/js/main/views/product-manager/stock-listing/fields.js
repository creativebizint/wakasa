import { useI18n } from "vue-i18n";
import common from "../../../../common/composable/common";

//* ADDENDUM
const fields = () => {
    const addEditUrl = "products";
    const { t } = useI18n();
    const { permsArray } = common();

    const hashableColumns = [
        "unit_id",
        "category_id",
        "brand_id",
        "group_id",
        "color_id",
        "tax_id",
        "warehouse_id",
    ];
    const multiDimensalObjectColumns = {
        stock_quantitiy_alert: "details.stock_quantitiy_alert",
        mrp: "details.mrp",
        purchase_price: "details.purchase_price",
        sales_price: "details.sales_price",
        tax_id: "details.x_tax_id",
        purchase_tax_type: "details.purchase_tax_type",
        sales_tax_type: "details.sales_tax_type",
        opening_stock: "details.opening_stock",
        opening_stock_date: "details.opening_stock_date",
        wholesale_price: "details.wholesale_price",
        wholesale_quantity: "details.wholesale_quantity",

        //* ADDENDUM
        retail_counter_price: "details.retail_counter_price",
        special_counter_price: "details.special_counter_price",
        discount_counter_price: "details.discount_counter_price",
        retail_online_price: "details.retail_online_price",
        special_online_price: "details.special_online_price",
        discount_online_price: "details.discount_online_price",
    };

    const initData = {
        warehouse_id: undefined,
        name: "",
        slug: "",
        image: undefined,
        image_url: undefined,
        barcode_symbology: "CODE128",
        item_code: "",
        item_id: "",
        stock_quantitiy_alert: null,
        category_id: undefined,
        brand_id: undefined,
        mrp: 0,
        purchase_price: 0,
        sales_price: 0,
        tax_id: undefined,
        unit_id: undefined,
        description: "",
        purchase_tax_type: "exclusive",
        sales_tax_type: "exclusive",
        custom_fields: [],
        opening_stock: undefined,
        opening_stock_date: undefined,
        wholesale_price: undefined,
        wholesale_quantity: undefined,
        product_type: "single",
        variations: [],

        //* ADDENDUM
        shape: "",
        size: "",
        material: "",
        weight: "",
        retail_counter_price: 0,
        special_counter_price: 0,
        discount_counter_price: 0,
        retail_online_price: 0,
        special_online_price: 0,
        discount_online_price: 0,
    };

    const columns = [
        {
            title: t("product.item_id"),
            dataIndex: "item_id",
        },
        {
            title: t("product.item_code"),
            dataIndex: "item_code",
        },
        {
            title: t("product.product"),
            dataIndex: "name",
        },
        {
            title: t("product.category"),
            dataIndex: "category_id",
        },
        {
            title: t("product.brand"),
            dataIndex: "brand_id",
        },

        {
            title: t("warehouse.warehouse"),
            dataIndex: "warehouse_id",
        },

        // {
        //     title: t("product.sales_price"),
        //     dataIndex: "sales_price",
        // },
    ];

    if (
        permsArray.value.includes("purchase_price_view") ||
        permsArray.value.includes("admin")
    ) {
        columns.push(
            {
                title: t("product.purchase_price"),
                dataIndex: "purchase_price",
            },
        );
    }

    columns.push(
        {
            title: t("product.current_stock"),
            dataIndex: "current_stock",
        },
        {
            title: t("common.action"),
            dataIndex: "action",
        }
    );

    const variableProductcolumns = [
        {
            title: t("product.product"),
            dataIndex: "name",
        },
        {
            title: t("product.category"),
            dataIndex: "category_id",
        },

        {
            title: t("product.brand"),
            dataIndex: "brand_id",
        },
        {
            title: t("common.action"),
            dataIndex: "action",
        },
    ];

    const variantColumns = [
        {
            title: t("product.product"),
            dataIndex: "name",
        },
        {
            title: t("product.item_code"),
            dataIndex: "item_code",
        },
        {
            title: t("product.sales_price"),
            dataIndex: "sales_price",
        },
        {
            title: t("product.purchase_price"),
            dataIndex: "purchase_price",
        },
        {
            title: t("product.current_stock"),
            dataIndex: "current_stock",
        },
        {
            title: t("common.action"),
            dataIndex: "action",
        },
    ];

    const filterableColumns = [
        {
            key: "item_code",
            value: t("product.item_code"),
        },
        {
            key: "name",
            value: t("product.name"),
        },
    ];

    return {
        addEditUrl,
        initData,
        columns,
        variableProductcolumns,
        variantColumns,
        filterableColumns,
        hashableColumns,
        multiDimensalObjectColumns,
    };
};

export default fields;
