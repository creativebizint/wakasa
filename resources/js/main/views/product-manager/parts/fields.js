import { useI18n } from "vue-i18n";

const fields = () => {
	const addEditUrl = "parts";
	const { t } = useI18n();
        const hashableColumns = ['id'];
        
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
			title: t("part.code"),
			dataIndex: "code",
			sorter:true
		},
		{
			title: t("part.name"),
			dataIndex: "name",
			sorter:true
		},
		{
			title: t("part.description"),
			dataIndex: "description",
		},

		{
			title: t("common.action"),
			dataIndex: "action",
		},
	];

	const filterableColumns = [
		{
			key: "name",
			value: t("part.name")
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