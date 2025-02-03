
<script>
import { computed } from "vue";
import {
	PlusOutlined,
	TeamOutlined,
	UserOutlined,
	SolutionOutlined,
	AppstoreOutlined,
	ShopOutlined,
	ShoppingOutlined,
	WalletOutlined,
	PlusCircleOutlined,
	BarsOutlined,
	CoffeeOutlined,
	CreditCardOutlined,
	DollarOutlined,
	HddOutlined,
	ApartmentOutlined,
	TranslationOutlined,
	FundViewOutlined,
	AccountBookOutlined,
	ScheduleOutlined,
} from "@ant-design/icons-vue";
import common from "../composable/common";
import StaffAddButton from "../../main/views/users/StaffAddButton.vue";
import CustomerAddButton from "../../main/views/users/CustomerAddButton.vue";
import SupplierAddButton from "../../main/views/users/SupplierAddButton.vue";
import BrandAddButton from "../../main/views/product-manager/brands/AddButton.vue";
import CategoryAddButton from "../../main/views/product-manager/categories/AddButton.vue";
import ProductAddButton from "../../main/views/product-manager/products/AddButton.vue";
import ExpenseAddButton from "../../main/views/expense-manager/expenses/AddButton.vue";
import ExpenseCategoryAddButton from "../../main/views/expense-manager/expense-categories/AddButton.vue";
import CurrencyAddButton from "../../main/views/common/settings/currency/AddButton.vue";
import WarehouseAddButton from "../../main/views/settings/warehouses/AddButton.vue";
import UnitAddButton from "../../main/views/settings/units/AddButton.vue";
import LanguageAddButton from "../../main/views/common/settings/translations/langs/AddButton.vue";
import RoleAddButton from "../../main/views/settings/roles/AddButton.vue";
import TaxAddButton from "../../main/views/settings/taxes/AddButton.vue";
import PaymentModeAddButton from "../../main/views/settings/payment-modes/AddButton.vue";

export default {
	props: {
		position: {
			default: "bottom",
		},
	},
	components: {
		PlusOutlined,
		TeamOutlined,
		UserOutlined,
		AppstoreOutlined,
		ShopOutlined,
		ShoppingOutlined,
		WalletOutlined,
		PlusCircleOutlined,
		SolutionOutlined,
		BarsOutlined,
		CoffeeOutlined,
		CreditCardOutlined,
		DollarOutlined,
		HddOutlined,
		ApartmentOutlined,
		TranslationOutlined,
		FundViewOutlined,
		AccountBookOutlined,
		ScheduleOutlined,

		StaffAddButton,
		CustomerAddButton,
		SupplierAddButton,
		BrandAddButton,
		CategoryAddButton,
		ProductAddButton,
		ExpenseCategoryAddButton,
		ExpenseAddButton,
		CurrencyAddButton,
		WarehouseAddButton,
		UnitAddButton,
		LanguageAddButton,
		RoleAddButton,
		TaxAddButton,
		PaymentModeAddButton,
	},
	setup(props, { emit }) {
		const { permsArray, appSetting, addMenus } = common();
		const menuSelected = () => {};
		const affixStyle = computed(() => {
			if (props.position == "bottom") {
				if (appSetting.value.rtl) {
					return { position: "fixed", left: "40px", bottom: "30px" };
				} else {
					return { position: "fixed", right: "40px", bottom: "30px" };
				}
			} else {
				return {};
			}
		});

		return {
			permsArray,
			appSetting,
			addMenus,
			menuSelected,
			affixStyle,

			innerWidth: window.innerWidth,
		};
	},
};
</script>
