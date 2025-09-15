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
    const hashableColumns = ['user_id', 'warehouse_id'];

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
            title: t("product.shelf"),
            dataIndex: "shelf",
        },
        {
            title: t("product.product_code"),
            dataIndex: "product_code",
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
        //{
        //    title: t("product.unit_price"),
        //    dataIndex: "single_unit_price",
        //},
        //{
        //    title: t("product.discount"),
        //    dataIndex: "total_discount",
        //},
        //{
        //    title: t("product.tax"),
        //    dataIndex: "total_tax",
        //},
        //{
        //    title: t("product.subtotal"),
        //    dataIndex: "subtotal",
        //},
        {
            title: t("common.action"),
            dataIndex: "action",
        },
    ];

    const orderItemDetailsColumns = [
        {
            title: t("product.product"),
            dataIndex: "product_id",
        },
        {
            title: t("product.quantity"),
            dataIndex: "quantity",
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
        else if (orderType.value == "inventory_in" || orderType.value == "placement_in") {
            pageObjectDetails = {
                type: "inventory_in",
                langKey: "inventory_in",
                menuKey: "inventory_in",
                userType: "suppliers",
                permission: "inventory_in",
            };
        }
        else if (orderType.value == "inventory_out" || orderType.value == "placement_out") {
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
        
        if(orderType.value == "placement_in"){
            var allColumns = [
                {
                    title: t(`product.item_id`),
                    dataIndex: "item_id",
                    sorter:false
                },
                {
                    title: t(`${pageObject.value.langKey}.invoice_number`),
                    dataIndex: "invoice_number",
                    sorter:false
                },
                {
                    title: t(`stock.warehouse`),
                    dataIndex: "warehouse",
                    sorter:false
                },
                {
                    title: t(`${pageObject.value.langKey}.${pageObject.value.langKey}_date`),
                    dataIndex: "order_date",
                    sorter:true
                }
            ];
        }
        else if(orderType.value == "placement_out"){
            var allColumns = [
                {
                    title: t(`product.item_id`),
                    dataIndex: "item_id",
                    sorter:false
                },
                {
                    title: t(`${pageObject.value.langKey}.invoice_number`),
                    dataIndex: "invoice_number",
                    sorter:false
                },
                {
                    title: t(`stock.warehouse`),
                    dataIndex: "warehouse",
                    sorter:false
                },
                {
                    title: t(`common.picker`),
                    dataIndex: "picker",
                    sorter:false
                }
            ];
        }
        else{
            var allColumns = [
                {
                    title: t(`${pageObject.value.langKey}.invoice_number`),
                    dataIndex: "invoice_number",
                    sorter:true
                },
                {
                    title: t(`stock.warehouse`),
                    dataIndex: "warehouse",
                    sorter:true
                },
                {
                    title: t(`${pageObject.value.langKey}.${pageObject.value.langKey}_date`),
                    dataIndex: "order_date",
                    sorter:true
                }
            ];
        }
        

        if (pageObject.value.type == 'stock-transfers') {
            allColumns.push({
                title: t("stock_transfer.warehouse"),
                dataIndex: "warehouse",
                sorter:true,
                sorter_field:"orders.warehouse_id"
            });
        }


        if (pageObject.value.type != 'stock-transfers') {
            allColumns.push({
                title: t(`${pageObject.value.langKey}.user`),
                dataIndex: "user_id",
                sorter:true,
                sorter_field:"orders.user_id"
            });
        }
        
        if(orderType.value == "placement_in"){
            allColumns.push({
                title: t(`product.quantity`),
                dataIndex: "quantity",
                sorter:true,
                sorter_field:"orders.quantity"
            });
            allColumns.push({
                title: t(`product.qty_scanned`),
                dataIndex: "quantity_scanned",
                sorter:true,
                sorter_field:"orders.quantity_scanned"
            });
            
        }
        
        if(orderType.value == "placement_out"){
            allColumns.push({
                title: t(`product.quantity`),
                dataIndex: "quantity",
                sorter:true,
                sorter_field:"orders.quantity"
            });
            allColumns.push({
                title: t(`product.qty_scanned`),
                dataIndex: "quantity_scanned",
                sorter:true,
                sorter_field:"orders.quantity_scanned"
            });
            
        }

        columns.value = [
            ...allColumns,
            
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

    const barcodeColumns = [
        {
            title: "#",
            dataIndex: "sn",
        },
        {
            title: t("menu.barcode"),
            dataIndex: "string",
        },
        {
            title: t("barcode.qty_bungkus"),
            dataIndex: "qty_bungkus",
        },
        {
            title: t("barcode.comment"),
            dataIndex: "comment",
        },
        {
            title: t("common.action"),
            dataIndex: "action",
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
        barcodeColumns
    }
}

export default fields;
