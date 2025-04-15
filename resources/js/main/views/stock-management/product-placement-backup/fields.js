import { ref, computed, onMounted } from "vue";
import { useStore } from "vuex";
import { useI18n } from "vue-i18n";
import { useRoute } from "vue-router";
import common from "../../../../common/composable/common";

const fields = () => {
    const addEditUrl = "warehouses";
    const route = useRoute();
    const url = "product-placement?fields=id,xid,x_product_id,x_unit_id,x_warehouse_id, floor,shelf_group,shelf_number,row,product{id,xid,name},warehouse{id,xid,name}";
    const { t } = useI18n();
    const hashableColumns = ["product_placements.warehouse_id","product_id","floor","shelf_group","shelf_number","row"];
//    const sorter = { field: "products.name", order: "asc" };
    const initData = {
        id: "",
        user_id: "",
        placement_id: "",
        product_id: undefined,
        warehouse_id: undefined,
        unit_id: undefined,
        floor: undefined,
        shelf_group: undefined,
        shelf_number: undefined,
        row: undefined,        
    };

    const columns = [
        {
            title: t("stock_management.code"),
            dataIndex: "item_code",
            sorter: true,
        },
        {
            title: t("stock_management.product"),
            dataIndex: "product_id",
            sorter: true,
        },
        {
            title: t("stock_management.warehouse"),
            dataIndex: "warehouse_id",
            sorter: true,
        },
        {
            title: t("stock_management.brand"),
            dataIndex: "brand_name",
            sorter: true,
        },

        {
            title: t("stock_management.floor"),
            dataIndex: "floor",
            sorter: true,
        },
        {
            title: t("stock_management.shelf_group"),
            dataIndex: "shelf_group",
            sorter: true,
        },
        {
            title: t("stock_management.shelf_number"),
            dataIndex: "shelf_number",
            sorter: true,
        },
        {
            title: t("stock_management.row"),
            dataIndex: "row",
            sorter: true,
        },
        {
            title: t("common.total"),
            dataIndex: "total",
            sorter: true,
        },

    ];

    const filterableColumns = [
        {
            key: "products.item_code",
            value: t("products.item_code"),
        },
        {
            key: "products.name",
            value: t("products.name"),
        },
    ];

    return {
        url,
        addEditUrl,
        initData,
        columns,
        filterableColumns,
        hashableColumns
    }
}

export default fields;
