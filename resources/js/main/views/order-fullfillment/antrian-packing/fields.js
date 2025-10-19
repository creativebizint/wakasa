import { useI18n } from "vue-i18n";

const fields = () => {
	const addEditUrl = "picking-assignment";
	const { t } = useI18n();
        const hashableColumns = ['id'];
        
	const initData = {
                invoice_number: "",
		user_name: "",
		code: "",
		type: "",
		slug: "",
                created_at: '',
                order_status : '',
                items : ''
	};

	const columns = [
		{
			title: t("inventory_out.invoice_number"),
			dataIndex: "invoice_number",
			sorter:true
		},
		{
			title: t("inventory_out.user"),
			dataIndex: "user_name",
			sorter:true
		},
		{
			title: t("picking_assignment.status"),
			dataIndex: "order_status",
		},
		{
			title: t("common.note"),
			dataIndex: "note",
		},
		{
			title: t("common.priority"),
			dataIndex: "priority",
		},
		{
			title: t("picking_assignment.date"),
			dataIndex: "created_at",
		},
		{
			title: t("common.action"),
			dataIndex: "action",
		},
	];

        const orderItemDetailsColumns = [
            {
                title: t("product.product_id"),
                dataIndex: "item_id",
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
                title: t("product.quantity_faktur"),
                dataIndex: "quantity",
            },
            {
                title: t("product.qty_scanned"),
                dataIndex: "quantity_scanned",
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
			key: "user.name",
			value: t("picking_assignment.name")
		},
	];

	return {
		addEditUrl,
		initData,
		columns,
		filterableColumns,
                orderItemDetailsColumns
	}
}

export default fields;