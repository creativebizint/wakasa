<template>
    <a-form-item
        :label="$t(`sales_order.invoice_number`)"
        name="invoice_number"
        :help="rules.user_id ? rules.user_id.message : null"
        :validateStatus="rules.user_id ? 'error' : null"
        class="required"
    >
        <span style="display: flex">
            <a-select
                v-model:value="orderSearchTerm"
                show-search
                :filter-option="false"
                :placeholder="
                    $t('common.select_default_text', [
                        $t(`sales_order.invoice_number`),
                    ])
                "
                style="width: 100%"
                :not-found-content="productFetching ? undefined : null"
                @search="fetchProducts"
                option-label-prop="label"
                @select="searchValueSelected"
                :disabled="editOrderDisable"
            >
                <template #suffixIcon><SearchOutlined /></template>
                <template v-if="productFetching" #notFoundContent>
                    <a-spin size="small" />
                </template>
                <a-select-option
                    v-for="sales in products"
                    :key="sales.xid"
                    :value="sales.xid"
                    :label="sales.invoice_number"
                    :product="sales"
                >
                    {{ sales.invoice_number }}
                    
                </a-select-option>
            </a-select>
        </span>
    </a-form-item>
</template>

<script>
import { defineComponent, watch, ref, toRefs, reactive } from "vue";
import { SearchOutlined } from "@ant-design/icons-vue";
import { debounce } from "lodash-es";
import SupplierAddButton from "../../users/SupplierAddButton.vue";
import CustomerAddButton from "../../users/CustomerAddButton.vue";

export default defineComponent({
    props: ["orderPageObject", "rules", "usersList", "editOrderDisable","resetTrigger"],
    emits: ["onSuccess"],
    components: {
        SearchOutlined,

        SupplierAddButton,
        CustomerAddButton,
    },
    setup(props, { emit }) {
        const state = reactive({
            orderSearchTerm: [],
            productFetching: false,
            products: [],
        });
        
        // Watch for changes in resetTrigger to reset state
        watch(
            () => props.resetTrigger,
            () => {
                state.orderSearchTerm = null;
                state.products = [];
                state.productFetching = false;
            }
        );

        const fetchProducts = debounce((value) => {
            state.products = [];

            if (value != "") {
                const newValue = value.trim();
                state.productFetching = true;
                const filterString = `invoice_number lk "${newValue}%" and order_status lk "ordered"`;
                let url = `inventory_out?fields=id,total_items,total_quantity,xid,unique_id,warehouse_id,x_warehouse_id,warehouse{id,xid,name},from_warehouse_id,x_from_warehouse_id,fromWarehouse{id,xid,name},invoice_number,order_type,order_date,tax_amount,discount,shipping,subtotal,paid_amount,due_amount,order_status,payment_status,total,tax_rate,staff_user_id,x_staff_user_id,staffMember{id,xid,name,profile_image,profile_image_url,shipping_address,tax_number,email,user_type},user_id,x_user_id,user{id,xid,user_type,name,email,address,tax_number,profile_image,profile_image_url,phone},user:details{opening_balance,opening_balance_type,credit_period,credit_limit,due_amount,warehouse_id,x_warehouse_id},orderPayments{id,xid,amount,payment_id,x_payment_id},orderPayments:payment{id,xid,payment_number,amount,payment_mode_id,x_payment_mode_id,date,notes},orderPayments:payment:paymentMode{id,xid,name},items{id,xid,product_id,x_product_id,unit_id,x_unit_id,single_unit_price,unit_price,quantity,tax_rate,total_tax,tax_type,total_discount,subtotal,mrp,quantity_scanned,quantity_qrcode},items:unit{id,xid,name,short_name},items:product{id,xid,name,item_id,item_code,subgroup2,text1,image,image_url,description,uom_sale_in},items:product:unit{id,xid,name,short_name},items:product:uomBuyIn{id,xid,name,short_name},items:product:details{id,xid,warehouse_id,x_warehouse_id,product_id,x_product_id,current_stock},items:orderItemTaxes{id,xid,order_item_id,order_item_id,tax_name,tax_amount},cancelled,terms_condition,shippingAddress{id,xid,order_id,name,email,phone,address,address,city,state,country,zipcode},sales_by&filters=${encodeURIComponent(filterString)}`;

                axiosAdmin.get(url).then((response) => {
                    state.products = response.data;
                    state.productFetching = false;
                });
            }
        }, 300);

        const searchValueSelected = (value, option) => {
            const customerName = option.product?.user?.name || "Unknown Customer";
            const customerId = option.product?.user?.xid || "";
            const shipping_address = option.product?.shipping_address || "";
            const customer_address = option.product?.user?.address || "";
            const address = shipping_address !== '' ? shipping_address : customer_address;
            const sales_id = option.product.xid;
            console.log("Emitting Data:", { sales_id, customerId, customerName, address });
            emit("onSuccess", { sales_id,customerId, customerName, address });
        };

        watch(
            () => props.usersList,
            (newVal, oldVal) => {
                    state.products = [newVal];
                    state.orderSearchTerm = newVal.xid;
                }
        );

        return {
            ...toRefs(state),
            fetchProducts,
            searchValueSelected,
        };
    },
});
</script>
