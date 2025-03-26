<template>
    <a-drawer
        :title="pageTitle"
        :width="drawerWidth"
        :open="visible"
        :body-style="{ paddingBottom: '80px' }"
        :footer-style="{ textAlign: 'right' }"
        :maskClosable="false"
        @close="onClose"
    >
        <a-form layout="vertical">
            <!-- <a-row :gutter="16">
                <a-col :xs="24" :sm="24" :md="24" :lg="24">
                    <a-form-item
                        :label="$t('product.product_type')"
                        name="product_type"
                        :help="rules.product_type ? rules.product_type.message : null"
                        :validateStatus="rules.product_type ? 'error' : null"
                        class="required"
                    >
                        <a-select
                            v-model:value="formData.product_type"
                            style="width: 100%"
                            :disabled="addEditType == 'edit' ? true : false"
                        >
                            <a-select-option value="single">
                                {{ $t("variations.single_type_product") }}
                            </a-select-option>
                            <a-select-option value="variable">
                                {{ $t("variations.variant_type_product") }}
                            </a-select-option>
                            <a-select-option value="service">
                                {{ $t("variations.service_type_product") }}
                            </a-select-option>
                        </a-select>
                    </a-form-item>
                </a-col>
            </a-row> -->
            <a-row :gutter="16">
                <a-col :xs="24" :sm="24" :md="8" :lg="8">
                    <a-row :gutter="16">
                        <a-col :span="24">
                            <a-form-item
                                :label="$t('product.image')"
                                name="image"
                                :help="rules.image ? rules.image.message : null"
                                :validateStatus="rules.image ? 'error' : null"
                            >
                                <Upload
                                    :formData="formData"
                                    folder="product"
                                    @onFileUploaded="
                                        (file) => {
                                            formData.image = file.file;
                                            formData.image_url = file.file_url;
                                        }
                                    "
                                />
                            </a-form-item>
                        </a-col>
                    </a-row>
                </a-col>
                <a-col :xs="24" :sm="24" :md="16" :lg="16">
                    <!--<a-row :gutter="16">
                        <a-col :xs="24" :sm="24" :md="24" :lg="24">
                            <a-form-item
                                name="warehouse_id"
                                :help="
                                    rules.warehouse_id ? rules.warehouse_id.message : null
                                "
                                :validateStatus="rules.warehouse_id ? 'error' : null"
                                class="required"
                            >
                                <template #label>
                                    {{ $t("warehouse.warehouse") }}
                                </template>
                                <span
                                    v-if="permsArray.includes('admin')"
                                    style="display: flex"
                                >
                                    <a-select
                                        v-model:value="waehouseId"
                                        :placeholder="
                                            $t('common.select_default_text', [
                                                $t('warehouse.warehouse'),
                                            ])
                                        "
                                    >
                                        <a-select-option
                                            v-for="warehouse in warehouses"
                                            :key="warehouse.xid"
                                            :value="warehouse.xid"
                                        >
                                            {{ warehouse.name }}
                                        </a-select-option>
                                    </a-select>
                                    <WarehouseAddButton @onAddSuccess="warehouseAdded" />
                                </span>
                                <span v-else>
                                    <a-select
                                        :value="selectedWarehouse.xid"
                                        :placeholder="
                                            $t('common.select_default_text', [
                                                $t('warehouse.warehouse'),
                                            ])
                                        "
                                        disabled
                                    >
                                        <a-select-option :value="selectedWarehouse.xid">
                                            {{ selectedWarehouse.name }}
                                        </a-select-option>
                                    </a-select>
                                </span>
                            </a-form-item>
                        </a-col>
                    </a-row>-->
                    <a-row :gutter="16">
                        <a-col :xs="24" :sm="24" :md="12" :lg="12">
                            <a-form-item
                                :label="$t('product.barcode_symbology')"
                                name="barcode_symbology"
                                :help="
                                    rules.barcode_symbology
                                        ? rules.barcode_symbology.message
                                        : null
                                "
                                :validateStatus="rules.barcode_symbology ? 'error' : null"
                                class="required"
                            >
                                <a-select
                                    v-model:value="formData.barcode_symbology"
                                    :placeholder="
                                        $t('common.select_default_text', [
                                            $t('product.barcode_symbology'),
                                        ])
                                    "
                                >
                                    <a-select-option
                                        v-for="barcodeSym in barcodeSymbology"
                                        :key="barcodeSym.key"
                                        :value="barcodeSym.value"
                                    >
                                        {{ barcodeSym.value }}
                                    </a-select-option>
                                </a-select>
                            </a-form-item>
                        </a-col>
                        
                        <a-col :xs="24" :sm="24" :md="12" :lg="12">
                            <a-form-item
                                :label="$t('product.item_id')"
                                name="item_id"
                                :help="rules.item_id ? rules.item_id.message : null"
                                :validateStatus="rules.item_code ? 'error' : null"
                                class="required"
                            >
                                <a-input
                                    v-model:value="formData.item_id"
                                    :placeholder="
                                        $t('common.placeholder_default_text', [
                                            $t('product.item_id'),
                                        ])
                                    "
                                >
                                    <template #addonAfter>
                                        <a-space>
                                            <a-button
                                                v-if="formData.item_id == ''"
                                                type="text"
                                                size="small"
                                                @click="generateBarCodeItemId"
                                            >
                                                <template #icon>
                                                    <BarcodeOutlined />
                                                </template>
                                            </a-button>
                                            <Barcode
                                                :itemCode="formData.item_id"
                                                :barcodeSymbology="
                                                    formData.barcode_symbology
                                                "
                                                v-else
                                            />
                                        </a-space>
                                        <BarCodeScan @closed="storeScanCode" />
                                    </template>
                                </a-input>
                            </a-form-item>
                        </a-col>
                    </a-row>    
                    <a-row :gutter="16">
                        <a-col :xs="24" :sm="24" :md="12" :lg="12">
                            <a-form-item
                                :label="$t('product.item_code')"
                                name="item_code"
                                :help="rules.item_code ? rules.item_code.message : null"
                                :validateStatus="rules.item_code ? 'error' : null"
                                class="required"
                            >
                                <a-input
                                    v-model:value="formData.item_code"
                                    :placeholder="
                                        $t('common.placeholder_default_text', [
                                            $t('product.item_code'),
                                        ])
                                    "
                                >
                                    <template #addonAfter>
                                        <a-space>
                                            <a-button
                                                v-if="formData.item_code == ''"
                                                type="text"
                                                size="small"
                                                @click="generateBarCode"
                                            >
                                                <template #icon>
                                                    <BarcodeOutlined />
                                                </template>
                                            </a-button>
                                            <Barcode
                                                :itemCode="formData.item_code"
                                                :barcodeSymbology="
                                                    formData.barcode_symbology
                                                "
                                                v-else
                                            />
                                        </a-space>
                                        <BarCodeScan @closed="storeScanCode" />
                                    </template>
                                </a-input>
                            </a-form-item>
                        </a-col>
                        
                        <a-col :xs="24" :sm="24" :md="12" :lg="12">
                            <a-form-item
                                :label="$t('product.name')"
                                name="name"
                                :help="rules.name ? rules.name.message : null"
                                :validateStatus="rules.name ? 'error' : null"
                                class="required"
                            >
                                <a-input
                                    v-model:value="formData.name"
                                    :placeholder="
                                        $t('common.placeholder_default_text', [
                                            $t('product.name'),
                                        ])
                                    "
                                    v-on:keyup="
                                        formData.slug = slugify($event.target.value)
                                    "
                                />
                            </a-form-item>
                        </a-col>
                    </a-row>    
                    <a-row :gutter="16">                        
                        <a-col :xs="24" :sm="24" :md="12" :lg="12">
                            <a-form-item
                                :label="$t('product.slug')"
                                name="slug"
                                :help="rules.slug ? rules.slug.message : null"
                                :validateStatus="rules.slug ? 'error' : null"
                                class="required"
                            >
                                <a-input
                                    v-model:value="formData.slug"
                                    :placeholder="
                                        $t('common.placeholder_default_text', [
                                            $t('product.slug'),
                                        ])
                                    "
                                />
                            </a-form-item>
                        </a-col>
                        <a-col :xs="24" :sm="24" :md="12" :lg="12">
                            <a-form-item
                                :label="$t('product.priority')"
                                name="priority"
                                :help="rules.priority ? rules.priority.message : null"
                                :validateStatus="rules.priority ? 'error' : null"
                                class="required"
                            >
                                <a-input
                                    v-model:value="formData.priority"
                                    :placeholder="
                                        $t('common.placeholder_default_text', [
                                            $t('product.priority'),
                                        ])
                                    "
                                />
                            </a-form-item>
                        </a-col>
                    </a-row>

                    <a-row :gutter="16">
                        <a-col :xs="24" :sm="24" :md="12" :lg="12">
                            <a-form-item
                                :label="$t('product.part')"
                                name="part_id"
                                :help="rules.part_id ? rules.part_id.message : null"
                                :validateStatus="rules.brand_id ? 'error' : null"
                            >
                                <span style="display: flex">
                                    <a-select
                                        v-model:value="formData.part_id"
                                        :placeholder="
                                            $t('common.select_default_text', [
                                                $t('product.part'),
                                            ])
                                        "
                                        :allowClear="true"
                                        style="width: 100%"
                                        optionFilterProp="title"
                                        show-search
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
                                    <PartAddButton @onAddSuccess="partAdded" />
                                </span>
                            </a-form-item>
                        </a-col>
                        <a-col :xs="24" :sm="24" :md="12" :lg="12">
                            <a-form-item
                                :label="$t('product.category')"
                                name="category_id"
                                :help="
                                    rules.category_id ? rules.category_id.message : null
                                "
                                :validateStatus="rules.category_id ? 'error' : null"
                                class="required"
                            >
                                <span style="display: flex">
                                    <a-tree-select
                                        :key="'categories_total' + categories.length"
                                        v-model:value="formData.category_id"
                                        show-search
                                        style="width: 100%"
                                        :dropdown-style="{
                                            maxHeight: '250px',
                                            overflow: 'auto',
                                        }"
                                        :placeholder="
                                            $t('common.select_default_text', [
                                                $t('product.category'),
                                            ])
                                        "
                                        :treeData="categories"
                                        allow-clear
                                        tree-default-expand-all
                                    />
                                    <CategoryAddButton @onAddSuccess="categoryAdded" />
                                </span>
                            </a-form-item>
                        </a-col>
                        <a-col :xs="24" :sm="24" :md="12" :lg="12">
                            <a-form-item
                                :label="$t('product.brand')"
                                name="brand_id"
                                :help="rules.brand_id ? rules.brand_id.message : null"
                                :validateStatus="rules.brand_id ? 'error' : null"
                            >
                                <span style="display: flex">
                                    <a-select
                                        v-model:value="formData.brand_id"
                                        :placeholder="
                                            $t('common.select_default_text', [
                                                $t('product.brand'),
                                            ])
                                        "
                                        :allowClear="true"
                                        style="width: 100%"
                                        optionFilterProp="title"
                                        show-search
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
                                    <BrandAddButton @onAddSuccess="brandAdded" />
                                </span>
                            </a-form-item>
                        </a-col>
                    </a-row>
                    <a-row :gutter="16" :style="{ display: 'none' }">
                        <a-col
                            :xs="24"
                            :sm="24"
                            :md="formData.product_type == 'single' ? 12 : 24"
                            :lg="formData.product_type == 'single' ? 12 : 24"
                        >
                            <a-form-item
                                :label="$t('product.unit')"
                                name="unit_id"
                                :help="rules.unit_id ? rules.unit_id.message : null"
                                :validateStatus="rules.unit_id ? 'error' : null"
                            >
                                <span style="display: flex">
                                    <a-select
                                        v-model:value="formData.unit_id"
                                        :placeholder="
                                            $t('common.select_default_text', [
                                                $t('product.unit'),
                                            ])
                                        "
                                        :allowClear="true"
                                        @change="
                                            (value, option) => (selectedUnit = option)
                                        "
                                    >
                                        <a-select-option
                                            v-for="unit in units"
                                            :key="unit.xid"
                                            :value="unit.xid"
                                            :short_name="unit.short_name"
                                        >
                                            {{ unit.name }} ({{ unit.short_name }})
                                        </a-select-option>
                                    </a-select>
                                    <UnitAddButton @onAddSuccess="unitAdded" />
                                </span>
                            </a-form-item>
                        </a-col>
                        <a-col
                            v-if="formData.product_type == 'single'"
                            :xs="24"
                            :sm="24"
                            :md="12"
                            :lg="12"
                        >
                            <a-form-item
                                name="stock_quantitiy_alert"
                                :help="
                                    rules.stock_quantitiy_alert
                                        ? rules.stock_quantitiy_alert.message
                                        : null
                                "
                                :validateStatus="
                                    rules.stock_quantitiy_alert ? 'error' : null
                                "
                            >
                                <template #label>
                                    <InputLabelPopover
                                        :label="$t('product.quantitiy_alert')"
                                        :content="$t('popover.quantitiy_alert')"
                                    />
                                </template>
                                <a-input-number
                                    v-model:value="formData.stock_quantitiy_alert"
                                    :placeholder="
                                        $t('common.placeholder_default_text', [
                                            $t('product.quantitiy_alert'),
                                        ])
                                    "
                                    min="0"
                                    style="width: 100%"
                                />
                            </a-form-item>
                        </a-col>
                    </a-row>


                    <a-row :gutter="16">
                        <a-col
                            :xs="24"
                            :sm="24"
                            :md="formData.product_type == 'single' ? 12 : 24"
                            :lg="formData.product_type == 'single' ? 12 : 24"
                        >
                            <a-form-item
                                :label="$t('product.uom_sale_in')"
                                name="uom_sale_in"
                                :help="rules.uom_sale_in ? rules.uom_sale_in.message : null"
                                :validateStatus="rules.uom_sale_in ? 'error' : null"
                            >
                                <span style="display: flex">
                                    <a-select
                                        v-model:value="formData.uom_sale_in"
                                        :placeholder="
                                            $t('common.select_default_text', [
                                                $t('product.uom_sale_in'),
                                            ])
                                        "
                                        :allowClear="true"
                                        @change="
                                            (value, option) => (selectedUnit = option)
                                        "
                                    >
                                        <a-select-option
                                            v-for="unit in units"
                                            :key="unit.xid"
                                            :value="unit.xid"
                                            :short_name="unit.short_name"
                                        >
                                            {{ unit.name }} ({{ unit.short_name }})
                                        </a-select-option>
                                    </a-select>
                                    <UnitAddButton @onAddSuccess="unitAdded" />
                                </span>
                            </a-form-item>
                        </a-col>
                        <a-col
                            v-if="formData.product_type == 'single'"
                            :xs="24"
                            :sm="24"
                            :md="12"
                            :lg="12"
                        >
                            <a-form-item
                                :label="$t('product.uom_buy_in')"
                                name="uom_buy_in"
                                :help="rules.uom_buy_in ? rules.uom_buy_in.message : null"
                                :validateStatus="rules.uom_buy_in ? 'error' : null"
                            >
                                <span style="display: flex">
                                    <a-select
                                        v-model:value="formData.uom_buy_in"
                                        :placeholder="
                                            $t('common.select_default_text', [
                                                $t('product.uom_buy_in'),
                                            ])
                                        "
                                        :allowClear="true"
                                        @change="
                                            (value, option) => (selectedUnit = option)
                                        "
                                    >
                                        <a-select-option
                                            v-for="unit in units"
                                            :key="unit.xid"
                                            :value="unit.xid"
                                            :short_name="unit.short_name"
                                        >
                                            {{ unit.name }} ({{ unit.short_name }})
                                        </a-select-option>
                                    </a-select>
                                    <UnitAddButton @onAddSuccess="unitAdded" />
                                </span>
                            </a-form-item>
                        </a-col>
                    </a-row>
                    
                </a-col>
            </a-row>
            <form-item-heading>
                {{$t("product.supplier")}}
            </form-item-heading>
            <a-row :gutter="16">
                <a-col :xs="24" :sm="24" :md="12" :lg="12">
                    <a-form-item
                        :label="$t('product.supplier')"
                        name="supplier_id"
                        :help="rules.supplier_id ? rules.supplier_id.message : null"
                        :validateStatus="rules.supplier_id ? 'error' : null"
                    >
                        <span style="display: flex">
                            <a-select
                                v-model:value="formData.supplier_id"
                                :placeholder="
                                    $t('common.select_default_text', [
                                        $t('product.supplier'),
                                    ])
                                "
                                :allowClear="true"
                                style="width: 100%"
                                optionFilterProp="title"
                                show-search
                            >
                                <a-select-option
                                    v-for="supplier in suppliers"
                                    :key="supplier.xid"
                                    :title="supplier.code"
                                    :value="supplier.xid"
                                >
                                    {{ supplier.code }}
                                </a-select-option>
                            </a-select>
                        </span>
                    </a-form-item>
                </a-col>
            </a-row>


            <form-item-heading>
                {{
                    formData.product_type == "single"
                        ? $t("product.price_tax")
                        : $t("product.variant_details")
                }}
            </form-item-heading>

            <a-row :gutter="16">
                <!-- <a-col :xs="24" :sm="24" :md="6" :lg="6">
                    <a-form-item
                        :label="$t('product.tax')"
                        name="tax_id"
                        :help="rules.tax_id ? rules.tax_id.message : null"
                        :validateStatus="rules.tax_id ? 'error' : null"
                    >
                        <span style="display: flex">
                            <a-select
                                v-model:value="formData.tax_id"
                                :placeholder="
                                    $t('common.select_default_text', [$t('product.tax')])
                                "
                                :allowClear="true"
                            >
                                <a-select-option
                                    v-for="tax in taxes"
                                    :key="tax.xid"
                                    :value="tax.xid"
                                >
                                    {{ tax.name }} ({{ tax.rate }}%)
                                </a-select-option>
                            </a-select>
                            <TaxAddButton @onAddSuccess="taxAdded" />
                        </span>
                    </a-form-item>
                </a-col> -->
                <a-col
                    :xs="24"
                    :sm="24"
                    :md="6"
                    :lg="6"
                    v-if="formData.product_type == 'single'"
                >
                    <a-form-item
                        :label="$t('product.opening_stock')"
                        name="opening_stock"
                        :help="rules.opening_stock ? rules.opening_stock.message : null"
                        :validateStatus="rules.opening_stock ? 'error' : null"
                    >
                        <a-input v-model:value="formData.opening_stock" placeholder="0">
                            <template #addonAfter>
                                {{
                                    selectedUnit && selectedUnit.short_name
                                        ? selectedUnit.short_name
                                        : ""
                                }}
                            </template>
                        </a-input>
                    </a-form-item>
                </a-col>
                <a-col
                    :xs="24"
                    :sm="24"
                    :md="6"
                    :lg="6"
                    v-if="formData.product_type == 'single'"
                >
                    <a-form-item
                        :label="$t('product.opening_stock_date')"
                        name="opening_stock_date"
                        :help="
                            rules.opening_stock_date
                                ? rules.opening_stock_date.message
                                : null
                        "
                        :validateStatus="rules.opening_stock_date ? 'error' : null"
                    >
                        <a-date-picker
                            v-model:value="formData.opening_stock_date"
                            :format="appSetting.date_format"
                            valueFormat="YYYY-MM-DD"
                            style="width: 100%"
                        />
                    </a-form-item>
                </a-col>
            </a-row>

            <a-row :gutter="16" :style="{ display: 'none' }">
                <a-col
                    :xs="24"
                    :sm="24"
                    :md="8"
                    :lg="8"
                    v-if="formData.product_type == 'single'"
                >
                    <a-form-item
                        :label="$t('product.purchase_price')"
                        name="purchase_price"
                        :help="rules.purchase_price ? rules.purchase_price.message : null"
                        :validateStatus="rules.purchase_price ? 'error' : null"
                    >
                        <a-input-number
                            v-model:value="formData.purchase_price"
                            :placeholder="
                                $t('common.placeholder_default_text', [
                                    $t('product.purchase_price'),
                                ])
                            "
                            min="0"
                            style="width: 100%"
                        >
                            <template #addonBefore>
                                {{ appSetting.currency.symbol }}
                            </template>
                            
                        </a-input-number>
                    </a-form-item>
                </a-col>
                <a-col
                    :xs="24"
                    :sm="24"
                    :md="8"
                    :lg="8"
                    v-if="
                        formData.product_type == 'single' ||
                        formData.product_type == 'service'
                    "
                >
                    <a-form-item
                        :label="$t('product.sales_price')"
                        name="sales_price"
                        :help="rules.sales_price ? rules.sales_price.message : null"
                        :validateStatus="rules.sales_price ? 'error' : null"
                    >
                        <a-input-number
                            v-model:value="formData.sales_price"
                            :placeholder="
                                $t('common.placeholder_default_text', [
                                    $t('product.sales_price'),
                                ])
                            "
                            min="0"
                            style="width: 100%"
                        >
                            <template #addonBefore>
                                {{ appSetting.currency.symbol }}
                            </template>
                            
                        </a-input-number>
                    </a-form-item>
                </a-col>
                <!--<a-col
                    :xs="24"
                    :sm="24"
                    :md="8"
                    :lg="8"
                    v-if="formData.product_type == 'single'"
                >
                    <a-form-item
                        :label="$t('product.mrp')"
                        name="mrp"
                        :help="rules.mrp ? rules.mrp.message : null"
                        :validateStatus="rules.mrp ? 'error' : null"
                    >
                        <a-input-number
                            v-model:value="formData.mrp"
                            :placeholder="
                                $t('common.placeholder_default_text', [$t('product.mrp')])
                            "
                            min="0"
                            style="width: 100%"
                        >
                            <template #addonBefore>
                                {{ appSetting.currency.symbol }}
                            </template>
                        </a-input-number>
                    </a-form-item>
                </a-col>-->
            </a-row>

            <template v-if="formData.product_type == 'variable'">
                <a-alert
                    :message="$t('variations.add_variation_message')"
                    type="info"
                    show-icon
                    class="mb-20"
                />

                <AddEditVariant
                    ref="variableTypeTable"
                    :showTable="formData.product_type == 'single' ? false : true"
                    :formData="formData"
                    :variations="variations"
                    :selectedUnit="selectedUnit"
                    @variant_added="
                        (variationData) => (formData.variations = variationData)
                    "
                />
            </template>

            <form-item-heading>
                {{$t("product.subgroup")}}
            </form-item-heading>
            <a-row :gutter="16">
                <a-col :xs="24" :sm="24" :md="12" :lg="12">
                    <a-form-item
                        :label="$t('product.subgroup1')"
                        name="name"
                        :help="rules.subgroup1 ? rules.subgroup1.message : null"
                        :validateStatus="rules.subgroup1 ? 'error' : null"
                    >
                        <a-input
                            v-model:value="formData.subgroup1"
                            :placeholder="
                                $t('common.placeholder_default_text', [
                                    $t('product.subgroup1'),
                                ])
                            "                                    
                        />
                    </a-form-item>
                </a-col>
                <a-col :xs="24" :sm="24" :md="12" :lg="12">    
                    <a-form-item
                        :label="$t('product.subgroup2')"
                        name="name"
                        :help="rules.subgroup2 ? rules.subgroup2.message : null"
                        :validateStatus="rules.subgroup2 ? 'error' : null"
                    >
                        <a-input
                            v-model:value="formData.subgroup2"
                            :placeholder="
                                $t('common.placeholder_default_text', [
                                    $t('product.subgroup2'),
                                ])
                            "                                    
                        />
                    </a-form-item>
                </a-col>
            </a-row>

            <a-row :gutter="16"  :style="{ display: 'none' }">
                <a-col :xs="24" :sm="24" :md="12" :lg="12">
                    <a-form-item
                        :label="$t('product.subgroup3')"
                        name="name"
                        :help="rules.subgroup3 ? rules.subgroup3.message : null"
                        :validateStatus="rules.subgroup3 ? 'error' : null"
                    >
                        <a-input
                            v-model:value="formData.subgroup3"
                            :placeholder="
                                $t('common.placeholder_default_text', [
                                    $t('product.subgroup3'),
                                ])
                            "                                    
                        />
                    </a-form-item>
                </a-col>
                <a-col :xs="24" :sm="24" :md="12" :lg="12">    
                    <a-form-item
                        :label="$t('product.subgroup4')"
                        name="name"
                        :help="rules.subgroup4 ? rules.subgroup4.message : null"
                        :validateStatus="rules.subgroup4 ? 'error' : null"
                    >
                        <a-input
                            v-model:value="formData.subgroup4"
                            :placeholder="
                                $t('common.placeholder_default_text', [
                                    $t('product.subgroup4'),
                                ])
                            "                                    
                        />
                    </a-form-item>
                </a-col>
            </a-row>

            <a-row :gutter="16" :style="{ display: 'none' }">
                <a-col :xs="24" :sm="24" :md="12" :lg="12">
                    <a-form-item
                        :label="$t('product.subgroup5')"
                        name="name"
                        :help="rules.subgroup5 ? rules.subgroup5.message : null"
                        :validateStatus="rules.subgroup5 ? 'error' : null"
                    >
                        <a-input
                            v-model:value="formData.subgroup5"
                            :placeholder="
                                $t('common.placeholder_default_text', [
                                    $t('product.subgroup5'),
                                ])
                            "                                    
                        />
                    </a-form-item>
                </a-col>
                
            </a-row>

            <a-row :gutter="16">
                <a-col :xs="24" :sm="24" :md="12" :lg="12">    
                    <a-form-item
                        :label="$t('product.subgroup6')"
                        name="name"
                        :help="rules.subgroup6 ? rules.subgroup6.message : null"
                        :validateStatus="rules.subgroup6 ? 'error' : null"
                    >
                        <a-input
                            v-model:value="formData.subgroup6"
                            :placeholder="
                                $t('common.placeholder_default_text', [
                                    $t('product.subgroup6'),
                                ])
                            "                                    
                        />
                    </a-form-item>
                </a-col>
                <a-col :xs="24" :sm="24" :md="12" :lg="12">
                    <a-form-item
                        :label="$t('product.subgroup7')"
                        name="name"
                        :help="rules.subgroup7 ? rules.subgroup7.message : null"
                        :validateStatus="rules.subgroup7 ? 'error' : null"
                    >
                        <a-input
                            v-model:value="formData.subgroup7"
                            :placeholder="
                                $t('common.placeholder_default_text', [
                                    $t('product.subgroup7'),
                                ])
                            "                                    
                        />
                    </a-form-item>
                </a-col>
            </a-row>

            <form-item-heading>
                {{ $t("product.other") }}
            </form-item-heading>
            <a-row :gutter="16">
                <a-col
                    :xs="24"
                    :sm="24"
                    :md="6"
                    :lg="6"
                    v-for="customField in customFields"
                    :key="customField.xid"
                >
                    <a-form-item :label="customField.name" :name="customField.name">
                        <a-input
                            v-model:value="customFieldsData[customField.name]"
                            :placeholder="customField.name"
                        />
                    </a-form-item>
                </a-col>
            </a-row>

            <!-- <form-item-heading>
				{{ $t("product.wholesale_rate") }}
			</form-item-heading>
			<a-row :gutter="16">
				<a-col :xs="24" :sm="24" :md="12" :lg="12">
					<a-form-item
						:label="$t('product.wholesale_price')"
						name="wholesale_price"
						:help="
							rules.wholesale_price ? rules.wholesale_price.message : null
						"
						:validateStatus="rules.wholesale_price ? 'error' : null"
					>
						<a-input v-model:value="formData.wholesale_price" placeholder="0">
							<template #addonAfter>
								<span v-if="formData.sales_tax_type == 'inclusive'">
									{{ $t("common.with_tax") }}
								</span>
								<span v-else>{{ $t("common.without_tax") }}</span>
							</template>
						</a-input>
					</a-form-item>
				</a-col>
				<a-col :xs="24" :sm="24" :md="12" :lg="12">
					<a-form-item
						:label="$t('product.wholesale_quantity')"
						name="wholesale_quantity"
						:help="
							rules.wholesale_quantity
								? rules.wholesale_quantity.message
								: null
						"
						:validateStatus="rules.wholesale_quantity ? 'error' : null"
					>
						<a-input
							v-model:value="formData.wholesale_quantity"
							:placeholder="$t('product.enter_min_quantity')"
						>
							<template #addonAfter>
								{{
									selectedUnit && selectedUnit.short_name
										? selectedUnit.short_name
										: ""
								}}
							</template>
						</a-input>
					</a-form-item>
				</a-col>
			</a-row> -->

            <a-row>
                <a-col :xs="24" :sm="24" :md="24" :lg="24">
                    <a-form-item
                        :label="$t('product.description')"
                        name="description"
                        :help="rules.description ? rules.description.message : null"
                        :validateStatus="rules.description ? 'error' : null"
                    >
                        <a-textarea
                            v-model:value="formData.description"
                            :placeholder="
                                $t('common.placeholder_default_text', [
                                    $t('product.description'),
                                ])
                            "
                            :rows="4"
                        />
                    </a-form-item>
                </a-col>
                <a-col :xs="24" :sm="24" :md="24" :lg="24">
                    <a-form-item
                        :label="$t('product.notes')"
                        name="notes"
                        :help="rules.notes ? rules.notes.message : null"
                        :validateStatus="rules.notes ? 'error' : null"
                    >
                        <a-textarea
                            v-model:value="formData.notes"
                            :placeholder="
                                $t('common.placeholder_default_text', [
                                    $t('product.notes'),
                                ])
                            "
                            :rows="4"
                        />
                    </a-form-item>
                </a-col>
            </a-row>
            
            <form-item-heading>
                {{$t("product.packing")}}
            </form-item-heading>

            <a-row :gutter="16">
                <a-col :xs="24" :sm="24" :md="12" :lg="12">    
                    <a-form-item
                        :label="$t('product.text1')"
                        name="name"
                        :help="rules.text1 ? rules.text1.message : null"
                        :validateStatus="rules.text1 ? 'error' : null"
                    >
                        <a-input
                            v-model:value="formData.text1"
                            :placeholder="
                                $t('common.placeholder_default_text', [
                                    $t('product.text1'),
                                ])
                            "                                    
                        />
                    </a-form-item>
                </a-col>
                <a-col :xs="24" :sm="24" :md="12" :lg="12">
                    <a-form-item
                        :label="$t('product.text2')"
                        name="name"
                        :help="rules.text2 ? rules.text2.message : null"
                        :validateStatus="rules.text2 ? 'error' : null"
                    >
                        <a-input
                            v-model:value="formData.text2"
                            :placeholder="
                                $t('common.placeholder_default_text', [
                                    $t('product.text2'),
                                ])
                            "                                    
                        />
                    </a-form-item>
                </a-col>
            </a-row>

            <a-row :gutter="16">
                <a-col :xs="24" :sm="24" :md="12" :lg="12">    
                    <a-form-item
                        :label="$t('product.kemasan_jual_packing')"
                        name="name"
                        :help="rules.kemasan_jual_packing ? rules.kemasan_jual_packing.message : null"
                        :validateStatus="rules.kemasan_jual_packing ? 'error' : null"
                    >
                        <a-input
                            v-model:value="formData.kemasan_jual_packing"
                            :placeholder="
                                $t('common.placeholder_default_text', [
                                    $t('product.kemasan_jual_packing'),
                                ])
                            "                                    
                        />
                    </a-form-item>
                </a-col>
                <a-col :xs="24" :sm="24" :md="12" :lg="12">
                    <a-form-item
                        :label="$t('product.kemasan_jual_qty')"
                        name="name"
                        :help="rules.kemasan_jual_qty ? rules.kemasan_jual_qty.message : null"
                        :validateStatus="rules.kemasan_jual_qty ? 'error' : null"
                    >
                        <a-input
                            v-model:value="formData.kemasan_jual_qty"
                            :placeholder="
                                $t('common.placeholder_default_text', [
                                    $t('product.kemasan_jual_qty'),
                                ])
                            "                                    
                        />
                    </a-form-item>
                </a-col>
            </a-row>

            <a-row :gutter="16">
                <a-col :xs="24" :sm="24" :md="12" :lg="12">    
                    <a-form-item
                        :label="$t('product.kemasan_jual_weight')"
                        name="name"
                        :help="rules.kemasan_jual_weight ? rules.kemasan_jual_weight.message : null"
                        :validateStatus="rules.kemasan_jual_weight ? 'error' : null"
                    >
                        <a-input
                            v-model:value="formData.kemasan_jual_weight"
                            :placeholder="
                                $t('common.placeholder_default_text', [
                                    $t('product.kemasan_jual_weight'),
                                ])
                            "                                    
                        />
                    </a-form-item>
                </a-col>
                <a-col :xs="24" :sm="24" :md="12" :lg="12">
                    <a-form-item
                        :label="$t('product.intruksi_packing')"
                        name="name"
                        :help="rules.intruksi_packing ? rules.intruksi_packing.message : null"
                        :validateStatus="rules.intruksi_packing ? 'error' : null"
                    >
                        <a-input
                            v-model:value="formData.intruksi_packing"
                            :placeholder="
                                $t('common.placeholder_default_text', [
                                    $t('product.intruksi_packing'),
                                ])
                            "                                    
                        />
                    </a-form-item>
                </a-col>
            </a-row>

            <a-row :gutter="16">
                <a-col :xs="24" :sm="24" :md="12" :lg="12">    
                    <a-form-item
                                :label="$t('product.kemasan_jual_unit')"
                                name="kemasan_jual_unit"
                                :help="rules.kemasan_jual_unit ? rules.kemasan_jual_unit.message : null"
                                :validateStatus="rules.kemasan_jual_unit ? 'error' : null"
                            >
                        <span style="display: flex">
                            <a-select
                                v-model:value="formData.kemasan_jual_unit"
                                :placeholder="
                                    $t('common.select_default_text', [
                                        $t('product.kemasan_jual_unit'),
                                    ])
                                "
                                :allowClear="true"
                                @change="
                                    (value, option) => (selectedUnit = option)
                                "
                            >
                                <a-select-option
                                    v-for="unit in units"
                                    :key="unit.xid"
                                    :value="unit.xid"
                                    :short_name="unit.short_name"
                                >
                                    {{ unit.name }} ({{ unit.short_name }})
                                </a-select-option>
                            </a-select>
                            <UnitAddButton @onAddSuccess="unitAdded" />
                        </span>
                    </a-form-item>
                </a-col>
                <a-col :xs="24" :sm="24" :md="12" :lg="12">
                    <a-form-item
                        :label="$t('product.numeric1')"
                        name="name"
                        :help="rules.numeric1 ? rules.numeric1.message : null"
                        :validateStatus="rules.numeric1 ? 'error' : null"
                    >
                        <a-input
                            v-model:value="formData.numeric1"
                            :placeholder="
                                $t('common.placeholder_default_text', [
                                    $t('product.numeric1'),
                                ])
                            "                                    
                        />
                    </a-form-item>
                </a-col>
            </a-row>
            
        </a-form>
        <template #footer>
            <a-button
                type="primary"
                :loading="loading"
                @click="onSubmit"
                style="margin-right: 8px"
            >
                <template #icon>
                    <SaveOutlined />
                </template>
                {{ addEditType == "add" ? $t("common.create") : $t("common.update") }}
            </a-button>
            <a-button
                v-if="addEditType == 'add'"
                type="primary"
                :loading="loading"
                @click="onSubmit('add-continue')"
                style="margin-right: 8px"
            >
                <template #icon>
                    <SaveOutlined />
                </template>
                {{ $t("common.save_and_continue") }}
            </a-button>
            <a-button @click="onClose">
                {{ $t("common.cancel") }}
            </a-button>
        </template>
    </a-drawer>
</template>
<script>
import { defineComponent, ref, onMounted, watch } from "vue";
import {
    PlusOutlined,
    LoadingOutlined,
    SaveOutlined,
    BarcodeOutlined,
} from "@ant-design/icons-vue";
import { useI18n } from "vue-i18n";
import { useStore } from "vuex";
import moment from "moment";
import { forEach, find } from "lodash-es";
import apiAdmin from "../../../../common/composable/apiAdmin";
import common from "../../../../common/composable/common";
import Upload from "../../../../common/core/ui/file/Upload.vue";
import UserInfo from "../../../../common/components/user/UserInfo.vue";
import FormItemHeading from "../../../../common/components/common/typography/FormItemHeading.vue";
import InputLabelPopover from "../../../../common/components/common/typography/InputLabelPopover.vue";
import Barcode from "./Barcode.vue";
import BrandAddButton from "../brands/AddButton.vue";
import CategoryAddButton from "../categories/AddButton.vue";
import PartAddButton from "../categories/AddButton.vue";
import UnitAddButton from "../../settings/units/AddButton.vue";
import TaxAddButton from "../../settings/taxes/AddButton.vue";
import WarehouseAddButton from "../../settings/warehouses/AddButton.vue";
import AddEditVariant from "./AddEditVariant.vue";
import BarCodeScan from "./BarCodeScan.vue";

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
    components: {
        PlusOutlined,
        LoadingOutlined,
        SaveOutlined,
        Upload,
        UserInfo,
        FormItemHeading,
        InputLabelPopover,
        BarcodeOutlined,
        Barcode,
        BrandAddButton,
        CategoryAddButton,
        UnitAddButton,
        TaxAddButton,
        WarehouseAddButton,
        AddEditVariant,
        BarCodeScan,
    },
    setup(props, { emit }) {
        const { addEditRequestAdmin, loading, rules } = apiAdmin();
        const {
            permsArray,
            taxTypes,
            barcodeSymbology,
            appSetting,
            slugify,
            selectedWarehouse,
        } = common();
        const { t } = useI18n();
        const brands = ref([]);
        const suppliers = ref([]);
        const parts = ref([]);
        const categories = ref([]);
        const units = ref([]);
        const taxes = ref([]);
        const customFields = ref([]);
        const warehouses = ref([]);
        const customFieldsData = ref({});
        const selectedUnit = ref({});
        const store = useStore();
        const brandsUrl = "brands?limit=10000";
        const suppliersUrl = "suppliers?limit=10000";
        const partsUrl = "parts?limit=10000";
        const categoriesUrl = "categories?limit=10000";
        const unitsUrl = "units?limit=10000";
        const taxesUrl = "taxes?limit=10000";
        const customFieldsUrl = "custom-fields?limit=10000";
        const warehouseUrl = "warehouses?limit=10000";
        const waehouseId = ref(undefined);
        const variableTypeTable = ref(null);

        const variations = ref([]);
        const variationsUrl =
            "variations?fields=id,xid,parent_id,x_parent_id,name,subVariations{id,xid,parent_id,x_parent_id,name}&limit=10000";

        const addInputField = () => {
            // addVariationField();
        };

        onMounted(() => {
            moment.suppressDeprecationWarnings = true;
            const brandsPromise = axiosAdmin.get(brandsUrl);
            const suppliersPromise = axiosAdmin.get(suppliersUrl);
            const partsPromise = axiosAdmin.get(partsUrl);
            const categoriesPromise = axiosAdmin.get(categoriesUrl);
            const unitsPromise = axiosAdmin.get(unitsUrl);
            const taxesPromise = axiosAdmin.get(taxesUrl);
            const customFieldsPromise = axiosAdmin.get(customFieldsUrl);
            const warehousesPromise = axiosAdmin.get(warehouseUrl);
            const variationsPromise = axiosAdmin.get(variationsUrl);

            Promise.all([
                brandsPromise,
                partsPromise,
                categoriesPromise,
                unitsPromise,
                taxesPromise,
                customFieldsPromise,
                warehousesPromise,
                variationsPromise,
                suppliersPromise,
            ]).then(
                ([
                    brandsResponse,
                    partsResponse,
                    categoriesResponse,
                    unitsResponse,
                    taxesResponse,
                    customFieldsResponse,
                    warehousesResponse,
                    variationsResponse,
                    suppliersResponse,
                ]) => {
                    brands.value = brandsResponse.data;
                    parts.value = partsResponse.data;
                    units.value = unitsResponse.data;
                    taxes.value = taxesResponse.data;
                    customFields.value = customFieldsResponse.data;
                    warehouses.value = warehousesResponse.data;
                    variations.value = variationsResponse.data;
                    suppliers.value = suppliersResponse.data;

                    selectedUnit.value = find(units.value, [
                        "xid",
                        props.formData.unit_id,
                    ]);
                    selectedUnit.value = find(units.value, [
                        "xid",
                        props.formData.uom_sale_in,
                    ]);
                    selectedUnit.value = find(units.value, [
                        "xid",
                        props.formData.uom_buy_in,
                    ]);
                    selectedUnit.value = find(units.value, [
                        "xid",
                        props.formData.kemasan_jual_unit,
                    ]);

                    setCategories(categoriesResponse.data);
                }
            );
        });

        const setCategories = (categoryResponseData) => {
            // Category Tree
            const allCategoriesArray = [];
            const listArray = [];
            categoryResponseData.map((responseArray) => {
                listArray.push({
                    xid: responseArray.xid,
                    x_parent_id: responseArray.x_parent_id,
                    title: responseArray.name,
                    value: responseArray.xid,
                    // disabled: responseArray.x_parent_id == null ? true : false,
                    disabled: false,
                });
            });

            listArray.forEach((node) => {
                // No parentId means top level
                if (!node.x_parent_id) return allCategoriesArray.push(node);

                // Insert node as child of parent in listArray array
                const parentIndex = listArray.findIndex(
                    (el) => el.xid === node.x_parent_id
                );
                if (!listArray[parentIndex].children) {
                    return (listArray[parentIndex].children = [node]);
                }

                listArray[parentIndex].children.push(node);
            });

            categories.value = allCategoriesArray;
        };

        const disabledDate = (current) => {
            // Can not select days before today and today
            return current && current > moment().endOf("day");
        };

        const generateBarCode = () => {
            props.formData.item_code = parseInt(Math.random() * 10000000000);
        };

        const generateBarCodeItemId = () => {
            props.formData.item_id = parseInt(Math.random() * 10000000000);
        };

        const storeScanCode = (value) => {
            props.formData.item_code = value;
        };

        const onSubmit = (sbumitType = "add-edit") => {
            const newData = {
                ...props.formData,
                tax_id: props.formData.tax_id == null ? "" : props.formData.tax_id,
                custom_fields: customFieldsData.value,

                //additional
                warehouse_id: 1,
                product_type: "single",
                purchase_tax_type: "exclusive",
                sales_tax_type: "exclusive",
                sales_price: props.formData.sales_price,
                purchase_price: props.formData.purchase_price,
                unit_id: units.value[0].xid,
                kemasan_jual_packing: props.formData.kemasan_jual_packing,
                kemasan_jual_qty: props.formData.kemasan_jual_qty,
                kemasan_jual_weight: props.formData.kemasan_jual_weight,
                intruksi_packing: props.formData.intruksi_packing,
                text1: props.formData.text1,
                text2: props.formData.text2,
                numeric1: props.formData.numeric1,
                kemasan_jual_unit: props.formData.kemasan_jual_unit,
                uom_sale_in: props.formData.uom_sale_in,
                uom_buy_in: props.formData.uom_buy_in,
                
            };

            addEditRequestAdmin({
                url: props.url,
                data: newData,
                successMessage: props.successMessage,
                success: (res) => {
                    if (sbumitType == "add-new") {
                        emit("addAndNewSuccess", res.xid);

                        resetDataAfterModalVisible();
                    } else if (sbumitType == "add-continue") {
                        emit("addAndContinueSuccess", res.xid);

                        props.formData.slug = slugify(props.formData.name);

                        generateBarCode();

                        // Also reset the variations
                        var allNewVariationsData = [];
                        var allPreviousVariations = props.formData.variations;
                        forEach(allPreviousVariations, (allPreviousVariation) => {
                            allNewVariationsData.push({
                                ...allPreviousVariation,
                                item_code: parseInt(Math.random() * 10000000000),
                                unique_id: Math.random().toString(36).slice(2),
                            });
                        });
                        props.formData.variations = allNewVariationsData;
                        variableTypeTable.value.setDirectVariantTableData(
                            allNewVariationsData
                        );
                    } else {
                        emit("addEditSuccess", res.xid);
                    }
                },
            });
        };

        const addVariationField = (value, option) => {
            variationFields.value.push({
                item_code: "",
                purchase_price: "",
                sales_price: "",
                value: option.name,
                mrp: "",
                opening_stock: "",
                purchase_tax_type: "exclusive",
                sales_tax_type: "exclusive",
            });
        };

        const removeVariationField = (item, options) => {
            var collectionObj = find(variationFields.value, {
                value: options.name,
            });

            let index = variationFields.value.indexOf(collectionObj);

            if (index !== "") {
                variationFields.value.splice(index, 1);
            }

            if (item.id != "") {
                removedVariations.value.push(item.id);
            }
        };

        const onClose = () => {
            rules.value = {};
            emit("closed");
        };

        const brandAdded = () => {
            axiosAdmin.get(brandsUrl).then((response) => {
                brands.value = response.data;
            });
        };

        const partAdded = () => {
            axiosAdmin.get(partsUrl).then((response) => {
                parts.value = response.data;
            });
        };

        const categoryAdded = () => {
            axiosAdmin.get(categoriesUrl).then((response) => {
                setCategories(response.data);
            });
        };

        const unitAdded = () => {
            axiosAdmin.get(unitsUrl).then((response) => {
                units.value = response.data;
            });
        };

        const taxAdded = () => {
            axiosAdmin.get(taxesUrl).then((response) => {
                taxes.value = response.data;
            });
        };

        const warehouseAdded = () => {
            axiosAdmin.get(warehouseUrl).then((response) => {
                warehouses.value = response.data;
            });
        };

        const resetDataAfterModalVisible = () => {
            var newFields = {};
            forEach(customFields.value, (customField) => {
                if (
                    props.addEditType == "add" ||
                    props.formData.custom_fields.length == 0
                ) {
                    newFields[customField.name] = "";
                } else {
                    var searchedField = find(props.formData.custom_fields, [
                        "field_name",
                        customField.name,
                    ]);
                    newFields[customField.name] =
                        searchedField === undefined ? "" : searchedField.field_value;
                }
            });
            customFieldsData.value = { ...newFields };

            selectedUnit.value = find(units.value, ["xid", props.formData.unit_id]);

            waehouseId.value =
                props.addEditType == "add"
                    ? selectedWarehouse.value.xid
                    : props.data.warehouse && props.data.warehouse.xid
                    ? props.data.warehouse.xid
                    : undefined;
        };

        watch(
            () => props.visible,
            (newVal, oldVal) => {
                if (newVal == true) {
                    resetDataAfterModalVisible();
                }
            }
        );

        return {
            loading,
            rules,
            onClose,
            onSubmit,
            disabledDate,

            brands,
            parts,
            suppliers,
            categories,
            taxes,
            units,
            warehouses,

            selectedWarehouse,
            slugify,
            generateBarCode,

            drawerWidth: window.innerWidth <= 991 ? "90%" : "70%",
            appSetting,

            customFields,
            customFieldsData,
            taxTypes,
            barcodeSymbology,
            selectedUnit,

            brandAdded,
            categoryAdded,
            unitAdded,
            taxAdded,
            warehouseAdded,

            permsArray,
            waehouseId,

            variations,
            variableTypeTable,
            storeScanCode,
        };
    },
});
</script>

<style>
.ant-calendar-picker {
    width: 100%;
}
</style>
