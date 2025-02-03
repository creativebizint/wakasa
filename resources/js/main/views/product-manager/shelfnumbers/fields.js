import { useI18n } from "vue-i18n";

const fields = () => {
	const addEditUrl = "shelf-numbers";
	const url = "shelf-numbers?fields=xid,value,product_placement_shelf_group_id,x_product_placement_shelf_group_id,product_placement_shelf_group{id,xid,value},product_placement_shelf_group:product_placement_floor{id,xid,value}";
	const { t } = useI18n();
        const hashableColumns = ["product_placement_shelf_group_id"];

	const initData = {
		value: "",
                product_placement_shelf_group_id : undefined,
	};

	const columns = [
		{
			title: t("shelf_numbers.value"),
			dataIndex: "value",
		},
		{
			title: t("shelf_numbers.product_placement_shelf_group"),
			dataIndex: "product_placement_shelf_group_id",
		},
                
		{
			title: t("common.action"),
			dataIndex: "action",
		},
	];

	const filterableColumns = [
		{
			key: "value",
			value: t("shelf_numbers.value")
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