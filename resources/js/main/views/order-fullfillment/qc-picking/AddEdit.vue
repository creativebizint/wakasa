<template>
    <div v-if="error" class="error-message">
        An error occurred while loading the component. Please try again or contact support.
        <pre>{{ error.message }}</pre>
    </div>
    <a-drawer
        v-else
        :title="pageTitle || $t('common.loading')"
        :width="drawerWidth"
        :open="visible"
        :body-style="{ paddingBottom: '80px' }"
        :footer-style="{ textAlign: 'right' }"
        :maskClosable="false"
        @close="onClose"
    >
        <a-form layout="vertical">
            <a-tabs v-model:activeKey="activeKey">
                <a-tab-pane key="basic_details">
                    <template #tab>
                        <span>
                            <FileTextOutlined />
                            {{ $t("stock_in.details") }}
                        </span>
                    </template>

                    <a-row :gutter="16">
                        <a-col :xs="24" :sm="24" :md="24" :lg="24">
                            <h2>{{ formData.invoice_number || 'N/A' }}</h2>
                        </a-col>
                    </a-row>

                    <a-row :gutter="16">
                        <a-col :xs="24" :sm="24" :md="24" :lg="24">
                            {{ $t("picking_assignment.name") }}: {{ formData.user_name || 'N/A' }}
                        </a-col>
                    </a-row>

                    <a-row :gutter="16">
                        <a-col :xs="24" :sm="24" :md="24" :lg="24">
                            {{ $t("picking_assignment.date") }}: {{ formatDateTime(formData.date) || 'N/A' }}
                        </a-col>
                    </a-row>

                    <a-row :gutter="16">
                        <a-col :xs="24" :sm="24" :md="24" :lg="24" style="display: inline-flex;">
                            {{ $t("picking_assignment.status") }}:
                            <div v-if="formData.status == 'open'">
                                <a-tag color="yellow">
                                    {{ $t(`common.${"open"}`) }}
                                </a-tag>
                            </div>
                            <div v-if="formData.order_status == 'picking'">
                                <a-tag color="green">
                                    {{ $t(`common.${"picking"}`) }}
                                </a-tag>
                            </div>
                        </a-col>
                    </a-row>

                    <table class="table" border="1" width="90%">
                        <thead>
                            <tr>
                                <td align="center"><b>#</b></td>
                                <td align="center">
                                    <a-checkbox
                                        :checked="isAllSelected"
                                        :indeterminate="isIndeterminate"
                                        @change="onSelectAll"
                                    />
                                </td>
                                <td align="center"><b>{{ $t("product.item_id") }}</b></td>
                                <td align="center"><b>{{ $t("product.quantity") }}</b></td>
                                <td align="center"><b>{{ $t("product.qty_scanned") }}</b></td>
                                <td align="center"><b>{{ $t("common.picking") }}</b></td>
                                <td align="center"><b>{{ $t("common.status") }}</b></td>
                            </tr>
                        </thead>
                        <tbody>
                            <tr v-for="(item, index) in items" :key="item.xid">
                                <td align="center">
                                    {{ index + 1 }}
                                </td>
                                <td align="center">
                                    <a-checkbox
                                        :checked="isItemSelected(item.xid)"
                                        :disabled="item.qc_status === 'qc'"
                                        @change="(e) => onCheck(e, item)"
                                    />
                                </td>
                                <td align="center">{{ item.item_id || 'N/A' }}</td>
                                <td align="center">{{ item.quantity || 'N/A' }}</td>
                                <td align="center">{{ item.quantity_scanned }}</td>
                                <td align="center">{{ item.picker_by_name }}</td>
                                <td align="center">
                                    <a-tag v-if="item.qc_status === 'qc'" color="green">
                                        {{ $t("common.qc_complete") }}
                                    </a-tag>
                                    <a-tag v-else color="orange">
                                        {{ $t("common.picking") }}
                                    </a-tag>
                                </td>
                            </tr>
                        </tbody>
                    </table>
                </a-tab-pane>
            </a-tabs>
        </a-form>
        <template #footer>
            <a-button
                @click="createDeliveryOrder"
                type="primary"
                :disabled="!hasSelectedItems"
                class="mt-3"
            >
                {{ $t('common.complete_qc') }}
            </a-button> &nbsp;
            <a-typography-link @click="exportExcel" target="_blank">
                <a-button type="primary">
                    <FileExcelOutlined />
                    {{ $t("common.export") }}
                </a-button>
            </a-typography-link> &nbsp;
            <a-button @click="onClose">
                {{ $t("common.close") }}
            </a-button>
        </template>
    </a-drawer>
</template>

<script>
import { defineComponent, ref, computed } from "vue";
import {
    PlusOutlined,
    LoadingOutlined,
    SaveOutlined,
    FileTextOutlined,
    EyeOutlined,
    SettingOutlined,
} from "@ant-design/icons-vue";
import { message } from "ant-design-vue";
import apiAdmin from "../../../../common/composable/apiAdmin";
import Upload from "../../../../common/core/ui/file/Upload.vue";
import common from "../../../../common/composable/common";
import { useStore } from "vuex";

export default defineComponent({
    props: {
        formData: {
            type: Object,
            required: true,
            default: () => ({ items: [], code: '', name: '', created_at: '', status: '' }),
            validator: (formData) => {
                try {
                    return typeof formData === 'object' && Array.isArray(formData.items);
                } catch (e) {
                    console.error('formData validation error:', e);
                    return false;
                }
            }
        },
        data: {
            type: Object,
            default: () => ({}),
            validator: (data) => typeof data === 'object'
        },
        visible: {
            type: Boolean,
            required: true,
            validator: (visible) => typeof visible === 'boolean'
        },
        url: {
            type: String,
            required: true,
            validator: (url) => {
                try {
                    return typeof url === 'string' && url.trim().length > 0;
                } catch (e) {
                    console.error('url validation error:', e);
                    return false;
                }
            }
        },
        addEditType: {
            type: String,
            default: '',
            validator: (type) => ['add', 'edit', ''].includes(type)
        },
        pageTitle: {
            type: String,
            default: '',
            validator: (title) => typeof title === 'string'
        },
        successMessage: {
            type: String,
            default: '',
            validator: (message) => typeof message === 'string'
        }
    },
    emits: ["addEditSuccess", "closed"],
    components: {
        PlusOutlined,
        LoadingOutlined,
        SaveOutlined,
        FileTextOutlined,
        EyeOutlined,
        SettingOutlined,
        Upload
    },
    setup(props, { emit }) {
        const store = useStore();
        const error = ref(null);
        let apiAdminInstance, commonInstance;

        // Initialize composables with error handling
        try {
            apiAdminInstance = apiAdmin();
            commonInstance = common();
        } catch (e) {
            console.error('Error initializing composables:', e);
            error.value = e;
        }

        const { addEditRequestAdmin, loading, rules } = apiAdminInstance || {};
        const { slugify, salesOrderStatus, selectedWarehouse, formatDateTime } = commonInstance || {};

        const activeKey = ref("basic_details");
        const selectedItems = ref([]);

        // Computed property to ensure items is always an array
        const items = computed(() => {
            try {
                return Array.isArray(props.formData.items) ? props.formData.items : [];
            } catch (e) {
                console.error('Error in items computed:', e);
                error.value = e;
                return [];
            }
        });

        // Get items that can be selected (not already QC'd)
        const selectableItems = computed(() => {
            return items.value.filter(item => item.qc_status !== 'qc');
        });

        // Check if an item is selected
        const isItemSelected = (xid) => {
            try {
                return selectedItems.value.includes(xid);
            } catch (e) {
                console.error('Error in isItemSelected:', e);
                error.value = e;
                return false;
            }
        };

        // Check if all selectable items are selected
        const isAllSelected = computed(() => {
            if (selectableItems.value.length === 0) return false;
            return selectableItems.value.every(item => selectedItems.value.includes(item.xid));
        });

        // Check if some (but not all) items are selected (indeterminate state)
        const isIndeterminate = computed(() => {
            const selectedCount = selectableItems.value.filter(item => 
                selectedItems.value.includes(item.xid)
            ).length;
            return selectedCount > 0 && selectedCount < selectableItems.value.length;
        });

        // Check if there are any selected items (for button enable/disable)
        const hasSelectedItems = computed(() => {
            return selectedItems.value.length > 0;
        });

        // Handle select all checkbox
        const onSelectAll = (event) => {
            try {
                const isChecked = event.target.checked;
                if (isChecked) {
                    // Select all selectable items
                    selectedItems.value = selectableItems.value.map(item => item.xid);
                } else {
                    // Deselect all
                    selectedItems.value = [];
                }
            } catch (e) {
                console.error('Error in onSelectAll:', e);
                error.value = e;
            }
        };

        // Handle individual checkbox change
        const onCheck = (event, item) => {
            try {
                // Don't allow checking items that are already QC'd
                if (item.qc_status === 'qc') {
                    return;
                }

                const isChecked = event.target.checked;
                if (isChecked) {
                    if (!selectedItems.value.includes(item.xid)) {
                        selectedItems.value = [...selectedItems.value, item.xid];
                    }
                } else {
                    selectedItems.value = selectedItems.value.filter(xid => xid !== item.xid);
                }
            } catch (e) {
                console.error('Error in onCheck:', e);
                error.value = e;
            }
        };

        // Handle Create Delivery Order button click
        const createDeliveryOrder = () => {
            try {
                // Get selected items that are not already QC'd
                const itemsToQc = selectedItems.value.filter(xid => {
                    const item = items.value.find(i => i.xid === xid);
                    return item && item.qc_status !== 'qc';
                });

                if (itemsToQc.length === 0) {
                    // If no items selected, show message
                    message.warning('Please select at least one item to complete QC');
                    return;
                }

                // Add API call to create delivery order with selected items
                addEditRequestAdmin({
                    url: '/delivery-order',
                    data: { 
                        invoice_number: props.formData.invoice_number,
                        item_ids: itemsToQc
                    },
                    success: (res) => {
                        // Reset selected items after success
                        selectedItems.value = [];
                        emit('addEditSuccess', res);
                    }
                });
            } catch (e) {
                console.error('Error in createDeliveryOrder:', e);
                error.value = e;
            }
        };

        const exportExcel = () => {
            try {
                const code = props.formData.invoice_number || '';
                const url = `/admin/order-fullfillment/qc-picking/export?code=${code}&type=pdf`;
                window.location = url;
            } catch (e) {
                console.error('Error in exportExcel:', e);
                error.value = e;
            }
        };

        const onSubmit = () => {
            try {
                if (!props.url) {
                    throw new Error('URL prop is empty');
                }
                addEditRequestAdmin({
                    url: props.url,
                    data: props.formData,
                    successMessage: props.successMessage,
                    success: (res) => {
                        store.dispatch("auth/updateAllWarehouses");

                        if (
                            selectedWarehouse &&
                            selectedWarehouse.value &&
                            selectedWarehouse.value.xid &&
                            selectedWarehouse.value.xid === res.xid
                        ) {
                            axiosAdmin
                                .post("change-warehouse", {
                                    warehouse_id: res.xid
                                })
                                .then((response) => {
                                    store.commit(
                                        "auth/updateWarehouse",
                                        response.data.warehouse
                                    );
                                });
                        }

                        emit("addEditSuccess", res.xid);
                        activeKey.value = "basic_details";
                        rules.value = {};
                    }
                });
            } catch (e) {
                console.error('Error in onSubmit:', e);
                error.value = e;
            }
        };

        const onClose = () => {
            try {
                activeKey.value = "basic_details";
                rules.value = {};
                selectedItems.value = [];
                emit("closed");
            } catch (e) {
                console.error('Error in onClose:', e);
                error.value = e;
            }
        };

        // Log props for debugging
        console.log('AddEdit props:', {
            formData: props.formData,
            visible: props.visible,
            url: props.url,
            addEditType: props.addEditType,
            pageTitle: props.pageTitle,
            successMessage: props.successMessage
        });

        return {
            loading,
            rules,
            onClose,
            onSubmit,
            slugify,
            activeKey,
            salesOrderStatus,
            formatDateTime,
            drawerWidth: window.innerWidth <= 991 ? "90%" : "45%",
            selectedItems,
            items,
            isItemSelected,
            onCheck,
            onSelectAll,
            isAllSelected,
            isIndeterminate,
            hasSelectedItems,
            createDeliveryOrder,
            exportExcel,
            error
        };
    }
});
</script>

<style scoped>
.table tr td {
    border: 1px solid;
}

.error-message {
    color: red;
    padding: 16px;
    border: 1px solid red;
    border-radius: 4px;
    margin: 16px;
}

.mt-3 {
    margin-top: 12px;
}
</style>