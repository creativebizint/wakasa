import { useI18n } from "vue-i18n";

const fields = () => {
	const addEditUrl = "picking-assignment";
	const { t } = useI18n();
        const hashableColumns = ['id'];
        
	const initData = {
		name: "",
		code: "",
		type: "",
		slug: "",
                created_at: '',
                status : '',
                items : ''
	};

	const columns = [
		{
			title: t("product.item_id"),
			dataIndex: "item_id",
			sorter:true
		},
                {
			title: t("sales_order.invoice_number"),
			dataIndex: "invoice_number",
			sorter:true
		},
		
		{
			title: t("picking_assignment.date"),
			dataIndex: "created_at",
		},
		{
                    title: t("product.quantity_faktur"),
                    dataIndex: "unit_quantity",
                },
		{
                    title: t("product.text2"),
                    dataIndex: "text2",
                },
                {
                    title: t("product.qty_scanned"),
                    dataIndex: "qty_scanned",
                },
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
		filterableColumns
	}
}

export default fields;