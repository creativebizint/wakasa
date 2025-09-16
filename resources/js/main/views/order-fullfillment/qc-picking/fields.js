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