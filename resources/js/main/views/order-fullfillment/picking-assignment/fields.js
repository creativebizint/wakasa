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
			title: t("picking_assignment.code"),
			dataIndex: "code",
			sorter:true
		},
		{
			title: t("picking_assignment.name"),
			dataIndex: "name",
			sorter:true
		},
		{
			title: t("picking_assignment.status"),
			dataIndex: "status",
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