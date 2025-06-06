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
                        :label="$t('barcode.string')"
                        name="name"
                        :help="rules.name ? rules.name.message : null"
                        :validateStatus="rules.name ? 'error' : null"
                        class="required"
                    >
                        <a-input
                            v-model:value="formData.string"
                            :placeholder="
                                $t('common.placeholder_default_text', [$t('barcode.string')])
                            "
                        />
                    </a-form-item>
                </a-col>
            </a-row>

            <a-row :gutter="16">
                <a-col :xs="24" :sm="24" :md="24" :lg="24">
                    <a-form-item
                        :label="$t('barcode.reason')"
                        name="reason"
                        :help="rules.reason ? rules.reason.message : null"
                        :validateStatus="rules.reason ? 'error' : null"
                    >
                        <a-input
                            v-model:value="formData.reason"
                            :placeholder="
                                $t('common.placeholder_default_text', [$t('barcode.reason')])
                            "
                        />
                    </a-form-item>
                </a-col>
            </a-row>

            <a-row :gutter="16">
                <a-col :xs="24" :sm="24" :md="24" :lg="24">
                    <a-form-item
                        :label="$t('barcode.comment')"
                        name="name"
                        :help="rules.comment ? rules.comment.message : null"
                        :validateStatus="rules.comment ? 'error' : null"
                    >
                        <a-input
                            v-model:value="formData.comment"
                            :placeholder="
                                $t('common.placeholder_default_text', [$t('barcode.comment')])
                            "
                        />
                    </a-form-item>
                </a-col>
            </a-row>

            <a-row :gutter="16">
                <a-col :xs="24" :sm="24" :md="24" :lg="24">
                    <a-form-item
                        :label="$t('barcode.invoice_number')"
                        name="invoice_number"
                        @input="logFormData"
                        :help="rules.comment ? rules.comment.message : null"
                        :validateStatus="rules.comment ? 'error' : null"
                    >
                        <a-input
                            v-model:value="formData.order_item.order.invoice_number"
                            :placeholder="
                                $t('common.placeholder_default_text', [$t('barcode.invoice_number')])
                            "
                        />
                    </a-form-item>
                </a-col>
            </a-row>
            <a-row :gutter="16">
                <a-col :xs="24" :sm="24" :md="24" :lg="24">
                    <a-form-item
                        :label="$t('product.item_id')"
                        name="item_id"
                        :help="rules.comment ? rules.comment.message : null"
                        :validateStatus="rules.comment ? 'error' : null"
                    >
                        <a-input
                            v-model:value="formData.item_id" @blur="onItemIdBlur"
                            :placeholder="
                                $t('common.placeholder_default_text', [$t('product.item_id')])
                            "
                        />
                    </a-form-item>
                </a-col>
            </a-row>
            <a-row :gutter="16">
                <a-col :xs="24" :sm="24" :md="24" :lg="24">
                    <a-form-item
                        :label="$t('barcode.qty_bungkus')"
                        name="qty_bungkus"
                        :help="rules.comment ? rules.comment.message : null"
                        :validateStatus="rules.comment ? 'error' : null"
                    >
                        <a-input
                            v-model:value="formData.qty_bungkus"
                            :placeholder="
                                $t('common.placeholder_default_text', [$t('barcode.qty_bungkus')])
                            "
                        />
                    </a-form-item>
                </a-col>
            </a-row>
            <a-row :gutter="16">
                <a-col :xs="24" :sm="24" :md="24" :lg="24">
                    <a-form-item
                        :label="$t('barcode.nik')"
                        name="nik"
                        :help="rules.comment ? rules.comment.message : null"
                        :validateStatus="rules.comment ? 'error' : null"
                    >
                        <a-input
                            v-model:value="formData.nik"
                            :placeholder="
                                $t('common.placeholder_default_text', [$t('barcode.nik')])
                            "
                        />
                    </a-form-item>
                </a-col>
            </a-row>

            <a-row :gutter="16">
                <a-col :xs="24" :sm="24" :md="24" :lg="24">
                    <a-form-item
                        :label="$t('delivery_order.invoice_number')"
                        name="delivery_invoice_number"
                        @input="logFormData"
                        :help="rules.comment ? rules.comment.message : null"
                        :validateStatus="rules.comment ? 'error' : null"
                    >
                        <a-input
                            v-model:value="formData.order_item_out.order.invoice_number"
                            :placeholder="
                                $t('common.placeholder_default_text', [$t('delivery_order.invoice_number')])
                            "
                        />
                    </a-form-item>
                </a-col>
            </a-row>

            <a-row :gutter="16">
                <a-col :xs="24" :sm="24" :md="12" :lg="12">
                    <a-form-item
                        :label="$t('barcode.status')"
                        name="isactive"
                        :help="
                            rules.isactive
                                ? rules.isactive.message
                                : null
                        "
                        :validateStatus="rules.isactive ? 'error' : null"
                        class="required"
                    >
                        <a-select
                            v-model:value="formData.isactive"
                            :placeholder="
                                $t('common.select_default_text', [
                                    $t('barcode.isactive'),
                                ])
                            "
                        >
                            <a-select-option
                                :key="0"
                                :value="0"
                            >
                                {{ $t('barcode.inactive') }}
                            </a-select-option>
                            <a-select-option
                                :key="1"
                                :value="1"
                            >
                                {{ $t('barcode.active') }}
                            </a-select-option>
                            <a-select-option
                                :key="-1"
                                :value="-1"
                            >
                                {{ $t('common.not_in_use') }}
                            </a-select-option>
                        </a-select>
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
import { reactive,toRefs, defineComponent,watch } from "vue";
import { PlusOutlined, LoadingOutlined, SaveOutlined } from "@ant-design/icons-vue";
import apiAdmin from "../../../../common/composable/apiAdmin";
import Upload from "../../../../common/core/ui/file/Upload.vue";
import common from "../../../../common/composable/common";
import axios from 'axios';

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
    },
    setup(props, { emit }) {
        const formData = reactive({
            ...props.formData,
            order_item: {
              order: {
                invoice_number: props.formData?.order_item?.order?.invoice_number ?? ''
              },
              ...props.formData?.order_item // merge any existing order_item fields
            },
            order_item_out: {
              order: {
                invoice_number: props.formData?.order_item_out?.order?.invoice_number ?? ''
              },
              ...props.formData?.order_item_out // merge any existing order_item fields
            }
          });
          console.log('data: ',formData);
        const { addEditRequestAdmin, loading, rules } = apiAdmin();
        const { slugify } = common();
        
        const onSubmit = () => {
    // clone the formData first
    const payload = { ...formData };
    payload.invoice_number = formData.order_item?.order?.invoice_number ?? '';
    payload.delivery_invoice_number = formData.order_item_out?.order?.invoice_number ?? ''; // Add this line
    delete payload.order_item;
    delete payload.order_item_out; // Remove nested order_item_out
    addEditRequestAdmin({
        url: props.url,
        data: payload,
        successMessage: props.successMessage,
        success: (res) => {
            console.log('props.formData:', props.formData);
            emit("addEditSuccess", res.xid);
        },
    });

console.log('dataaaa: ',formData);
};
        
        const onClose = () => {
            rules.value = {};
            emit("closed");
        };
        
        watch(
  () => props.formData,
  (newVal) => {
    Object.assign(formData, {
      ...newVal,
      order_item: {
        order: {
          invoice_number: newVal?.order_item?.order?.invoice_number ?? '',
        },
        ...newVal?.order_item,
      },
      order_item_out: {
        order: {
          invoice_number: newVal?.order_item_out?.order?.invoice_number ?? '',
        },
        ...newVal?.order_item_out,
      },
    });
  },
  { immediate: true, deep: true }
);

const onItemIdBlur = async () => {
    const newVal = formData.item_id;
    if (newVal) {
        try {
            console.log('Searching product on blur...');
            const response = await axios.post('/api/v1/search-product', {
                order_type: "purchases",
                search_term: newVal
            });
            const total_product = response.data.data.length;
            console.log(total_product);
            if(total_product == 0){
               formData.item_id = '';
               formData.qty_bungkus = '';
               alert('Item Id tidak ditemukan');
            }
            const qtyBungkus = response.data.data[0]?.qty_bungkus;

            if (qtyBungkus !== undefined) {
                formData.qty_bungkus = qtyBungkus;
                console.log('Updated qty_bungkus:', qtyBungkus);
            }
        } catch (error) {
            console.error('Failed to fetch qty_bungkus:', error);
        }
    }
};

        return {
            formData,
            loading,
            rules,
            onClose,
            onSubmit,
            slugify,
            onItemIdBlur,
            drawerWidth: window.innerWidth <= 991 ? "90%" : "45%",
        };
    },
});
</script>
