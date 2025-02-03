import { useI18n } from "vue-i18n";

const fields = () => {
	const addEditUrl = "shelf-groups";
	const url = "shelf-groups?fields=xid,value,product_placement_floor_id,x_product_placement_floor_id,product_placement_floor{id,xid,value}";
	const { t } = useI18n();
        const hashableColumns = ["product_placement_floor_id"];
        
	const initData = {
		value: "",
                product_placement_floor_id : undefined,
	};

	const columns = [
		{
			title: t("shelf_groups.value"),
			dataIndex: "value",
		},
		{
			title: t("shelf_groups.product_placement_floor"),
			dataIndex: "product_placement_floor_id",
		},
		{
			title: t("common.action"),
			dataIndex: "action",
		},
	];

	const filterableColumns = [
		{
			key: "value",
			value: t("shelf_groups.value")
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