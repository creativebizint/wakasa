import { reactive } from 'vue';
import { useI18n } from "vue-i18n";

const fields = () => {
	const addEditUrl = "stock-adjustments";
	const url = "stock-adjustments?fields=xid,product_id,x_product_id,product{id,xid,name,image,image_url,item_code,category_id,x_category_id,brand_id,x_brand_id},product:category{id,xid,code,name},product:brand{id,xid,code,name},quantity,adjustment_type,notes,invoice_number,created_by,x_created_by,createdBy{id,xid,name,code,profile_image_url}";
	const hashableColumns = ['product_id', 'warehouse_id'];
	const { t } = useI18n();

	const initData = {
		product_id: undefined,
		warehouse_id: undefined,
		quantity: 1,
		notes: "",
		adjustment_type: "add",
	};

	const columns = [
		{
            title: t("stock_adjustment.invoice_number"),
            dataIndex: "invoice_number",
        },
		{
            title: t("stock_adjustment.adjustment_date"),
            dataIndex: "date",
        },
		{
            title: t("common.created_by"),
            dataIndex: "created_by",
        },
		{
            title: t("product.item_code"),
            dataIndex: "item_code",
        },
		{
			title: t("product.product"),
			dataIndex: "product_id",
		},
		{
            title: t("product.category"),
            dataIndex: "category_id",
        },
        {
            title: t("product.brand"),
            dataIndex: "brand_id",
        },
        
		{
			title: t("stock_adjustment.quantity"),
			dataIndex: "quantity",
		},
		{
			title: t("stock_adjustment.notes"),
			dataIndex: "notes",
		},
		{
			title: t("common.action"),
			dataIndex: "action",
		},
	];

	const adjustmentTypes = [
		{
			key: "add",
			value: t("stock_adjustment.adjustment_add"),
		},
		{
			key: "subtract",
			value: t("stock_adjustment.adjustment_subtract"),
		},
	];

	const filters = reactive({
		product_id: undefined,
	});

	return {
		url,
		addEditUrl,
		hashableColumns,
		initData,
		columns,
		adjustmentTypes,
		filters,
	}
}

export default fields;
