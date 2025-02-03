<template>
    <a-form-item
        :label="$t('warehouse.warehouse')"
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
                <a-select-option
                    v-for="warehouse in products"
                    :key="warehouse.xid"
                    :value="warehouse.xid"
                    :label="warehouse.name"
                    :product="warehouse"
                >
                    {{ warehouse.name }}
                    <span v-if="warehouse.phone && warehouse.phone != ''">
                        <br />
                        {{ warehouse.phone }}
                    </span>
                </a-select-option>
            </a-select>
        </span>
    </a-form-item>
</template>

<script>
import { defineComponent, watch, ref, toRefs, reactive } from "vue";
import { SearchOutlined } from "@ant-design/icons-vue";
import { debounce } from "lodash-es";

export default defineComponent({
    props: [
        "orderPageObject",
        "orderType",
        "rules",
        "warehousesList",
        "editOrderDisable",
        "labelPrefix",
    ],
    emits: ["onSuccess"],
    components: {
        SearchOutlined,
    },
    setup(props, { emit }) {
        const state = reactive({
            orderSearchTerm: [],
            productFetching: false,
            products: [],
        });

        const fetchProducts = debounce((value) => {
            state.products = [];

            if (value != "") {
                const newValue = value.trim();
                state.productFetching = true;
                const filterString = `name lk "${newValue}%" or (phone lk "${newValue}%")`;
                let url = `warehouses?fields=id,xid,name,phone&filters=${encodeURIComponent(
                    filterString
                )}`;

                axiosAdmin.get(url).then((response) => {
                    state.products = response.data;
                    state.productFetching = false;
                });
            }
        }, 300);

        const searchValueSelected = (value, option) => {
            emit("onSuccess", value);
            warehouseChanged(value);
        };

        //* ADDENDUM
        const warehouseChanged = (selectedWarehouseId) => {
            axiosAdmin.post("change-warehouse", {
                warehouse_id: selectedWarehouseId,
            });
        };

        watch(
            () => props.warehousesList,
            (newVal, oldVal) => {
                state.products = [newVal];
                state.orderSearchTerm = newVal.xid;

                warehouseChanged(newVal.xid);
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
