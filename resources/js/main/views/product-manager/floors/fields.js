import { useI18n } from "vue-i18n";

const fields = () => {
	const addEditUrl = "floors";
	const { t } = useI18n();

	const initData = {
		value: "",		
	};

	const columns = [
		{
			title: t("floors.value"),
			dataIndex: "value",
		},
		
		{
			title: t("common.action"),
			dataIndex: "action",
		},
	];

	const filterableColumns = [
		{
			key: "value",
			value: t("floors.value")
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