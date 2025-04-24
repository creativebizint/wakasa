<template>
    <AdminPageHeader>
        <template #header>
            <a-page-header
                :title="$t(`menu.${orderPageObject.menuKey}`)"
                @back="() => $router.go(-1)"
                class="p-0"
            >
                <!-- <template #extra>
                    <a-button type="primary" :loading="loading" @click="onSubmit" block>
                        <template #icon> <SaveOutlined /> </template>
                        {{ $t("common.save") }}
                    </a-button>
                </template> -->
            </a-page-header>
        </template>
        <template #breadcrumb>
            <a-breadcrumb separator="-" style="font-size: 12px">
                <a-breadcrumb-item>
                    <router-link :to="{ name: 'admin.dashboard.index' }">
                        {{ $t(`menu.dashboard`) }}
                    </router-link>
                </a-breadcrumb-item>
                <a-breadcrumb-item>
                    {{
                        orderPageObject.type == "sales" ||
                        orderPageObject.type == "sales-returns" ||
                        orderPageObject.type == "quotations"
                            ? $t(`menu.sales`)
                            : $t(`menu.purchases`)
                    }}
                </a-breadcrumb-item>
                <a-breadcrumb-item>
                    <router-link
                        :to="{
                            name: `admin.stock.${orderPageObject.type}.index`,
                        }"
                    >
                        {{ $t(`menu.${orderPageObject.menuKey}`) }}
                    </router-link>
                </a-breadcrumb-item>
                <a-breadcrumb-item>
                    {{ $t(`common.create`) }}
                </a-breadcrumb-item>
            </a-breadcrumb>
        </template>
    </AdminPageHeader>

    <admin-page-table-content>
        <a-card class="page-content-container mt-20 mb-20">
            <a-form layout="vertical">
                <a-row :gutter="16">
                    <a-col :xs="24" :sm="24" :md="6" :lg="6">
                        <a-form-item
                            :label="$t(`stock.invoice_number`)"
                            name="invoice_number"
                            :help="
                                rules.invoice_number
                                    ? rules.invoice_number.message
                                    : null
                            "
                            :validateStatus="
                                rules.invoice_number ? 'error' : null
                            "
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

                    <a-col
                        v-if="
                            orderPageObject.type == 'stock-transfers' ||
                            orderPageObject.type == 'stock-transfer-returns'
                        "
                        :xs="24"
                        :sm="24"
                        :md="6"
                        :lg="6"
                    >
                        <a-form-item
                            :label="
                                $t('common.to') +
                                ' ' +
                                $t(`${orderPageObject.langKey}.warehouse`)
                            "
                            name="warehouse_id"
                            :help="
                                rules.warehouse_id
                                    ? rules.warehouse_id.message
                                    : null
                            "
                            :validateStatus="
                                rules.warehouse_id ? 'error' : null
                            "
                            class="required"
                        >
                            <span style="display: flex">
                                <a-select
                                    v-model:value="formData.warehouse_id"
                                    :placeholder="
                                        $t('common.select_default_text', [
                                            $t(
                                                `${orderPageObject.langKey}.warehouse`
                                            ),
                                        ])
                                    "
                                    :allowClear="true"
                                    optionFilterProp="title"
                                    show-search
                                >
                                    <a-select-option
                                        v-for="warehouse in toWarehouses"
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

                    <a-col v-else :xs="24" :sm="24" :md="6" :lg="6">
                        <UserSearch
                            :orderPageObject="orderPageObject"
                            :rules="rules"
                            :usersList="[]"
                            :editOrderDisable="false"
                            @onSuccess="
                                (outputUser) => (formData.user_id = outputUser)
                            "
                        />
                    </a-col>

                    <!--* ADDENDUM -->
                    <a-col
                        v-if="
                            orderPageObject.type == 'stock-transfers' ||
                            orderPageObject.type == 'stock-transfer-returns'
                        "
                        :xs="24"
                        :sm="24"
                        :md="6"
                        :lg="6"
                    >
                        <a-form-item
                            :label="
                                $t('common.from') +
                                ' ' +
                                $t(`${orderPageObject.langKey}.warehouse`)
                            "
                            name="warehouse_id"
                            :help="
                                rules.warehouse_id
                                    ? rules.warehouse_id.message
                                    : null
                            "
                            :validateStatus="
                                rules.warehouse_id ? 'error' : null
                            "
                            class="required"
                        >
                            <span style="display: flex">
                                <a-select
                                    v-model:value="formData.from_warehouse_id"
                                    :placeholder="
                                        $t('common.select_default_text', [
                                            $t(
                                                `${orderPageObject.langKey}.warehouse`
                                            ),
                                        ])
                                    "
                                    :allowClear="true"
                                    optionFilterProp="title"
                                    show-search
                                    @select="fromWarehouseChanged"
                                >
                                    <a-select-option
                                        v-for="warehouse in fromWarehouses"
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

                    <a-col v-else :xs="24" :sm="24" :md="6" :lg="6">
                        <WarehouseSearch
                            :labelPrefix="warehouseSearchLabelPrefix"
                            :orderPageObject="allWarehouses"
                            :rules="rules"
                            :warehousesList="[]"
                            :editOrderDisable="false"
                            @onSuccess="
                                (outputWarehouse) =>
                                    orderPageObject.type == 'stock-transfers' ||
                                    orderPageObject.type ==
                                        'stock-transfer-returns'
                                        ? (formData.from_warehouse_id =
                                              outputWarehouse)
                                        : (formData.warehouse_id =
                                              outputWarehouse)
                            "
                        />
                    </a-col>

                    <a-col :xs="24" :sm="24" :md="6" :lg="6">
                        <a-form-item
                            :label="
                                $t(
                                    `${orderPageObject.langKey}.${orderPageObject.langKey}_date`
                                )
                            "
                            name="order_date"
                            :help="
                                rules.order_date
                                    ? rules.order_date.message
                                    : null
                            "
                            :validateStatus="rules.order_date ? 'error' : null"
                            class="required"
                        >
                            <DateTimePicker
                                :dateTime="formData.order_date"
                                @dateTimeChanged="
                                    (changedDateTime) =>
                                        (formData.order_date = changedDateTime)
                                "
                            />
                        </a-form-item>
                    </a-col>

                </a-row>
                <a-row :gutter="16">
                    <a-col :xs="24" :sm="24" :md="24" :lg="24">
                        <a-form-item
                            :label="$t('product.product')"
                            name="orderSearchTerm"
                            :help="
                                rules.product_items
                                    ? rules.product_items.message
                                    : null
                            "
                            :validateStatus="
                                rules.product_items ? 'error' : null
                            "
                        >
                            <span style="display: flex">
                                <a-select
                                    :value="null"
                                    :searchValue="orderSearchTerm"
                                    show-search
                                    :filter-option="false"
                                    :placeholder="
                                        $t('product.search_scan_product')
                                    "
                                    style="width: 100%"
                                    :not-found-content="
                                        productFetching ? undefined : null
                                    "
                                    @search="
                                        (searchedValue) => {
                                            orderSearchTerm = searchedValue;
                                            fetchProducts(searchedValue);
                                        }
                                    "
                                    size="large"
                                    option-label-prop="label"
                                    @focus="products = []"
                                    @select="searchValueSelected"
                                    @inputKeyDown="inputValueChanged"
                                    :disabled="
                                        orderPageObject.type ==
                                            'stock-transfers' ||
                                        orderPageObject.type ==
                                            'stock-transfer-returns'
                                            ? !formData.from_warehouse_id
                                            : !formData.warehouse_id
                                    "
                                >
                                    <template #suffixIcon
                                        ><SearchOutlined
                                    /></template>
                                    <template
                                        v-if="productFetching"
                                        #notFoundContent
                                    >
                                        <a-spin size="small" />
                                    </template>
                                    <a-select-option
                                        v-for="product in products"
                                        :key="product.xid"
                                        :value="product.xid"
                                        :label="product.name"
                                        :product="product"
                                    >
                                        => {{ product.name }} [{{
                                            product.color.name
                                        }}]
                                    </a-select-option>
                                </a-select>
                            </span>
                        </a-form-item>
                    </a-col>
                </a-row>

                <a-row :gutter="16">
                    <a-col :xs="24" :sm="24" :md="24" :lg="24">
                        <a-table
                            :row-key="(record) => record.xid"
                            :dataSource="selectedProducts"
                            :columns="orderItemColumns"
                            :pagination="false"
                        >
                            <template #bodyCell="{ column, record }">
                                <template v-if="column.dataIndex === 'name'">
                                    {{ record.name }} <br />
                                    <small>
                                        <a-typography-text code>
                                            {{ $t("product.avl_qty") }}
                                            {{
                                                `${record.stock_quantity}${record.unit_short_name}`
                                            }}
                                        </a-typography-text>
                                    </small>
                                </template>
                                <template v-if="column.dataIndex === 'brand'">
                                    {{ record.brand ? record.brand.name : "-" }}
                                </template>
                                <template
                                    v-if="column.dataIndex === 'category'"
                                >
                                    {{
                                        record.category
                                            ? record.category.name
                                            : "-"
                                    }}
                                </template>
                                <template v-if="column.dataIndex === 'group'">
                                    {{ record.group ? record.group.name : "-" }}
                                </template>
                                <template v-if="column.dataIndex === 'color'">
                                    {{ record.color ? record.color.name : "-" }}
                                </template>
                                <template v-if="column.dataIndex === 'notes'">
                                    <a-input
                                        id="inputNotes"
                                        v-model:value="record.notes"
                                    />
                                </template>
                                <template
                                    v-if="column.dataIndex === 'unit_quantity'"
                                >
                                    <a-input-number
                                        id="inputNumber"
                                        v-model:value="record.quantity"
                                        @change="quantityChanged(record)"
                                        :min="1"
                                    />
                                </template>
                                <template
                                    v-if="column.dataIndex === 'price_type'"
                                >
                                    <span
                                        v-if="
                                            orderPageObject.type ==
                                                'purchases' ||
                                            orderPageObject.type ==
                                                'purchase-returns'
                                        "
                                    >
                                        <a-input
                                            v-model:value="record.price_type"
                                            hidden
                                        />
                                        {{ $t("product.retail_counter_price") }}
                                    </span>
                                    <a-select
                                        v-else=""
                                        v-model:value="record.price_type"
                                        :placeholder="
                                            $t('invoice.price_type', [''])
                                        "
                                        @change="quantityChanged(record)"
                                    >
                                        <a-select-option
                                            v-for="priceType in priceTypes"
                                            :key="priceType.key"
                                        >
                                            {{ priceType.value }}
                                        </a-select-option>
                                    </a-select>
                                </template>
                                <template
                                    v-if="
                                        column.dataIndex === 'single_unit_price'
                                    "
                                >
                                    <a-input-number
                                        id="inputNumber"
                                        v-model:value="record.single_unit_price"
                                        style="width: 100%"
                                        @change="quantityChanged(record)"
                                        :min="0"
                                        :disabled="
                                            record.price_type !== 'custom_price'
                                        "
                                    />
                                </template>
                                <template
                                    v-if="column.dataIndex === 'discount_rate'"
                                >
                                    <a-input-number
                                        id="inputSubtotal"
                                        v-model:value="record.discount_rate"
                                        style="width: 100%"
                                        @change="quantityChanged(record)"
                                        :min="0"
                                        :disabled="
                                            record.price_type !== 'custom_price'
                                        "
                                    />
                                </template>

                                <!-- <template v-if="column.dataIndex === 'total_discount'">
                                    {{ formatAmountCurrency(record.total_discount) }}
                                </template>
                                <template v-if="column.dataIndex === 'total_tax'">
                                    {{ formatAmountCurrency(record.total_tax) }}
                                </template> -->
                                <template
                                    v-if="column.dataIndex === 'subtotal'"
                                >
                                    <a-input-number
                                        id="inputSubtotal"
                                        v-model:value="record.subtotal"
                                        style="width: 100%"
                                        @change="subtotalChanged(record)"
                                        :min="0"
                                        :disabled="
                                            record.price_type !== 'custom_price'
                                        "
                                    />
                                </template>
                                <template v-if="column.dataIndex === 'action'">
                                    <!-- <a-button
                                        type="primary"
                                        @click="editItem(record)"
                                        style="margin-left: 4px"
                                    >
                                        <template #icon><EditOutlined /></template>
                                    </a-button> -->
                                    <a-button
                                        type="primary"
                                        @click="showDeleteConfirm(record)"
                                        style="margin-left: 4px"
                                    >
                                        <template #icon
                                            ><DeleteOutlined
                                        /></template>
                                    </a-button>
                                </template>
                            </template>
                            <template #summary>
                                <a-table-summary-row style="display: none">
                                    <a-table-summary-cell
                                        :col-span="2"
                                    ></a-table-summary-cell>
                                    <a-table-summary-cell>
                                        {{ $t("stock.grand_total") }}
                                    </a-table-summary-cell>
                                    <!-- <a-table-summary-cell>
                                        {{
                                            formatAmountCurrency(
                                                productsAmount.tax
                                            )
                                        }}
                                    </a-table-summary-cell> -->
                                    <a-table-summary-cell :col-span="2">
                                        {{
                                            formatAmountCurrency(
                                                productsAmount.subtotal
                                            )
                                        }}
                                    </a-table-summary-cell>
                                </a-table-summary-row>
                            </template>
                        </a-table>
                    </a-col>
                </a-row>

                <a-row :gutter="16" class="mt-30">
                    <a-col :xs="24" :sm="24" :md="16" :lg="16">
                        <a-row :gutter="16">
                            <a-col :xs="24" :sm="24" :md="24" :lg="24">
                                <a-form-item
                                    :label="$t('warehouse.terms_condition')"
                                    name="terms_condition"
                                    :help="
                                        rules.terms_condition
                                            ? rules.terms_condition.message
                                            : null
                                    "
                                    :validateStatus="
                                        rules.terms_condition ? 'error' : null
                                    "
                                    hidden
                                >
                                    <a-textarea
                                        v-model:value="formData.terms_condition"
                                        :placeholder="
                                            $t('warehouse.terms_condition')
                                        "
                                        :auto-size="{ minRows: 2, maxRows: 3 }"
                                    />
                                </a-form-item>
                            </a-col>
                        </a-row>
                        <a-row :gutter="16">
                            <a-col :xs="24" :sm="24" :md="24" :lg="24">
                                <a-form-item
                                    :label="$t('stock.notes')"
                                    name="notes"
                                    :help="
                                        rules.notes ? rules.notes.message : null
                                    "
                                    :validateStatus="
                                        rules.notes ? 'error' : null
                                    "
                                >
                                    <a-textarea
                                        v-model:value="formData.notes"
                                        :placeholder="$t('stock.notes')"
                                        :auto-size="{ minRows: 2, maxRows: 3 }"
                                    />
                                </a-form-item>
                            </a-col>
                        </a-row>
                    </a-col>
                    <a-col :xs="24" :sm="24" :md="8" :lg="8">
                        <!--* ADDENDUM -->
                        <!-- <a-row :gutter="16" v-if="orderPageObject.type != 'quotations'">
                            <a-col :xs="24" :sm="24" :md="24" :lg="24">
                                <a-form-item
                                    :label="$t('stock.status')"
                                    name="order_status"
                                    :help="
                                        rules.order_status
                                            ? rules.order_status.message
                                            : null
                                    "
                                    :validateStatus="rules.order_status ? 'error' : null"
                                    class="required"
                                >
                                    <a-select
                                        v-model:value="formData.order_status"
                                        :placeholder="
                                            $t('common.select_default_text', [
                                                $t('stock.status'),
                                            ])
                                        "
                                        :allowClear="true"
                                    >
                                        <a-select-option
                                            v-for="status in allOrderStatus"
                                            :key="status.key"
                                            :value="status.key"
                                        >
                                            {{ status.value }}
                                        </a-select-option>
                                    </a-select>
                                </a-form-item>
                            </a-col>
                        </a-row> -->

                        <a-row :gutter="16">
                            <a-col :xs="24" :sm="24" :md="24" :lg="24">
                                <a-form-item
                                    :label="$t('stock.order_tax')"
                                    name="tax_id"
                                    :help="
                                        rules.tax_id
                                            ? rules.tax_id.message
                                            : null
                                    "
                                    :validateStatus="
                                        rules.tax_id ? 'error' : null
                                    "
                                    hidden
                                >
                                    <span style="display: flex">
                                        <a-select
                                            v-model:value="formData.tax_id"
                                            :placeholder="
                                                $t(
                                                    'common.select_default_text',
                                                    [$t('stock.order_tax')]
                                                )
                                            "
                                            :allowClear="true"
                                            @change="taxChanged"
                                            optionFilterProp="title"
                                            show-search
                                        >
                                            <a-select-option
                                                v-for="tax in taxes"
                                                :key="tax.xid"
                                                :value="tax.xid"
                                                :title="tax.name"
                                                :tax="tax"
                                            >
                                                {{ tax.name }} ({{ tax.rate }}%)
                                            </a-select-option>
                                        </a-select>
                                        <!-- <TaxAddButton @onAddSuccess="taxAdded" /> -->
                                    </span>
                                </a-form-item>
                            </a-col>
                        </a-row>
                        <!-- <a-row :gutter="16">
                            <a-col :xs="24" :sm="24" :md="24" :lg="24">
                                <a-form-item
                                    :label="$t('stock.discount')"
                                    name="discount"
                                    :help="rules.discount ? rules.discount.message : null"
                                    :validateStatus="rules.discount ? 'error' : null"
                                >
                                    <a-input-number
                                        v-model:value="formData.discount"
                                        :placeholder="
                                            $t('common.placeholder_default_text', [
                                                $t('stock.discount'),
                                            ])
                                        "
                                        @change="recalculateFinalTotal"
                                        min="0"
                                        style="width: 100%"
                                    >
                                        <template #addonBefore>
                                            {{ appSetting.currency.symbol }}
                                        </template>
                                    </a-input-number>
                                </a-form-item>
                            </a-col>
                        </a-row> -->
                        <a-row :gutter="16">
                            <a-col :xs="24" :sm="24" :md="24" :lg="24">
                                <a-form-item
                                    :label="$t('stock.shipping')"
                                    name="shipping"
                                    :help="
                                        rules.shipping
                                            ? rules.shipping.message
                                            : null
                                    "
                                    :validateStatus="
                                        rules.shipping ? 'error' : null
                                    "
                                    hidden
                                >
                                    <a-input-number
                                        v-model:value="formData.shipping"
                                        :placeholder="
                                            $t(
                                                'common.placeholder_default_text',
                                                [$t('stock.shipping')]
                                            )
                                        "
                                        @change="recalculateFinalTotal"
                                        min="0"
                                        style="width: 100%"
                                    >
                                        <template #addonBefore>
                                            {{ appSetting.currency.symbol }}
                                        </template>
                                    </a-input-number>
                                </a-form-item>
                            </a-col>
                        </a-row>
                        <!-- <a-row :gutter="16" class="mt-10">
                            <a-col :xs="12" :sm="12" :md="12" :lg="12">
                                {{ $t("stock.order_tax") }}
                            </a-col>
                            <a-col :xs="12" :sm="12" :md="12" :lg="12">
                                {{ formatAmountCurrency(formData.tax_amount) }}
                            </a-col>
                        </a-row> -->
                        <!-- <a-row :gutter="16" class="mt-10">
                            <a-col :xs="12" :sm="12" :md="12" :lg="12">
                                {{ $t("stock.discount") }}
                            </a-col>
                            <a-col :xs="12" :sm="12" :md="12" :lg="12">
                                {{ formatAmountCurrency(formData.discount) }}
                            </a-col>
                        </a-row> -->
                        <!-- <a-row :gutter="16" class="mt-10">
                            <a-col :xs="12" :sm="12" :md="12" :lg="12">
                                {{ $t("stock.shipping") }}
                            </a-col>
                            <a-col :xs="12" :sm="12" :md="12" :lg="12">
                                {{ formatAmountCurrency(formData.shipping) }}
                            </a-col>
                        </a-row> -->
                        <!-- <a-row :gutter="16" class="mt-10">
                            <a-col :xs="12" :sm="12" :md="12" :lg="12">
                                {{ $t("stock.grand_total") }}
                            </a-col>
                            <a-col :xs="12" :sm="12" :md="12" :lg="12">
                                {{ formatAmountCurrency(formData.subtotal) }}
                            </a-col>
                        </a-row> -->
                        <a-row :gutter="16" class="mt-20 mb-20">
                            <a-progress
                                :percent="ordersProgress.percent"
                                :status="ordersProgress.status"
                            />
                            <a-typography-text type="danger">
                                {{ ordersProgress.message }}
                            </a-typography-text>
                            <a-button
                                type="primary"
                                :loading="ordersProgress.loading"
                                @click="onSubmit"
                                block
                            >
                                <template #icon> <SaveOutlined /> </template>
                                {{ $t("common.save") }}
                            </a-button>
                        </a-row>
                    </a-col>
                </a-row>
            </a-form>
        </a-card>
    </admin-page-table-content>

    <a-modal
        :open="addEditVisible"
        :closable="false"
        :centered="true"
        :title="addEditPageTitle"
        @ok="onAddEditSubmit"
    >
        <a-form layout="vertical">
            <a-row :gutter="16">
                <a-col :xs="24" :sm="24" :md="24" :lg="24">
                    <a-form-item
                        :label="$t('product.unit_price')"
                        name="unit_price"
                        :help="
                            addEditRules.unit_price
                                ? addEditRules.unit_price.message
                                : null
                        "
                        :validateStatus="
                            addEditRules.unit_price ? 'error' : null
                        "
                    >
                        <a-input-number
                            v-model:value="addEditFormData.unit_price"
                            :placeholder="
                                $t('common.placeholder_default_text', [
                                    $t('product.unit_price'),
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
            </a-row>
            <a-row :gutter="16">
                <a-col :xs="24" :sm="24" :md="24" :lg="24">
                    <a-form-item
                        :label="$t('product.discount')"
                        name="discount_rate"
                        :help="
                            addEditRules.discount_rate
                                ? addEditRules.discount_rate.message
                                : null
                        "
                        :validateStatus="
                            addEditRules.discount_rate ? 'error' : null
                        "
                    >
                        <a-input-number
                            v-model:value="addEditFormData.discount_rate"
                            :placeholder="
                                $t('common.placeholder_default_text', [
                                    $t('product.discount'),
                                ])
                            "
                            min="0"
                            style="width: 100%"
                        >
                            <template #addonAfter>%</template>
                        </a-input-number>
                    </a-form-item>
                </a-col>
            </a-row>
            <a-row :gutter="16">
                <a-col :xs="24" :sm="24" :md="24" :lg="24">
                    <a-form-item
                        :label="$t('product.tax')"
                        name="tax_id"
                        :help="
                            addEditRules.tax_id
                                ? addEditRules.tax_id.message
                                : null
                        "
                        :validateStatus="addEditRules.tax_id ? 'error' : null"
                    >
                        <span style="display: flex">
                            <a-select
                                v-model:value="addEditFormData.tax_id"
                                :placeholder="
                                    $t('common.select_default_text', [
                                        $t('product.tax'),
                                    ])
                                "
                                :allowClear="true"
                                optionFilterProp="title"
                                show-search
                            >
                                <a-select-option
                                    v-for="tax in taxes"
                                    :key="tax.xid"
                                    :value="tax.xid"
                                    :title="tax.name"
                                >
                                    {{ tax.name }} ({{ tax.rate }}%)
                                </a-select-option>
                            </a-select>
                            <!-- <TaxAddButton @onAddSuccess="taxAdded" /> -->
                        </span>
                    </a-form-item>
                </a-col>
            </a-row>
            <a-row :gutter="16">
                <a-col :xs="24" :sm="24" :md="24" :lg="24">
                    <a-form-item
                        :label="$t('product.tax_type')"
                        name="tax_type"
                        :help="
                            addEditRules.tax_type
                                ? addEditRules.tax_type.message
                                : null
                        "
                        :validateStatus="addEditRules.tax_type ? 'error' : null"
                    >
                        <a-select
                            v-model:value="addEditFormData.tax_type"
                            :placeholder="
                                $t('common.select_default_text', [
                                    $t('product.tax_type'),
                                ])
                            "
                            :allowClear="true"
                        >
                            <a-select-option
                                v-for="taxType in taxTypes"
                                :key="taxType.key"
                                :value="taxType.key"
                            >
                                {{ taxType.value }}
                            </a-select-option>
                        </a-select>
                    </a-form-item>
                </a-col>
            </a-row>
        </a-form>
        <template #footer>
            <a-button
                key="submit"
                type="primary"
                :loading="addEditFormSubmitting"
                @click="onAddEditSubmit"
            >
                <template #icon>
                    <SaveOutlined />
                </template>
                {{ $t("common.update") }}
            </a-button>
            <a-button key="back" @click="onAddEditClose">
                {{ $t("common.cancel") }}
            </a-button>
        </template>
    </a-modal>
</template>

<script>
import { onMounted, ref, toRefs, computed } from "vue";
import {
    EyeOutlined,
    PlusOutlined,
    EditOutlined,
    DeleteOutlined,
    ExclamationCircleOutlined,
    SearchOutlined,
    SaveOutlined,
    LoadingOutlined,
} from "@ant-design/icons-vue";
import { notification } from "ant-design-vue";
import { useI18n } from "vue-i18n";
import { useRouter } from "vue-router";
import { useStore } from "vuex";
import apiAdmin from "../../../../common/composable/apiAdmin";
import stockManagement from "./stockManagement";
import common from "../../../../common/composable/common";
import fields from "./fields";
import TaxAddButton from "../../settings/taxes/AddButton.vue";
import WarehouseAddButton from "../../settings/warehouses/AddButton.vue";
import ProductAddButton from "../../product-manager/products/AddButton.vue";
import DateTimePicker from "../../../../common/components/common/calendar/DateTimePicker.vue";
import AdminPageHeader from "../../../../common/layouts/AdminPageHeader.vue";
import UserSearch from "./UserSearch.vue";

//* ADDENDUM
import WarehouseSearch from "./WarehouseSearch.vue";

export default {
    components: {
        EyeOutlined,
        PlusOutlined,
        EditOutlined,
        DeleteOutlined,
        ExclamationCircleOutlined,
        SearchOutlined,
        SaveOutlined,
        LoadingOutlined,

        TaxAddButton,
        WarehouseAddButton,
        ProductAddButton,
        DateTimePicker,
        AdminPageHeader,
        UserSearch,

        //* ADDENDUM
        WarehouseSearch,
    },
    setup() {
        const { addEditRequestAdmin, loading, rules } = apiAdmin();
        const {
            appSetting,
            formatAmount,
            formatAmountCurrency,
            taxTypes,
            orderStatus,
            purchaseOrderStatus,
            salesOrderStatus,
            salesReturnStatus,
            purchaseReturnStatus,
            permsArray,
            selectedWarehouse,

            //* ADDENDUM
            allWarehouses,
            priceTypes,
            salesLabels,
        } = common();
        const { orderItemColumns } = fields();
        const {
            state,
            orderType,
            orderPageObject,
            selectedProducts,
            formData,
            productsAmount,
            taxes,

            recalculateValues,
            fetchProducts,
            searchValueSelected,
            quantityChanged,
            recalculateFinalTotal,
            showDeleteConfirm,
            taxChanged,
            editItem,

            // Add Edit
            addEditVisible,
            addEditFormData,
            addEditFormSubmitting,
            addEditRules,
            addEditPageTitle,
            onAddEditSubmit,
            onAddEditClose,

            inputValueChanged,

            //* ADDENDUM
            subtotalChanged,
        } = stockManagement();
        const { t } = useI18n();
        const store = useStore();
        const ordersProgress = computed(() => store.state.auth.ordersProgress);
        const toWarehouses = ref([]);
        const fromWarehouses = ref([]);
        const allUnits = ref([]);
        const router = useRouter();
        const allOrderStatus = ref([]);
        const taxUrl = "taxes?limit=10000";
        const unitUrl = "units?limit=10000";
        const warehouseUrl = `warehouses?filters=id ne "${selectedWarehouse.value.xid}"&hashable=${selectedWarehouse.value.xid}&limit=10000`;

        //* ADDENDUM
        const warehouseSearchLabelPrefix = ref([]);

        onMounted(() => {
            store.commit("auth/updateOrdersProgress", {
                percent: 0,
                status: "active",
                message: "",
                loading: false,
            });

            const taxesPromise = axiosAdmin.get(taxUrl);
            const unitsPromise = axiosAdmin.get(unitUrl);
            const warehousesPromise = axiosAdmin.get(warehouseUrl);

            Promise.all([taxesPromise, unitsPromise, warehousesPromise]).then(
                ([taxResponse, unitResponse, warehousesResponse]) => {
                    taxes.value = taxResponse.data;
                    allUnits.value = unitResponse.data;

                    if (orderType.value == "stock-transfers") {
                        toWarehouses.value = warehousesResponse.data;
                        fromWarehouses.value = warehousesResponse.data;
                    } else if (orderType.value == "stock-transfer-returns") {
                        toWarehouses.value = [allWarehouses.value[0]];
                        fromWarehouses.value = warehousesResponse.data;
                    }
                }
            );

            if (orderType.value == "purchases") {
                allOrderStatus.value = purchaseOrderStatus;
                formData.value.order_status = "received";
                formData.value.label = "purchases";
                warehouseSearchLabelPrefix.value = "to";
            } else if (orderType.value == "sales") {
                allOrderStatus.value = salesOrderStatus;
                formData.value.order_status = "delivered";
                warehouseSearchLabelPrefix.value = "from";
            } else if (orderType.value == "sales-returns") {
                allOrderStatus.value = salesReturnStatus;
                formData.value.order_status = "received";
                warehouseSearchLabelPrefix.value = "to";
            } else if (orderType.value == "purchase-returns") {
                allOrderStatus.value = purchaseReturnStatus;
                formData.value.order_status = "completed";
                formData.value.label = "purchases";
                warehouseSearchLabelPrefix.value = "from";
            } else if (orderType.value == "quotations") {
                allOrderStatus.value = [];
                warehouseSearchLabelPrefix.value = "to";
            } else if (orderType.value == "stock-transfers") {
                allOrderStatus.value = salesOrderStatus;
                formData.value.order_status = "delivered";
                formData.value.label = "stock-transfers";
            } else if (orderType.value == "stock-transfer-returns") {
                allOrderStatus.value = salesReturnStatus;
                formData.value.order_status = "received";
                formData.value.label = "stock-transfers";
            }
        });

        const onSubmit = () => {
            store.commit("auth/updateOrdersProgress", {
                percent: 0,
                status: "active",
                message: "",
                loading: true,
            });

            const newFormDataObject = {
                ...formData.value,
                order_type: orderPageObject.value.type,
                total: formData.value.subtotal,
                total_items: selectedProducts.value.length,
                product_items: selectedProducts.value,
                discount: 0,
            };

            addEditRequestAdmin({
                url: orderType.value,
                data: newFormDataObject,
                // successMessage: t(`${orderPageObject.value.langKey}.created`),
                success: (res) => {
                    updateOrdersProgress(res);
                },
                error: (_) => {
                    store.commit("auth/updateOrdersProgress", {
                        percent: 0,
                        status: "active",
                        message: "",
                        loading: false,
                    });
                },
            });
        };

        const updateOrdersProgress = (res) => {
            setTimeout(() => {
                store.commit("auth/updateOrdersProgress", {
                    percent: res.progress.percent,
                    status: "active",
                    message: "",
                    loading: true,
                });

                if (res.finished) {
                    notification.success({
                        placement: appSetting.value.rtl
                            ? "bottomLeft"
                            : "bottomRight",
                        message: t("common.success"),
                        description: t(
                            `${orderPageObject.value.langKey}.created`
                        ),
                    });

                    store.commit("auth/updateOrdersProgress", {
                        percent: 100,
                        status: "success",
                        message: "",
                        loading: false,
                    });

                    setTimeout(() => {
                        router.push({
                            name: `admin.stock.${orderType.value}.index`,
                        });
                    }, 500);
                } else {
                    axiosAdmin
                        .post("queue/import-progress", {
                            id: res.id,
                            finished: res.finished,
                            cache_key: res.cache_key,
                            progress: res.progress,
                        })
                        .then((progressRes) => {
                            updateOrdersProgress(progressRes.data);
                        })
                        .catch((err) => {
                            store.commit("auth/updateOrdersProgress", {
                                percent: res.progress.percent,
                                status: "exception",
                                message: err.data.error.message,
                                loading: false,
                            });
                        });
                }
            }, 2000);
        };

        const fromWarehouseChanged = (selectedWarehouseId) => {
            axiosAdmin.post("change-warehouse", {
                warehouse_id: selectedWarehouseId,
            });
        };

        return {
            ...toRefs(state),
            formData,
            productsAmount,
            rules,
            loading,
            taxes,
            onSubmit,
            fetchProducts,
            searchValueSelected,
            selectedProducts,
            showDeleteConfirm,
            quantityChanged,
            formatAmountCurrency,
            taxChanged,
            recalculateFinalTotal,
            appSetting,
            editItem,
            orderPageObject,

            orderItemColumns,

            // Add Edit
            addEditVisible,
            addEditFormData,
            addEditFormSubmitting,
            addEditRules,
            addEditPageTitle,
            onAddEditSubmit,
            onAddEditClose,
            allOrderStatus,
            taxTypes,
            permsArray,

            inputValueChanged,

            //* ADDENDUM
            allWarehouses,
            toWarehouses,
            fromWarehouses,
            fromWarehouseChanged,
            warehouseSearchLabelPrefix,
            priceTypes,
            salesLabels,
            subtotalChanged,

            ordersProgress,
        };
    },
};
</script>
