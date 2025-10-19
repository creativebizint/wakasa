<template>
	<a-tabs v-model:activeKey="activeKey">
		<a-tab-pane key="product_order_items" :tab="$t('product.product_orders')">
			<ProductOrderItems :product="product" />
		</a-tab-pane>
		<a-tab-pane key="stock_activation" :tab="$t('product.stock_activation')" v-if="product.product_type != 'service'">
			<StockActivation :product="product" />
		</a-tab-pane>
		<a-tab-pane key="stock_history" :tab="$t('product.stock_out_history')" v-if="product.product_type != 'service'">
			<StockHistory :product="product" />
		</a-tab-pane>
	</a-tabs>
</template>

<script>
import { defineComponent, ref } from "vue";
import StockHistory from "./StockHistory.vue";
import ProductOrderItems from "./ProductOrderItems.vue";
import StockActivation from "./ProductActivation.vue";

export default defineComponent({
	props: ["product"],
	components: {
		StockHistory,
                StockActivation,
		ProductOrderItems,
	},
	setup() {
		return {
			activeKey: ref("product_order_items"),
		};
	},
});
</script>
