import { useI18n } from "vue-i18n";

const fields = () => {
	const addEditUrl = "brands";
	const { t } = useI18n();

	const initData = {
		name: "",
		description: "",
		description2: "",
		code: "",
		type: "",
		slug: "",
		image: undefined,
		image_url: undefined,
	};

	const columns = [
		{
			title: t("brand.code"),
			dataIndex: "code",
			sorter:true
		},
		{
			title: t("brand.name"),
			dataIndex: "name",
			sorter:true
		},
		{
			title: t("brand.description"),
			dataIndex: "description",
		},
		{
			title: t("brand.description") + 2,
			dataIndex: "description2",
		},
		{
			title: t("common.action"),
			dataIndex: "action",
		},
	];

	const filterableColumns = [
		{
			key: "name",
			value: t("brand.name")
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