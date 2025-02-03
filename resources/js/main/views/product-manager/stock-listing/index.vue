<template>
    <AdminPageHeader>
        <template #header>
            <a-page-header :title="$t(`menu.stock_listing`)" class="p-0" />
        </template>
        <template #breadcrumb>
            <a-breadcrumb separator="-" style="font-size: 12px">
                <a-breadcrumb-item>
                    <router-link :to="{ name: 'admin.dashboard.index' }">
                        {{ $t(`menu.dashboard`) }}
                    </router-link>
                </a-breadcrumb-item>
                <a-breadcrumb-item>
                    {{ $t(`menu.stock_listing`) }}
                </a-breadcrumb-item>
            </a-breadcrumb>
        </template>
    </AdminPageHeader>

    <admin-page-filters>
        <a-row :gutter="[16, 16]">
            <a-col :xs="24" :sm="24" :md="24" :lg="24" :xl="24">
                <a-space>
                    <a-typography-link :href="exportUrl" target="_blank">
                        <a-button type="primary">
                            <FileExcelOutlined />
                            {{ $t("common.export") }}
                            {{ $t("menu.stock_listing") }}
                        </a-button>
                    </a-typography-link>
                </a-space>
            </a-col>
            <a-col :xs="24" :sm="24" :md="24" :lg="24" :xl="24">
                <a-row :gutter="[16, 16]">
                    <a-col :xs="24" :sm="24" :md="8" :lg="8" :xl="4">
                        <a-input-search
                            v-model:value="table.searchString"
                            show-search
                            style="width: 100%"
                            :loading="table.filterLoading"
                            :placeholder="$t('common.search')"
                        />
                    </a-col>

                    <a-col :xs="24" :sm="24" :md="8" :lg="8" :xl="4">
                        <a-select
                            v-model:value="filters.warehouse_id"
                            :placeholder="
                                $t('common.select_default_text', [
                                    $t('warehouse.warehouse'),
                                ])
                            "
                            :allowClear="true"
                            style="width: 100%"
                            optionFilterProp="title"
                            show-search
                            @change="setUrlData"
                        >
                            <a-select-option
                                v-for="warehouse in warehouses"
                                :key="warehouse.xid"
                                :title="warehouse.name"
                                :value="warehouse.xid"
                            >
                                {{ warehouse.name }}
                            </a-select-option>
                        </a-select>
                    </a-col>

                    <a-col :xs="24" :sm="24" :md="8" :lg="8" :xl="4">
                        <a-select
                            v-model:value="filters.brand_id"
                            :placeholder="
                                $t('common.select_default_text', [
                                    $t('product.brand'),
                                ])
                            "
                            :allowClear="true"
                            style="width: 100%"
                            optionFilterProp="title"
                            show-search
                            @change="setUrlData"
                        >
                            <a-select-option
                                v-for="brand in brands"
                                :key="brand.xid"
                                :title="brand.name"
                                :value="brand.xid"
                            >
                                {{ brand.name }}
                            </a-select-option>
                        </a-select>
                    </a-col>

                    <a-col :xs="24" :sm="24" :md="8" :lg="8" :xl="4">
                        <a-select
                            v-model:value="filters.category_id"
                            :placeholder="
                                $t('common.select_default_text', [
                                    $t('product.category'),
                                ])
                            "
                            :allowClear="true"
                            style="width: 100%"
                            optionFilterProp="title"
                            show-search
                            @change="setUrlData"
                        >
                            <a-select-option
                                v-for="category in categories"
                                :key="category.xid"
                                :title="category.name"
                                :value="category.xid"
                            >
                                {{ category.name }}
                            </a-select-option>
                        </a-select>
                    </a-col>

                    <a-col :xs="24" :sm="24" :md="8" :lg="8" :xl="4">
                        <DateTimePicker
                            :dateTime="filters.stock_listing_date"
                            @dateTimeChanged="
                                (changedDateTime) => {
                                    filters.stock_listing_date =
                                        changedDateTime;
                                    setUrlData();
                                }
                            "
                        />
                    </a-col>
                </a-row>
            </a-col>
        </a-row>
    </admin-page-filters>

    <admin-page-table-content>
        <AddEdit
            :addEditType="addEditType"
            :visible="addEditVisible"
            :url="addEditUrl"
            @addEditSuccess="addEditSuccess"
            @addAndNewSuccess="addAndNewSuccess"
            @addAndContinueSuccess="addAndContinueSuccess"
            @closed="onCloseAddEdit"
            :formData="formData"
            :data="viewData"
            :pageTitle="pageTitle"
            :successMessage="successMessage"
        />

        <ProductView
            :product="viewData"
            :visible="detailsVisible"
            :warehouse_id="filters.warehouse_id"
            @closed="onCloseDetails"
        />

        <SubscriptionModuleVisibilityMessage moduleName="product" />

        <!-- <a-row :gutter="16">
            <a-col :span="24">
                <a-tabs v-model:activeKey="productType" @change="setUrlData">
                    <a-tab-pane key="single">
                        <template #tab>
                            <span>
                                <AppstoreAddOutlined />
                                {{ $t("variations.single_type_product") }}
                            </span>
                        </template>
                    </a-tab-pane>
                    <a-tab-pane key="variable">
                        <template #tab>
                            <span>
                                <ClusterOutlined />
                                {{ $t("variations.variant_type_product") }}
                            </span>
                        </template>
                    </a-tab-pane>
                </a-tabs>
            </a-col>
        </a-row> -->

        <a-row>
            <a-col :span="24">
                <div class="table-responsive">
                    <a-table
                        :columns="columns"
                        :row-key="(record) => record.xid"
                        :data-source="table.data"
                        :pagination="table.pagination"
                        :loading="table.loading"
                        @change="handleTableChange"
                        bordered
                        size="middle"
                    >
                        <template #bodyCell="{ column, text, record }">
                            <template
                                v-if="
                                    column.dataIndex === 'status' &&
                                    record &&
                                    record.details
                                "
                            >
                                <a-popover
                                    v-if="
                                        record.details.status == 'out_of_stock'
                                    "
                                    placement="top"
                                >
                                    <template #content>
                                        {{ $t("common.out_of_stock") }}
                                    </template>
                                    <a-badge status="error" />
                                </a-popover>
                                <a-badge v-else status="success" />
                            </template>
                            <template v-if="column.dataIndex === 'name'">
                                <a-badge>
                                    <a-avatar
                                        shape="square"
                                        :src="record.image_url"
                                    />
                                    {{ record.name }}
                                </a-badge>
                            </template>
                            <template
                                v-if="column.dataIndex === 'warehouse_id'"
                            >
                                {{ record.warehouse_name }}
                            </template>
                            <template v-if="column.dataIndex === 'category_id'">
                                {{ record.category_name }}
                            </template>
                            <template v-if="column.dataIndex === 'brand_id'">
                                {{ record.brand_name }}
                            </template>

                            <template
                                v-if="column.dataIndex === 'purchase_price'"
                            >
                                {{
                                    formatAmountCurrency(record.purchase_price)
                                }}
                            </template>
                            <template
                                v-if="column.dataIndex === 'purchase_price_20'"
                            >
                                {{
                                    formatAmountCurrency(
                                        record.purchase_price +
                                            record.purchase_price * 0.2
                                    )
                                }}
                            </template>
                            <template
                                v-if="column.dataIndex === 'current_stock'"
                            >
                                {{
                                    `${record.current_stock} ${record.unit_short_name}`
                                }}
                            </template>

                            <!--* ADDENDUM -->
                            <template
                                v-if="
                                    column.dataIndex === 'retail_counter_price'
                                "
                            >
                                <span
                                    v-if="
                                        productType == 'single' &&
                                        record &&
                                        record.details
                                    "
                                >
                                    {{
                                        formatAmountCurrency(
                                            record.details.retail_counter_price
                                        )
                                    }}
                                </span>
                                <span v-else-if="productType == 'variable'">
                                    {{
                                        getVariableProductPurchasePrice(record)
                                    }}
                                </span>
                            </template>
                            <template
                                v-if="
                                    column.dataIndex === 'special_counter_price'
                                "
                            >
                                <span
                                    v-if="
                                        productType == 'single' &&
                                        record &&
                                        record.details
                                    "
                                >
                                    {{
                                        formatAmountCurrency(
                                            record.details.special_counter_price
                                        )
                                    }}
                                </span>
                                <span v-else-if="productType == 'variable'">
                                    {{
                                        getVariableProductPurchasePrice(record)
                                    }}
                                </span>
                            </template>
                            <template
                                v-if="
                                    column.dataIndex ===
                                    'discount_counter_price'
                                "
                            >
                                <span
                                    v-if="
                                        productType == 'single' &&
                                        record &&
                                        record.details
                                    "
                                >
                                    {{
                                        record.details.discount_counter_price +
                                        (record.details
                                            .discount_counter_price == "SP"
                                            ? ""
                                            : "%")
                                    }}
                                </span>
                                <span v-else-if="productType == 'variable'">
                                    {{
                                        getVariableProductPurchasePrice(record)
                                    }}
                                </span>
                            </template>
                            <template
                                v-if="
                                    column.dataIndex === 'retail_online_price'
                                "
                            >
                                <span
                                    v-if="
                                        productType == 'single' &&
                                        record &&
                                        record.details
                                    "
                                >
                                    {{
                                        formatAmountCurrency(
                                            record.details.retail_online_price
                                        )
                                    }}
                                </span>
                                <span v-else-if="productType == 'variable'">
                                    {{
                                        getVariableProductPurchasePrice(record)
                                    }}
                                </span>
                            </template>
                            <template
                                v-if="
                                    column.dataIndex === 'special_online_price'
                                "
                            >
                                <span
                                    v-if="
                                        productType == 'single' &&
                                        record &&
                                        record.details
                                    "
                                >
                                    {{
                                        formatAmountCurrency(
                                            record.details.special_online_price
                                        )
                                    }}
                                </span>
                                <span v-else-if="productType == 'variable'">
                                    {{
                                        getVariableProductPurchasePrice(record)
                                    }}
                                </span>
                            </template>
                            <template
                                v-if="
                                    column.dataIndex === 'discount_online_price'
                                "
                            >
                                <span
                                    v-if="
                                        productType == 'single' &&
                                        record &&
                                        record.details
                                    "
                                >
                                    {{
                                        record.details.discount_online_price +
                                        (record.details.discount_online_price ==
                                        "SP"
                                            ? ""
                                            : "%")
                                    }}
                                </span>
                                <span v-else-if="productType == 'variable'">
                                    {{
                                        getVariableProductPurchasePrice(record)
                                    }}
                                </span>
                            </template>

                            <template v-if="column.dataIndex === 'action'">
                                <a-space>
                                    <a-button
                                        @click="viewItem(record)"
                                        type="primary"
                                    >
                                        <template #icon
                                            ><EyeOutlined
                                        /></template>
                                    </a-button>
                                </a-space>
                            </template>
                        </template>
                        <template
                            v-if="productType == 'variable'"
                            #expandedRowRender="productData"
                        >
                            <a-table
                                v-if="
                                    productData &&
                                    productData.record &&
                                    productData.record.variations
                                "
                                :columns="variantColumns"
                                :row-key="(record) => record.xid"
                                :data-source="productData.record.variations"
                                :pagination="false"
                                size="middle"
                            >
                                <template #bodyCell="{ column, text, record }">
                                    <template
                                        v-if="column.dataIndex === 'name'"
                                    >
                                        {{ record.name }}
                                    </template>
                                    <template
                                        v-if="
                                            column.dataIndex ===
                                                'sales_price' &&
                                            record &&
                                            record.details
                                        "
                                    >
                                        {{
                                            formatAmountCurrency(
                                                record.details.sales_price
                                            )
                                        }}
                                    </template>
                                    <template
                                        v-if="
                                            column.dataIndex ===
                                                'purchase_price' &&
                                            record &&
                                            record.details
                                        "
                                    >
                                        {{
                                            formatAmountCurrency(
                                                record.details.purchase_price
                                            )
                                        }}
                                    </template>
                                    <template
                                        v-if="
                                            column.dataIndex ===
                                                'current_stock' &&
                                            record &&
                                            record.details
                                        "
                                    >
                                        {{
                                            `${record.details.current_stock} ${productData.record.unit.short_name}`
                                        }}
                                    </template>
                                    <template
                                        v-if="column.dataIndex === 'action'"
                                    >
                                        <a-button
                                            @click="viewItem(record)"
                                            type="links"
                                        >
                                            <template #icon
                                                ><EyeOutlined
                                            /></template>
                                        </a-button>
                                    </template>
                                </template>
                            </a-table>
                        </template>
                    </a-table>
                </div>
            </a-col>
        </a-row>
    </admin-page-table-content>
</template>
<script>
import { onMounted, ref, watch } from "vue";
import {
    EyeOutlined,
    PlusOutlined,
    EditOutlined,
    DeleteOutlined,
    ClusterOutlined,
    AppstoreAddOutlined,
    FileExcelOutlined,
} from "@ant-design/icons-vue";
import { maxBy, minBy, sumBy, debounce } from "lodash-es";
import crud from "../../../../common/composable/crud";
import common from "../../../../common/composable/common";
import fields from "./fields";
import ProductInfo from "../../../../common/components/product/ProductInfo.vue";
import AddEdit from "./AddEdit.vue";
import ProductView from "./View.vue";
import AdminPageHeader from "../../../../common/layouts/AdminPageHeader.vue";
import ImportProducts from "../../../../common/core/ui/Import.vue";
import SubscriptionModuleVisibility from "../../../../common/components/common/visibility/SubscriptionModuleVisibility.vue";
import SubscriptionModuleVisibilityMessage from "../../../../common/components/common/visibility/SubscriptionModuleVisibilityMessage.vue";
import DateTimePicker from "../../../../common/components/common/calendar/DateTimePicker.vue";

export default {
    components: {
        EyeOutlined,
        PlusOutlined,
        EditOutlined,
        DeleteOutlined,
        ClusterOutlined,
        AppstoreAddOutlined,
        FileExcelOutlined,
        AddEdit,
        ProductView,
        ProductInfo,
        AdminPageHeader,
        ImportProducts,

        SubscriptionModuleVisibility,
        SubscriptionModuleVisibilityMessage,
        DateTimePicker,
    },
    setup() {
        const {
            addEditUrl,
            initData,
            columns,
            variantColumns,
            filterableColumns,
            hashableColumns,
            multiDimensalObjectColumns,
        } = fields();
        const crudVariables = crud();
        const {
            appSetting,
            formatAmountCurrency,
            getRecursiveCategories,
            filterTreeNode,
        } = common();
        const filters = ref({
            warehouse_id: undefined,
            category_id: undefined,
            brand_id: undefined,
            stock_listing_date: undefined,
        });
        const sampleFileUrl = window.config.product_sample_file;
        const exportUrl = ref("");

        const categories = ref([]);
        const brands = ref([]);
        const warehouses = ref([]);
        const warehouseError = ref(false);

        const productType = ref("single");

        onMounted(() => {
            getInitialData();

            crudVariables.crudUrl.value = addEditUrl;
            crudVariables.langKey.value = "product";
            crudVariables.initData.value = { ...initData };
            crudVariables.formData.value = { ...initData };
            crudVariables.hashableColumns.value = [...hashableColumns];
            crudVariables.multiDimensalObjectColumns.value = {
                ...multiDimensalObjectColumns,
            };
        });

        //* ADDENDUM
        const setUrlData = () => {
            var url = `stock-listing?searchTerm=${crudVariables.table.searchString}&brand_id=${filters.value.brand_id}&category_id=${filters.value.category_id}&stock_listing_date=${filters.value.stock_listing_date}&warehouse_id=${filters.value.warehouse_id}`;
            crudVariables.tableUrl.value = {
                url,
                filters,
            };

            crudVariables.table.filterableColumns = filterableColumns;

            crudVariables.fetch({
                page: 1,
            });

            exportUrl.value = `${window.config.stock_listing_export_url}?searchTerm=${crudVariables.table.searchString}&brand_id=${filters.value.brand_id}&category_id=${filters.value.category_id}&stock_listing_date=${filters.value.stock_listing_date}&warehouse_id=${filters.value.warehouse_id}`;
        };

        const getInitialData = () => {
            const warehousesPromise = axiosAdmin.get("warehouses?limit=10000");
            const categoriesPromise = axiosAdmin.get("categories?limit=10000");
            const brandsPromise = axiosAdmin.get("brands?limit=10000");

            Promise.all([
                warehousesPromise,
                categoriesPromise,
                brandsPromise,
            ]).then(
                ([
                    warehousesResponse,
                    categoriesResponse,
                    brandsResponse,
                ]) => {
                    var warehouses_all = [
                        { name: "All", profile_image: "", xid: "" },
                    ];
                    var warehouses__ = warehouses_all.concat(
                        warehousesResponse.data
                    );
                    warehouses.value = warehouses__;

                    categories.value = categoriesResponse.data;
                    brands.value = brandsResponse.data;
                }
            );
        };

        const getVariableProductSalePrice = (record) => {
            var priceString = "";
            const minRecord = minBy(record.variations, (o) => {
                return o.details.sales_price;
            });
            const maxRecord = maxBy(record.variations, (o) => {
                return o.details.sales_price;
            });

            if (minRecord && minRecord.details.sales_price) {
                priceString += formatAmountCurrency(
                    minRecord.details.sales_price
                );
            }

            if (maxRecord && maxRecord.details.sales_price) {
                priceString +=
                    " - " + formatAmountCurrency(maxRecord.details.sales_price);
            }

            return priceString;
        };

        const getVariableProductPurchasePrice = (record) => {
            var priceString = "";
            const minRecord = minBy(record.variations, (o) => {
                return o.details.purchase_price;
            });
            const maxRecord = maxBy(record.variations, (o) => {
                return o.details.purchase_price;
            });

            if (minRecord && minRecord.details.sales_price) {
                priceString += formatAmountCurrency(
                    minRecord.details.purchase_price
                );
            }

            if (maxRecord && maxRecord.details.sales_price) {
                priceString +=
                    " - " +
                    formatAmountCurrency(maxRecord.details.purchase_price);
            }

            return priceString;
        };

        const getVariableProductStockSum = (record) => {
            return sumBy(record.variations, (o) => {
                return o.details.current_stock;
            });
        };

        //* ADDENDUM
        const onTableSearch = debounce(() => {
            console.log("debounce");
            setUrlData();
        }, 400);

        watch([() => crudVariables.table.searchString], (newVal, oldVal) => {
            console.log(newVal);
            console.log("watch");
            onTableSearch();
        });

        return {
            columns,
            variantColumns,
            appSetting,
            ...crudVariables,
            formatAmountCurrency,

            categories,
            brands,
            filters,
            filterTreeNode,
            setUrlData,
            sampleFileUrl,
            exportUrl,
            productType,

            warehouses,
            warehouseError,

            getVariableProductSalePrice,
            getVariableProductPurchasePrice,
            getVariableProductStockSum,
        };
    },
};
</script>

<style lang="less">
.ant-badge-status-dot {
    width: 8px;
    height: 8px;
}
</style>
