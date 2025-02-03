<template>
    

    <a-modal
        v-model:open="visible"
        :centered="true"
        :footer="null"
        :maskClosable="false"
        :destroyOnClose="true"
    >
        <template #title>
            <ClockCircleOutlined />
            {{ $t("hrm_dashboard.today_attendance") }}
        </template>

    </a-modal>
</template>

<script>
import { onMounted, ref, computed } from "vue";
import { ClockCircleOutlined } from "@ant-design/icons-vue";
import { useStore } from "vuex";
import common from "../../../common/composable/common";

export default {
    components: {
        ClockCircleOutlined,
    },
    setup(props, { emit }) {
        const store = useStore();
        const { permsArray, appModules } = common();
        const visible = ref(false);
        const isSelfClocking = computed(() => store.state.hrm.isSelfClocking);

        onMounted(() => {
        });

        const showModal = () => {
            visible.value = true;
        };

        return {
            permsArray,
            appModules,
            isSelfClocking,

            visible,
            showModal,
        };
    },
};
</script>
