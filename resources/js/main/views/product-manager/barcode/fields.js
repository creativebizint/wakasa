import { useI18n } from "vue-i18n";

const fields = () => {
	const addEditUrl = "barcode";
	const { t } = useI18n();

	const initData = {
		string: "",
		comment: "",
		reason: "",
		item_id: "",
		isactive: "",
                kemasan_jual_qty: "",
                nik: "",
                invoice_number:"",
                qty_bungkus:"",
	};

	const columns = [
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
                    title: t("product.item_id"),
                    dataIndex: "item_id",
                    sorter:true
            },
            {
                    title: t("barcode.invoice_number"),
                    dataIndex: "invoice_number",
                    sorter:true
            },
            {
                    title: t("barcode.delivery_order_number"),
                    dataIndex: "sales_order_number",
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
            {
                    title: t("barcode.reg_bungkus_id"),
                    dataIndex: "reg_bungkus_id",
                    sorter:true
            },
            {
                    title: t("barcode.fk_reg_bungkus_id"),
                    dataIndex: "fk_reg_bungkus_id",
                    sorter:true
            },
            {
                    title: t("barcode.nik"),
                    dataIndex: "nik",
                    sorter:true
            },
            {
                    title: t("barcode.box_id"),
                    dataIndex: "box_id",
                    sorter:true
            },
            {
                    title: t("barcode.qty_bungkus"),
                    dataIndex: "qty_bungkus",
                    sorter:true
            },
            {
                    title: t("barcode.kemasan_jual_qty"),
                    dataIndex: "kemasan_jual_qty",
                    sorter:true
            },
            {
                    title: t("common.action"),
                    dataIndex: "action",
            },
	];

	const filterableColumns = [
		{
			key: "string",
			value: t("barcode.string")
		},
		{
			key: "item_id",
			value: t("product.item_id")
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