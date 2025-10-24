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
                        :label="$t('common.weight') + ' (Kg)'"
                        name="weight"
                        :help="rules.weight ? rules.weight.message : null"
                        :validateStatus="rules.weight ? 'error' : null"
                        class="required"
                    >
                        <a-input
                            v-model:value="formData.weight"
                            :placeholder="
                                $t('common.placeholder_default_text', [
                                    $t('common.weight'),
                                ])
                            "
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
                {{$t("common.update") }}
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
import common from "../../../../common/composable/common";
import PaymentModeAddButton from "../../settings/payment-modes/AddButton.vue";

export default defineComponent({
    props: [
        "formData",
        "data",
        "visible",
        "url",
        "addEditType",
        "editItemAmount",
        "pageTitle",
        "successMessage",
    ],
    components: {
        PlusOutlined,
        LoadingOutlined,
        SaveOutlined,
        PaymentModeAddButton,
    },
    setup(props, { emit }) {
        const { addEditRequestAdmin, loading, rules } = apiAdmin();
        const { disabledDate, appSetting, formatAmountCurrency } = common();

        const paymentModes = ref([]);

        onMounted(() => {
            getInitialData();
        });

        const getInitialData = () => {
            axiosAdmin.get("payment-modes?limit=10000").then((response) => {
                paymentModes.value = response.data;
            });
        };

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

        const paymentModeAdded = () => {
            getInitialData();
        };

        const onClose = () => {
            rules.value = {};
            emit("closed");
        };

        return {
            paymentModes,
            appSetting,
            formatAmountCurrency,
            disabledDate,
            loading,
            rules,
            onClose,
            onSubmit,
            paymentModeAdded,
        };
    },
});
</script>
