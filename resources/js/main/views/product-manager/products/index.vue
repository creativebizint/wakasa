<template>
    <AdminPageHeader>
        <template #header>
            <a-page-header :title="$t(`menu.products`)" class="p-0" />
        </template>
        <template #breadcrumb>
            <a-breadcrumb separator="-" style="font-size: 12px">
                <a-breadcrumb-item>
                    <router-link :to="{ name: 'admin.dashboard.index' }">
                        {{ $t(`menu.dashboard`) }}
                    </router-link>
                </a-breadcrumb-item>
                <a-breadcrumb-item>
                    {{ $t(`menu.product_manager`) }}
                </a-breadcrumb-item>
                <a-breadcrumb-item>
                    {{ $t(`menu.products`) }}
                </a-breadcrumb-item>
            </a-breadcrumb>
        </template>
    </AdminPageHeader>

    <admin-page-filters>
        <a-row :gutter="[16, 16]">
            <a-col :xs="24" :sm="24" :md="12" :lg="10" :xl="10">
                <a-space>
                    <template
                        v-if="
                            permsArray.includes('products_create') ||
                            permsArray.includes('admin')
                        "
                    >
                        <SubscriptionModuleVisibility moduleName="product">
                            <a-button
                                type="primary"
                                @click="
                                    () => {
                                        formData = {
                                            ...formData,
                                            product_type: productType,
                                        };
                                        addItem();
                                    }
                                "
                            >
                                <PlusOutlined />
                                {{ $t("product.add") }}
                            </a-button>
                        </SubscriptionModuleVisibility>
                        <QueueImport
                            :pageTitle="$t('product.import_products')"
                            :sampleFileUrl="sampleFileUrl"
                            importUrl="products/import"
                            context="products"
                            bus="products"
                            @onUploadSuccess="setUrlData"
                        />
                        <a-typography-link
                                :href="exportUrl"
                                target="_blank"
                            >
                            <a-button type="primary">
                                <FileExcelOutlined />
                                {{ $t("common.export") }}
                                {{ $t("menu.products") }}
                            </a-button>
                        </a-typography-link>
                    </template>
                    <a-button
                        v-if="
                            table.selectedRowKeys.length > 0 &&
                            (permsArray.includes('products_delete') ||
                                permsArray.includes('admin'))
                        "
                        type="primary"
                        @click="showSelectedDeleteConfirm"
                        danger
                    >
                        <template #icon><DeleteOutlined /></template>
                        {{ $t("common.delete") }}
                    </a-button>
                </a-space>
            </a-col>
            <a-col :xs="24" :sm="24" :md="12" :lg="14" :xl="14">
                <a-row :gutter="[16, 16]" justify="end">
                    <a-col :xs="24" :sm="24" :md="8" :lg="8" :xl="6">
                        <a-input-search
                            v-model:value="table.searchString"
                            show-search
                            @change="onTableSearch"
                            @search="onTableSearch"
                            style="width: 100%"
                            :loading="table.filterLoading"
                            :placeholder="$t('common.search')"
                        />
                    </a-col>
                    <a-col :xs="24" :sm="24" :md="8" :lg="8" :xl="6">
                        <a-select
                            v-model:value="filters.brand_id"
                            :placeholder="
                                $t('common.select_default_text', [$t('product.brand')])
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

                    <a-col :xs="24" :sm="24" :md="8" :lg="8" :xl="6">
                        <a-select
                            v-model:value="filters.part_id"
                            :placeholder="
                                $t('common.select_default_text', [$t('product.part')])
                            "
                            :allowClear="true"
                            style="width: 100%"
                            optionFilterProp="title"
                            show-search
                            @change="setUrlData"
                        >
                            <a-select-option
                                v-for="part in parts"
                                :key="part.xid"
                                :title="part.name"
                                :value="part.xid"
                            >
                                {{ part.code }}
                            </a-select-option>
                        </a-select>
                    </a-col>

                    <a-col :xs="24" :sm="24" :md="8" :lg="8" :xl="6">
                        <a-select
                            v-model:value="filters.category_id"
                            :placeholder="
                                $t('common.select_default_text', [$t('product.category')])
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
            @closed="onCloseDetails"
        />

        <ProductHistory
            :product="modelData"
            :visible="productDetailsVisible"
            @closed="onCloseProductDetails"
        />

        <SubscriptionModuleVisibilityMessage moduleName="product" />

        <a-row>
            <a-col :span="24">
                <div class="table-responsive">
                    <a-table
                        :row-selection="{
                            selectedRowKeys: table.selectedRowKeys,
                            onChange: onRowSelectChange,
                            getCheckboxProps: (record) => ({
                                disabled: false,
                                name: record.xid,
                            }),
                        }"
                        :columns="columns"
                        :row-key="(record) => record.xid"
                        :data-source="table.data"
                        :pagination="table.pagination"
                        :loading="table.loading"
                        @change="handleTableChange"
                        bordered
                        size="middle"
                    >
                        <template #bodyCell="{ column, record }">
                            <template
                                v-if="
                                    column.dataIndex === 'status' &&
                                    record &&
                                    record.details
                                "
                            >
                                <a-popover
                                    v-if="record.details.status == 'out_of_stock'"
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
                                    <a-avatar shape="square" :src="record.image_url" />
                                    <a-typography-link @click="viewItem(record)">
                                        {{ record.name }}
                                    </a-typography-link>
                                </a-badge>
                            </template>
                            <template v-if="column.dataIndex === 'warehouse_id'">
                                {{
                                    record.details &&
                                    record.details.warehouse &&
                                    record.details.warehouse.name
                                        ? record.details.warehouse.name
                                        : "-"
                                }}
                            </template>
                            <template v-if="column.dataIndex === 'category_id'">
                                {{ record.category ? record.category.name : "-" }}
                            </template>
                            <template v-if="column.dataIndex === 'brand_id'">
                                {{ record.brand ? record.brand.name : "-" }}
                            </template>
                            <template v-if="column.dataIndex === 'sales_price'">
                                <span
                                    v-if="
                                        (productType == 'single' ||
                                            productType == 'service') &&
                                        record &&
                                        record.details
                                    "
                                >
                                    {{ formatAmountCurrency(record.details.sales_price) }}
                                </span>
                                <span v-else-if="productType == 'variable'">
                                    {{ getVariableProductSalePrice(record) }}
                                </span>
                            </template>
                            <template v-if="column.dataIndex === 'purchase_price'">
                                <span
                                    v-if="
                                        productType == 'single' &&
                                        record &&
                                        record.details
                                    "
                                >
                                    {{
                                        formatAmountCurrency(
                                            record.details.purchase_price
                                        )
                                    }}
                                </span>
                                <span v-else-if="productType == 'variable'">
                                    {{ getVariableProductPurchasePrice(record) }}
                                </span>
                            </template>
                            <template v-if="column.dataIndex === 'current_stock'">
                                <a-typography-link
                                    type="primary"
                                    @click="openProductDetails(record)"
                                    style="margin-left: 4px"
                                    v-if="
                                        productType == 'single' &&
                                        record &&
                                        record.details
                                    "
                                >
                                    {{
                                        `${record.details.current_stock} ${record.unit.short_name}`
                                    }}
                                </a-typography-link>
                                <a-typography-link
                                    type="primary"
                                    @click="openProductDetails(record)"
                                    style="margin-left: 4px"
                                    v-else-if="productType == 'variable'"
                                >
                                    {{ getVariableProductStockSum(record) }}
                                </a-typography-link>
                            </template>
                            <template v-if="column.dataIndex === 'action'">
                                <a-space>
                                    <a-button @click="viewItem(record)" type="primary">
                                        <template #icon><EyeOutlined /></template>
                                    </a-button>
                                    <a-button
                                        v-if="
                                            permsArray.includes('products_edit') ||
                                            permsArray.includes('admin')
                                        "
                                        type="primary"
                                        @click="editItem(record)"
                                    >
                                        <template #icon><EditOutlined /></template>
                                    </a-button>
                                    <a-button
                                        v-if="
                                            permsArray.includes('products_delete') ||
                                            permsArray.includes('admin')
                                        "
                                        type="primary"
                                        @click="showDeleteConfirm(record.xid)"
                                    >
                                        <template #icon><DeleteOutlined /></template>
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
                                <template #bodyCell="{ column, record }">
                                    <template v-if="column.dataIndex === 'name'">
                                        {{ record.name }}
                                    </template>
                                    <template
                                        v-if="
                                            column.dataIndex === 'sales_price' &&
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
                                            column.dataIndex === 'purchase_price' &&
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
                                            column.dataIndex === 'current_stock' &&
                                            record &&
                                            record.details
                                        "
                                    >
                                        {{
                                            `${record.details.current_stock} ${productData.record.unit.short_name}`
                                        }}
                                    </template>
                                    <template v-if="column.dataIndex === 'action'">
                                        <a-button @click="viewItem(record)" type="links">
                                            <template #icon><EyeOutlined /></template>
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
import { onMounted, ref, watch, computed } from "vue";
import {
    EyeOutlined,
    PlusOutlined,
    EditOutlined,
    DeleteOutlined,
    ClusterOutlined,
    AppstoreAddOutlined,
} from "@ant-design/icons-vue";
import { maxBy, minBy, sumBy } from "lodash-es";
import { useI18n } from "vue-i18n";
import crud from "../../../../common/composable/crud";
import common from "../../../../common/composable/common";
import fields from "./fields";
import ProductInfo from "../../../../common/components/product/ProductInfo.vue";
import AddEdit from "./AddEdit.vue";
import ProductView from "./View.vue";
import AdminPageHeader from "../../../../common/layouts/AdminPageHeader.vue";
import SubscriptionModuleVisibility from "../../../../common/components/common/visibility/SubscriptionModuleVisibility.vue";
import SubscriptionModuleVisibilityMessage from "../../../../common/components/common/visibility/SubscriptionModuleVisibilityMessage.vue";
import ProductHistory from "./productHistory.vue";
import QueueImport from "../../../../common/core/ui/QueueImport.vue";

export default {
    components: {
        EyeOutlined,
        PlusOutlined,
        EditOutlined,
        DeleteOutlined,
        ClusterOutlined,
        AppstoreAddOutlined,
        AddEdit,
        ProductView,
        ProductInfo,
        AdminPageHeader,
        QueueImport,
        ProductHistory,
        SubscriptionModuleVisibility,
        SubscriptionModuleVisibilityMessage,
    },
    setup() {
        const { t } = useI18n();
        const {
            addEditUrl,
            initData,
            productType,
            columns,
            columnsNames,
            variantColumns,
            filterableColumns,
            hashableColumns,
            multiDimensalObjectColumns,
        } = fields();
        const crudVariables = crud();
        const {
            appSetting,
            permsArray,
            formatAmountCurrency,
            getRecursiveCategories,
            filterTreeNode,
            selectedWarehouse,
        } = common();
        const filters = ref({
            category_id: undefined,
            brand_id: undefined,
        });
        const sampleFileUrl = window.config.product_sample_file;
        const exportUrl = window.config.product_export_url;

        const categories = ref([]);
        const brands = ref([]);
        const parts = ref([]);
        const productDetailsVisible = ref(false);
        const modelData = ref("");

        const openProductDetails = (record) => {
            productDetailsVisible.value = true;
            modelData.value = record;
        };
        const onCloseProductDetails = () => {
            productDetailsVisible.value = false;
        };

        //* ADDENDUM
        const defaultWarehouse = ref([]);

        onMounted(() => {
            getInitialData();
            //setUrlData();

            crudVariables.crudUrl.value = addEditUrl;
            crudVariables.langKey.value = "product";
            crudVariables.initData.value = { ...initData };
            crudVariables.formData.value = { ...initData };
            crudVariables.hashableColumns.value = [...hashableColumns];
            crudVariables.multiDimensalObjectColumns.value = {
                ...multiDimensalObjectColumns,
            };
            setCrudVariables();
        });

        const setCrudVariables = () => {
            var url =
                "products?fields=id,xid,name,slug,product_type,barcode_symbology,item_id,item_code,image,image_url,category_id,x_category_id,category{id,xid,category_id,name},brand_id,x_brand_id,brand{id,xid,code,name},part_id,x_part_id,part{id,xid,name},details{sales_price,purchase_price},unit_id,x_unit_id,unit{id,xid,name,short_name},x_uom_sale_in,x_uom_buy_in,x_kemasan_jual_unit description,],details:tax{id,xid,name,rate},details:warehouse{id,xid,name},customFields{id,xid,field_name,field_value},warehouse_id,x_warehouse_id,warehouse{id,xid},supplier_id,x_supplier_id,supplier{id,xid,code,name},priority,subgroup1,subgroup2,subgroup3,subgroup4,subgroup5,subgroup6,subgroup7,notes,kemasan_jual_packing,kemasan_jual_qty,kemasan_jual_unit,kemasan_jual_weight,intruksi_packing,text1,text2,numeric1,uom_sale_in,uom_buy_in";

            // if (productType.value == "variable") {
            //     url =
            //         "products?fields=id,xid,name,product_type,slug,barcode_symbology,item_code,image,image_url,category_id,x_category_id,category{id,xid,code,name},brand_id,x_brand_id,brand{id,xid,code,name},group_id,x_group_id,group{id,xid,code,name},color_id,x_color_id,color{id,xid,code,name},unit_id,x_unit_id,unit{id,xid,name,short_name},description,details{stock_quantitiy_alert,opening_stock,opening_stock_date,wholesale_price,wholesale_quantity,mrp,purchase_price,sales_price,tax_id,x_tax_id,purchase_tax_type,sales_tax_type,current_stock,warehouse_id,x_warehouse_id,status},details:tax{id,xid,name,rate},details:warehouse{id,xid,name},customFields{id,xid,field_name,field_value},warehouse_id,x_warehouse_id,warehouse{id,xid},parent_id,x_parent_id,variations.limit(10000).offset(0){id,xid,name,slug,item_code,product_type,barcode_symbology,item_code,image,image_url,category_id,x_category_id,unit_id,x_unit_id,brand_id,x_brand_id,group_id,x_group_id,color_id,x_color_id},variations:productVariations{id,xid,product_id,x_product_id,variant_id,x_variant_id,variant_value_id,x_variant_value_id},variations:category{id,xid,code,name},variations:brand{id,xid,code,name},variations:group{id,xid,code,name},variations:color{id,xid,code,name},variations:unit{id,xid,name,short_name},variations:productVariations:variation{id,xid,name},variations:productVariations:variationType{id,xid,name},variations:details{stock_quantitiy_alert,opening_stock,opening_stock_date,wholesale_price,wholesale_quantity,mrp,purchase_price,sales_price,tax_id,x_tax_id,purchase_tax_type,sales_tax_type,current_stock,warehouse_id,x_warehouse_id,status},variations:details:tax{id,xid,name,rate},variations:details:warehouse{id,xid,name}";
            // }

            crudVariables.tableUrl.value = {
                url,
                filters,
                extraFilters: {
                    product_type: productType.value,
                    warehouse_id: defaultWarehouse.value.xid,
                },
            };

            crudVariables.table.filterableColumns = filterableColumns;
        };

        const setUrlData = () => {
            setCrudVariables();

            crudVariables.fetch({
                page: 1,
            });
        };
        const getInitialData = () => {
            const categoriesPromise = axiosAdmin.get("categories?limit=10000");
            const brandsPromise = axiosAdmin.get("brands?limit=10000");
            const partsPromise = axiosAdmin.get("parts?limit=10000");

            Promise.all([categoriesPromise, brandsPromise, partsPromise]).then(
                ([categoriesResponse, brandsResponse, partsResponse]) => {
                    categories.value = getRecursiveCategories(categoriesResponse);
                    brands.value = brandsResponse.data;
                    parts.value = partsResponse.data;
                }
            );
            
            //* ADDENDUM
            const defaultWarehousePromise = axiosAdmin.get("default-warehouse");

            Promise.all([
                categoriesPromise,
                brandsPromise,
                defaultWarehousePromise,
            ]).then(
                ([
                    categoriesResponse,
                    brandsResponse,
                    defaultWarehouseResponse,
                ]) => {
                    categories.value = categoriesResponse.data;
                    brands.value = brandsResponse.data;
                    defaultWarehouse.value = defaultWarehouseResponse.data;
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
                priceString += formatAmountCurrency(minRecord.details.sales_price);
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
                priceString += formatAmountCurrency(minRecord.details.purchase_price);
            }

            if (maxRecord && maxRecord.details.sales_price) {
                priceString +=
                    " - " + formatAmountCurrency(maxRecord.details.purchase_price);
            }

            return priceString;
        };

        const getVariableProductStockSum = (record) => {
            return sumBy(record.variations, (o) => {
                return o.details.current_stock;
            });
        };

        watch(selectedWarehouse, (newVal, oldVal) => {
            setUrlData();
        });

        const totals = computed(() => {
            let totalCurrentStock = 0;
            crudVariables.table.data.forEach((tableRowData) => {
                if (productType.value == "variable" && tableRowData.variations) {
                    totalCurrentStock += getVariableProductStockSum(tableRowData);
                } else if (
                    productType.value == "single" &&
                    tableRowData.details &&
                    tableRowData.details.current_stock
                ) {
                    totalCurrentStock += tableRowData.details.current_stock;
                }
            });
            return {
                totalCurrentStock,
            };
        });

        return {
            columns,
            variantColumns,
            appSetting,
            ...crudVariables,
            permsArray,
            formatAmountCurrency,

            categories,
            brands,
            parts,
            filters,
            filterTreeNode,
            setUrlData,
            sampleFileUrl,
            productType,

            getVariableProductSalePrice,
            getVariableProductPurchasePrice,
            getVariableProductStockSum,
            totals,
            productDetailsVisible,
            modelData,
            openProductDetails,
            onCloseProductDetails,
            exportUrl,
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
