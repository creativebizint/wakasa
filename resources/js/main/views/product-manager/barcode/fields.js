import { useI18n } from "vue-i18n";

const fields = () => {
	const addEditUrl = "barcode";
	const { t } = useI18n();

	const initData = {
		string: "",
		isactive: "",
	};

	const columns = [
		{
			title: t("barcode.string"),
			dataIndex: "string",
			sorter:true
		},
		{
			title: t("barcode.isactive"),
			dataIndex: "isactive",
			sorter:true
		},
		{
			title: t("barcode.invoice_number"),
			dataIndex: "invoice_number",
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