<template>
    <AdminPageHeader>
        <template #header>
            <a-page-header :title="$t(`menu.qc_picking`)" class="p-0" />
        </template>
        <template #breadcrumb>
            <a-breadcrumb separator="-" style="font-size: 12px">
                <a-breadcrumb-item>
                    <router-link :to="{ name: 'admin.dashboard.index' }">
                        {{ $t(`menu.dashboard`) }}
                    </router-link>
                </a-breadcrumb-item>
                <a-breadcrumb-item>
                    {{ $t(`menu.qc_picking`) }}
                </a-breadcrumb-item>
            </a-breadcrumb>
        </template>
    </AdminPageHeader>

    <admin-page-filters>
        <a-row :gutter="[16, 16]">
            <a-col :xs="24" :sm="24" :md="12" :lg="10" :xl="10">
                <a-space>
<!--                    <a-button
                        v-if="
                            table.selectedRowKeys.length > 0 &&
                            (permsArray.includes('parts_delete') ||
                                permsArray.includes('admin'))
                        "
                        type="primary"
                        @click="showSelectedDeleteConfirm"
                        danger
                    >
                        <template #icon><DeleteOutlined /></template>
                        {{ $t("common.delete") }}
                    </a-button>-->
                </a-space>
            </a-col>
            <a-col :xs="24" :sm="24" :md="12" :lg="14" :xl="14">
                <a-row :gutter="[16, 16]" justify="end">
                    <a-col :xs="24" :sm="24" :md="12" :lg="8" :xl="6">
                        <a-input-search
                            style="width: 100%"
                            v-model:value="filters.invoice_number"
                            show-search
                            :placeholder="
                                $t('common.placeholder_search_text', [
                                    $t('product.invoice_number'),
                                ])
                            "
                            @search="onItemIdSearch"
                            @change="onItemIdSearch"
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
            @closed="onCloseAddEdit"
            :formData="formData"
            :data="viewData"
            :pageTitle="$t('menu.qc_picking')"
            :successMessage="successMessage"
        />

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
                        <template #bodyCell="{ column, text, record }">
                            <template v-if="column.dataIndex === 'name'">
                                {{record.name}}
                            </template>
                            <template v-if="column.dataIndex === 'created_at'">
                                {{formatDate(record.created_at)}}
                            </template>
                            <template v-if="column.dataIndex === 'priority'">
                                <a-tag :color="priorityColors[record.priority]">
                                        {{ record.priority }}
                                </a-tag>
                            </template>
                            <template v-if="column.dataIndex === 'note' && record.notes">
                                <a-popover placement="top" trigger="click">
                                  <template #content>
                                    <a-button type="link" @click="showNoteModal(record)">
                                      <MessageOutlined />
                                      {{ $t('common.note') }}
                                    </a-button>
                                  </template>
                                  <a-button type="default" size="small">
                                    <MessageOutlined />
                                    {{ $t('common.note') }}
                                  </a-button>
                                </a-popover>
                            </template>
                            <template v-if="column.dataIndex === 'status'">
                                <div v-if="record.status == '1'">
                                    <a-tag color="yellow">
                                        {{ $t(`common.${"open"}`) }}
                                    </a-tag>
                                </div>
                                <div v-if="record.status == '2'">
                                    <a-tag color="green">
                                        {{ $t(`common.${"complete"}`) }}
                                    </a-tag>
                                </div>
                            </template>
                            <template v-if="column.dataIndex === 'action'">
                                <a-button
                                    type="primary"
                                    @click="editItem(record)"
                                    style="margin-left: 4px"
                                >
                                    <template #icon><EyeOutlined /></template>
                                </a-button>

                                <!--
                                <a-button
                                    v-if="
                                        permsArray.includes('parts_edit') ||
                                        permsArray.includes('admin')
                                    "
                                    type="primary"
                                    @click="editItem(record)"
                                    style="margin-left: 4px"
                                >
                                    <template #icon><EditOutlined /></template>
                                </a-button>
                                <a-button
                                    v-if="
                                        permsArray.includes('parts_delete') ||
                                        permsArray.includes('admin')
                                    "
                                    type="primary"
                                    @click="showDeleteConfirm(record.xid)"
                                    style="margin-left: 4px"
                                >
                                    <template #icon><DeleteOutlined /></template>
                                </a-button>
                                -->
                            </template>
                        </template>
                    </a-table>
                </div>
            </a-col>
        </a-row>
    </admin-page-table-content>
    
    
    <!-- Note Modal -->
    <a-modal
        :visible="noteModalVisible"
        :title="$t('common.note')"
        @ok="noteModalVisible = false"
        @cancel="noteModalVisible = false"
        :footer="null"
    >
        <p>{{ selectedNote || $t('common.no_note') }}</p>
    </a-modal>
</template>
<script>
import { onMounted,ref } from "vue";
import { PlusOutlined, EditOutlined, DeleteOutlined, EyeOutlined } from "@ant-design/icons-vue";
import fields from "./fields";
import crud from "../../../../common/composable/crud";
import common from "../../../../common/composable/common";
import AddEdit from "./AddEdit.vue";
import AdminPageHeader from "../../../../common/layouts/AdminPageHeader.vue";
import QueueImport from "../../../../common/core/ui/QueueImport.vue";

export default {
    components: {
        EyeOutlined,
        PlusOutlined,
        EditOutlined,
        DeleteOutlined,
        AddEdit,
        AdminPageHeader,
        QueueImport,
    },
    setup() {
        const { addEditUrl, initData, columns, filterableColumns } = fields();
        const crudVariables = crud();
        const { permsArray,formatDate,priorityColors } = common();
        const sampleFileUrl = window.config.part_sample_file;
        const exportUrl = window.config.part_export_url;
        const filters = ref({
            invoice_number: ""
        });
        
        const onItemIdSearch = () => {
            setUrlData();
        };
        
        onMounted(() => {
            setUrlData();
        });
        // Note Modal Variables
        const noteModalVisible = ref(false);
        const selectedNote = ref("");
        
        // Function to show note modal
        const showNoteModal = (record) => {
            console.log("Record passed to showNoteModal:", record);
            selectedNote.value = record.notes || "";
            noteModalVisible.value = true;
          };
        
        // End For Online Orders
        
        const setUrlData = () => {
            crudVariables.tableUrl.value = {
                url: "qc-picking?",
                extraFilters: {
                    invoice_number: filters.value.invoice_number,
                }
            };
            crudVariables.table.filterableColumns = filterableColumns;

            crudVariables.fetch({
                page: 1,
            });

            crudVariables.crudUrl.value = addEditUrl;
            crudVariables.langKey.value = "part";
            crudVariables.initData.value = { ...initData };
            crudVariables.formData.value = { ...initData };
        };

        return {
            columns,
            filterableColumns,
            permsArray,
            ...crudVariables,
            sampleFileUrl,
            setUrlData,
            exportUrl,
            formatDate,
            filters, // Add filters to the return statement
            onItemIdSearch, // Ensure this is returned for the template to use
            priorityColors,
            
            // Note Modal
            noteModalVisible,
            selectedNote,
            showNoteModal,
        };
    },
};
</script>
