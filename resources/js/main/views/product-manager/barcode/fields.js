import { useI18n } from "vue-i18n";

const fields = () => {
	const addEditUrl = "barcode";
	const { t } = useI18n();

	const initData = {
		string: "",
		comment: "",
		reason: "",
		isactive: "",
	};

	const columns = [
		{
			title: t("barcode.string"),
			dataIndex: "string",
			sorter:true
		},
		{
			title: t("barcode.status"),
			dataIndex: "isactive",
			sorter:true
		},
		{
			title: t("barcode.invoice_number"),
			dataIndex: "invoice_number",
			sorter:true
		},
		{
			title: t("barcode.sales_order_number"),
			dataIndex: "sales_order_number",
			sorter:true
		},
                {
			title: t("barcode.reason"),
			dataIndex: "reason",
			sorter:true
		},
                {
			title: t("barcode.comment"),
			dataIndex: "comment",
			sorter:true
		},
		{
			title: t("common.action"),
			dataIndex: "action",
		},
	];

	const filterableColumns = [
		{
			key: "string",
			value: t("barcode.string")
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