import { useI18n } from "vue-i18n";

const fields = () => {
	const addEditUrl = "categories";
	const { t } = useI18n();
	const hashableColumns = ['id'];

	const initData = {
		name: "",
		quantity: null,
		item_id: null,
		invoice_number: null,
	};

	const columns = [
		{
			title: t("picking_request.invoice_number"),
			dataIndex: "invoice_number",
		},
		{
			title: t("picking_request.item_id"),
			dataIndex: "item_id",
		},
                {
			title: t("picking_request.product_name"),
			dataIndex: "name",
		},
		{
			title: t("picking_request.quantity"),
			dataIndex: "quantity",
		},		
	];

	return {
		hashableColumns,
		addEditUrl,
		initData,
		columns,
	}
}

export default fields;
