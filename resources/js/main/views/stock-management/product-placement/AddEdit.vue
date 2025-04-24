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
                            <h2>{{formData.invoice_number}}</h2>
                        </a-col>
                    </a-row>
                    <a-row :gutter="16">
                        <a-col :xs="24" :sm="24" :md="24" :lg="24">
                            {{$t("common.created_by")}} : {{formData.createdby_name}}
                        </a-col>
                    </a-row>
                    <a-row :gutter="16">
                        <a-col :xs="24" :sm="24" :md="24" :lg="24">
                            {{$t("stock_in.warehouse")}} : {{formData.warehouse_name}}
                        </a-col>
                    </a-row>
                    <a-row :gutter="16">
                        <a-col :xs="24" :sm="24" :md="24" :lg="24">
                            {{$t("stock_in.placement_date")}} : {{formData.placement_date.replace('T',' ')}}
                        </a-col>
                    </a-row>
                    <a-row :gutter="16">
                        <a-col :xs="24" :sm="24" :md="24" :lg="24">
                            {{$t("stock_in.total_items")}} : {{formData.total_items}}
                        </a-col>
                    </a-row>
                    <a-row :gutter="16">
                        <a-col :xs="24" :sm="24" :md="24" :lg="24">
                            {{$t("stock_in.total_quantity")}} : {{formData.total_quantity}}
                        </a-col>
                    </a-row>
                    <a-row :gutter="16">
                        <a-col :xs="24" :sm="24" :md="24" :lg="24">
                            {{$t("stock_in.notes")}} : {{formData.notes}}
                        </a-col>
                    </a-row>

                    
                    <table class="table" border='1' width='90%'>
                        <thead>
                            <tr>
                                <td>{{$t("stock_in.product_name")}}</td>
                                <td>{{$t("stock_in.quantity")}}</td>
                                <td>{{$t("stock_in.floor")}}</td>
                                <td>{{$t("stock_in.shelf_group")}}</td>
                                <td>{{$t("stock_in.shelf_number")}}</td>
                                <td>{{$t("stock_in.row")}}</td>
                            </tr>
                        </thead>
                    
                        <tbody>
                        <tr v-for="item in formData.items" :key="item.id">
                            <td>{{item.name}}</td>
                            <td align="center">{{item.qty}}</td>
                            <td align="center">{{item.floor}}</td>
                            <td align="center">{{item.shelf_group}}</td>
                            <td align="center">{{item.shelf_number}}</td>
                            <td align="center">{{item.row}}</td>
                        </tr>
                        </tbody>
                    </table>
                    
                    <a-typography-link
                        @click="exportExcel"
                        target="_blank"
                    >
                        <a-button type="primary">
                            <FileExcelOutlined />
                            {{ $t("common.export") }}
                        </a-button>
                    </a-typography-link>

                </a-tab-pane>
            </a-tabs>    
        </a-form>
        <template #footer>
            <a-button @click="onClose">
                {{ $t("common.close") }}
            </a-button>
        </template>
    </a-drawer>
</template>

<script>
import { defineComponent, ref, reactive, onMounted } from "vue";
import {
    PlusOutlined,
    LoadingOutlined,
    SaveOutlined,
    FileTextOutlined,
    EyeOutlined,
    SettingOutlined,
} from "@ant-design/icons-vue";
import apiAdmin from "../../../../common/composable/apiAdmin";
import Upload from "../../../../common/core/ui/file/Upload.vue";
import common from "../../../../common/composable/common";
import { useStore } from "vuex";

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
    emits: ["addEditSuccess"],
    components: {
        PlusOutlined,
        LoadingOutlined,
        SaveOutlined,
        FileTextOutlined,
        EyeOutlined,
        SettingOutlined,
        Upload,
    },
    setup(props, { emit }) {
        const store = useStore();
        const { addEditRequestAdmin, loading, rules } = apiAdmin();
        const { slugify, salesOrderStatus, selectedWarehouse } = common();
        const activeKey = ref("basic_details");
        const radioStyle = reactive({
            display: "flex",
            height: "30px",
            lineHeight: "30px",
        });
        const stores = ref([]);
        

        onMounted(() => {
            
        });

        const exportExcel = () => {
            var code = props.formData.invoice_number;
            var url = '/admin/stock-management/invoice/export?invoice='+code;
            window.location = url;
        }
        
        const onSubmit = () => {
            addEditRequestAdmin({
                url: props.url,
                data: props.formData,
                successMessage: props.successMessage,
                success: (res) => {
                    store.dispatch("auth/updateAllWarehouses");

                    if (
                        selectedWarehouse.value &&
                        selectedWarehouse.value.xid &&
                        selectedWarehouse.value.xid == res.xid
                    ) {
                        axiosAdmin
                            .post("change-warehouse", {
                                warehouse_id: res.xid,
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
                },
            });
        };

        const onClose = () => {
            activeKey.value = "basic_details";
            rules.value = {};
            emit("closed");
        };

        return {
            loading,
            rules,
            onClose,
            onSubmit,
            slugify,
            activeKey,
            salesOrderStatus,
            radioStyle,
            exportExcel,

            drawerWidth: window.innerWidth <= 991 ? "90%" : "45%",
        };
    },
});
</script>
<style>
    .table tr td{
        border: 1px solid;
    }
</style>