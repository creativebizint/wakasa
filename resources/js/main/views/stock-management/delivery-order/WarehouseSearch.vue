<template>
    <a-form-item
        :label="
            (labelPrefix ? $t(`common.${labelPrefix}`) : '') +
            ' ' +
            $t('warehouse.warehouse')
        "
        name="warehouse_id"
        :help="rules.warehouse_id ? rules.warehouse_id.message : null"
        :validateStatus="rules.warehouse_id ? 'error' : null"
        class="required"
    >
        <span style="display: flex">
            <a-select
                v-model:value="orderSearchTerm"
                show-search
                :filter-option="false"
                :placeholder="
                    $t('common.select_default_text', [
                        $t('warehouse.warehouse'),
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
                <a-select-option v-if="!products.length" disabled>
                    No warehouses available
                </a-select-option>
                <a-select-option
                    v-for="warehouse in products"
                    :key="warehouse.xid"
                    :value="warehouse.xid"
                    :label="warehouse.name"
                    :product="warehouse"
                >
                    {{ warehouse.name }}
                    <span v-if="warehouse.code && warehouse.code != ''">
                        <br />
                        {{ warehouse.code }}
                    </span>
                </a-select-option>
            </a-select>
        </span>
    </a-form-item>
</template>

<script>
import { defineComponent, watch, ref, toRefs, reactive, onMounted } from "vue";
import { SearchOutlined } from "@ant-design/icons-vue";
import { debounce } from "lodash-es";

export default defineComponent({
    props: {
        orderPageObject: Object,
        orderType: String,
        rules: Object,
        warehousesList: Array, // Expect an array of warehouses
        editOrderDisable: Boolean,
        labelPrefix: String,
    },
    emits: ["onSuccess"],
    components: {
        SearchOutlined,
    },
    setup(props, { emit }) {
        const state = reactive({
            orderSearchTerm: null, // Initialize as null
            productFetching: false,
            products: [],
        });

        // Set default warehouse on mount
        onMounted(() => {
            // Initialize with warehousesList if provided
            if (props.warehousesList && props.warehousesList.length) {
                state.products = props.warehousesList;
                // Set default to first warehouse or "1"
                state.orderSearchTerm = props.warehousesList.find(w => w.xid === "1")?.xid 
                    || props.warehousesList[0]?.xid 
                    || null;
                if (state.orderSearchTerm) {
                    emit("onSuccess", state.orderSearchTerm);
                    warehouseChanged(state.orderSearchTerm);
                }
            }
        });

        const fetchProducts = debounce((value) => {
            state.products = [];

            if (value) {
                const newValue = value.trim();
                state.productFetching = true;
                const filterString = `name lk "${newValue}%" or (phone lk "${newValue}%")`;
                let url = `warehouses?fields=id,xid,name,code,phone&filters=${encodeURIComponent(filterString)}`;

                axiosAdmin.get(url).then((response) => {
                    state.products = response.data || [];
                    state.productFetching = false;
                    // Set default if no selection
                    if (!state.orderSearchTerm && state.products.length) {
                        state.orderSearchTerm = state.products.find(w => w.xid === "1")?.xid 
                            || state.products[0]?.xid 
                            || null;
                        if (state.orderSearchTerm) {
                            emit("onSuccess", state.orderSearchTerm);
                            warehouseChanged(state.orderSearchTerm);
                        }
                    }
                }).catch(error => {
                    console.error('Warehouse API Error:', error);
                    state.productFetching = false;
                });
            } else {
                // Reset to warehousesList when search is cleared
                state.products = props.warehousesList || [];
                state.orderSearchTerm = props.warehousesList.find(w => w.xid === "1")?.xid 
                    || props.warehousesList[0]?.xid 
                    || null;
                if (state.orderSearchTerm) {
                    emit("onSuccess", state.orderSearchTerm);
                    warehouseChanged(state.orderSearchTerm);
                }
            }
        }, 300);

        const searchValueSelected = (value) => {
            state.orderSearchTerm = value;
            emit("onSuccess", value);
            warehouseChanged(value);
        };

        const warehouseChanged = (selectedWarehouseId) => {
            axiosAdmin.post("change-warehouse", {
                warehouse_id: selectedWarehouseId,
            }).catch(error => {
                console.error('Change Warehouse API Error:', error);
            });
        };

        // Watch warehousesList for changes
        watch(
            () => props.warehousesList,
            (newVal) => {
                state.products = newVal || [];
                if (!state.orderSearchTerm && newVal.length) {
                    state.orderSearchTerm = newVal.find(w => w.xid === "1")?.xid 
                        || newVal[0]?.xid 
                        || null;
                    if (state.orderSearchTerm) {
                        emit("onSuccess", state.orderSearchTerm);
                        warehouseChanged(state.orderSearchTerm);
                    }
                }
            }
        );

        return {
            ...toRefs(state),
            fetchProducts,
            searchValueSelected,
            warehouseChanged,
        };
    },
});
</script>