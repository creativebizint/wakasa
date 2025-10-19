import { useI18n } from "vue-i18n";

const fields = () => {
	const { t } = useI18n();
	const stockHistoryHashableColumns = ['product_id'];
	const orderItemsHashableColumns = ['product_id'];

	const productOrderColumns = [
		{
			title: t("common.invoice_number"),
			dataIndex: "invoice_number",
		},
                {
			title: t("stock.order_date"),
			dataIndex: "order_date",
		},
                {
			title: t("stock.order_type"),
			dataIndex: "order_type",
		},
		{
			title: t("product.quantity"),
			dataIndex: "quantity",
		},
		
	];
        
	const productActivationColumns = [
		{
                    title: t("barcode.string"),
                    dataIndex: "string",
                    sorter:true
                },
                {
                    title: t("barcode.status"),
                    dataIndex: "isactive",
                    sorter:true
                },
                {
                    title: t("barcode.invoice_number"),
                    dataIndex: "invoice_number",
                    sorter:true
                },
                {
                    title: t("barcode.reason"),
                    dataIndex: "reason",
                    sorter:true
                },
                {
                    title: t("barcode.comment"),
                    dataIndex: "comment",
                    sorter:true
                },
		
	];

	const stockHistoryColumns = [
		{
			title: t("common.date"),
			dataIndex: "created_at",
		},
		{
			title: t("stock.order_type"),
			dataIndex: "order_type",
		},
		{
			title: t("product.quantity"),
			dataIndex: "quantity",
		},
		{
			title: t("product.stocks"),
			dataIndex: "stock_type",
		},
		{
			title: t("stock.remarks"),
			dataIndex: "action_type",
		},
	];


	return {
		productOrderColumns,
		stockHistoryColumns,
		stockHistoryHashableColumns,
		orderItemsHashableColumns,
                productActivationColumns,
	}
}

export default fields;