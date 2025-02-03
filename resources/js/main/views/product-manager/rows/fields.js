import { useI18n } from "vue-i18n";

const fields = () => {
	const addEditUrl = "rows";
	const url = "rows?fields=xid,value,product_placement_shelf_number_id,x_product_placement_shelf_number_id,product_placement_shelf_number{id,xid,value},product_placement_shelf_number:product_placement_shelf_group{id,xid,value},product_placement_shelf_number:product_placement_shelf_group:product_placement_floor{id,xid,value}";
	const { t } = useI18n();
        const hashableColumns = ["product_placement_shelf_number_id"];
    
	const initData = {
		value: "",		
		product_placement_shelf_number_id: "",		
	};

	const columns = [
		{
			title: t("rows.value"),
			dataIndex: "value",
		},
		{
			title: t("rows.product_placement_shelf_number"),
			dataIndex: "product_placement_shelf_number_id",
		},
		
		{
			title: t("common.action"),
			dataIndex: "action",
		},
	];

	const filterableColumns = [
		{
			key: "value",
			value: t("rows.value")
		},
	];

	return {
		addEditUrl,
		initData,
		columns,
		filterableColumns,
                hashableColumns,
                url,
	}
}

export default fields;