<template>
    <a-modal
        :open="visible"
        :closable="false"
        :centered="true"
        :title="pageTitle"
        @ok="onSubmit"
    >
        <a-form layout="vertical">
            <a-row :gutter="16">
                <a-col :xs="24" :sm="24" :md="24" :lg="24">
                    <a-form-item
                        :label="$t(`stock.invoice_number`)"
                        name="invoice_number"
                        :help="
                            rules.invoice_number ? rules.invoice_number.message : null
                        "
                        :validateStatus="rules.invoice_number ? 'error' : null"
                    >
                        <a-input
                            v-model:value="formData.invoice_number"
                            :placeholder="
                                $t('common.placeholder_default_text', [
                                    $t('stock.invoice_number'),
                                ])
                            "
                        />
                        <small class="small-text-message">
                            {{ $t("stock.invoie_number_blank") }}
                        </small>
                    </a-form-item>
                </a-col>
            </a-row>

            <a-row :gutter="16">
                <a-col :xs="24" :sm="24" :md="24" :lg="24">
                    <a-form-item
                        name="warehouse_id"
                        :help="rules.warehouse_id ? rules.warehouse_id.message : null"
                        :validateStatus="rules.warehouse_id ? 'error' : null"
                        class="required"
                    >
                        <template #label>
                            {{ $t("warehouse.warehouse") }}
                        </template>
                        <span style="display: flex">
                            <a-select
                                v-model:value="formData.warehouse_id"
                                :placeholder="
                                    $t('common.select_default_text', [
                                        $t('warehouse.warehouse'),
                                    ])
                                "
                                :allowClear="true"
                                optionFilterProp="title"
                                show-search
                                @change="warehouseChanged"
                            >
                                <a-select-option
                                    v-for="warehouse in allWarehouses"
                                    :key="warehouse.xid"
                                    :value="warehouse.xid"
                                    :title="warehouse.name"
                                >
                                    {{ warehouse.name }}
                                </a-select-option>
                            </a-select>
                        </span>
                    </a-form-item>
                </a-col>
            </a-row>

            <a-row :gutter="16">
                <a-col :xs="24" :sm="24" :md="24" :lg="24">
                    <a-form-item
                        :label="$t('product.product')"
                        name="orderSearchTerm"
                        :help="rules.product_id ? rules.product_id.message : null"
                        :validateStatus="rules.product_id ? 'error' : null"
                        class="required"
                    >
                        <span style="display: flex">
                            <ProductSearchInput
                                @valueChanged="
                                    (productId) => (formData.product_id = productId)
                                "
                                @valueSuccess="getStockValue"
                                :productData="data"
                            />
                            <!-- <ProductAddButton /> -->
                        </span>
                    </a-form-item>
                </a-col>
            </a-row>

            <a-row :gutter="16">
                <a-col :xs="24" :sm="24" :md="6" :lg="6">
                    <a-form-item :label="$t('stock_adjustment.current_stock')">
                        {{ stockValue }}
                    </a-form-item>
                </a-col>
                <a-col :xs="24" :sm="24" :md="9" :lg="9">
                    <a-form-item
                        :label="$t('stock_adjustment.quantity')"
                        name="quantity"
                        :help="rules.quantity ? rules.quantity.message : null"
                        :validateStatus="rules.quantity ? 'error' : null"
                        class="required"
                    >
                        <a-input-number
                            v-model:value="formData.quantity"
                            :placeholder="
                                $t('common.placeholder_default_text', [
                                    $t('stock_adjustment.quantity'),
                                ])
                            "
                            :min="1"
                        />
                    </a-form-item>
                </a-col>
                <a-col :xs="24" :sm="24" :md="9" :lg="9">
                    <a-form-item
                        :label="$t('stock_adjustment.adjustment_type')"
                        name="adjustment_type"
                        :help="
                            rules.adjustment_type ? rules.adjustment_type.message : null
                        "
                        :validateStatus="rules.adjustment_type ? 'error' : null"
                    >
                        <a-select
                            v-model:value="formData.adjustment_type"
                            :placeholder="
                                $t('common.select_default_text', [
                                    $t('stock_adjustment.adjustment_type'),
                                ])
                            "
                        >
                            <a-select-option
                                v-for="adjustmentType in adjustmentTypes"
                                :key="adjustmentType.key"
                                :value="adjustmentType.key"
                            >
                                {{ adjustmentType.value }}
                            </a-select-option>
                        </a-select>
                    </a-form-item>
                </a-col>
            </a-row>

            <a-row :gutter="16">
                <a-col :xs="24" :sm="24" :md="24" :lg="24">
                    <a-form-item
                        :label="$t('stock_adjustment.notes')"
                        name="notes"
                        :help="rules.notes ? rules.notes.message : null"
                        :validateStatus="rules.notes ? 'error' : null"
                    >
                        <a-textarea
                            v-model:value="formData.notes"
                            :placeholder="$t('stock_adjustment.notes')"
                        />
                    </a-form-item>
                </a-col>
            </a-row>
        </a-form>
        <template #footer>
            <a-button key="submit" type="primary" :loading="loading" @click="onSubmit">
                <template #icon>
                    <SaveOutlined />
                </template>
                {{ addEditType == "add" ? $t("common.create") : $t("common.update") }}
            </a-button>
            <a-button key="back" @click="onClose">
                {{ $t("common.cancel") }}
            </a-button>
        </template>
    </a-modal>
</template>
<script>
import { defineComponent, ref, onMounted } from "vue";
import { PlusOutlined, LoadingOutlined, SaveOutlined } from "@ant-design/icons-vue";
import apiAdmin from "../../../../common/composable/apiAdmin";
import ProductAddButton from "../../product-manager/products/AddButton.vue";
import ProductSearchInput from "../../../../common/components/product/ProductSearchInput.vue";
import common from "../../../../common/composable/common";
import fields from "./fields";

export default defineComponent({
    props: [
        "formData",
        "data",
        "visible",
        "url",
        "addEditType",
        "pageTitle",
        "successMessage",
    ],
    emits: ["addEditSuccess", "closed"],
    components: {
        PlusOutlined,
        LoadingOutlined,
        SaveOutlined,
        ProductAddButton,
        ProductSearchInput,
    },
    setup(props, { emit }) {
        const { permsArray, selectedWarehouse, allWarehouses } = common();
        const { addEditRequestAdmin, loading, rules } = apiAdmin();
        const { adjustmentTypes } = fields();
        const stockValue = ref("-");

        const warehouseId = ref([]);

        const getStockValue = () => {
            if (props.formData.product_id != "") {
                axiosAdmin
                    .post("product-warehouse-stock", {
                        warehouse_id: props.formData.warehouse_id,
                        product_id: props.formData.product_id,
                    })
                    .then((response) => {
                        stockValue.value = response.data.stock;
                    });
            } else {
                stockValue.value = "-";
            }
        };

        const warehouseChanged = (selectedWarehouseId) => {
            axiosAdmin
                .post("change-warehouse", { warehouse_id: selectedWarehouseId })
        };

        onMounted(() => {
            warehouseChanged(allWarehouses.value[0]["xid"]);
        });

        const onSubmit = () => {
            addEditRequestAdmin({
                url: props.url,
                data: props.formData,
                successMessage: props.successMessage,
                success: (res) => {
                    emit("addEditSuccess", res.xid);
                },
            });
        };

        const onClose = () => {
            rules.value = {};
            emit("closed");
        };

        return {
            loading,
            rules,
            onClose,
            onSubmit,
            adjustmentTypes,
            stockValue,
            getStockValue,
            permsArray,

            //* ADDENDUM
            allWarehouses,
            warehouseId,
            warehouseChanged,
        };
    },
});
</script>
