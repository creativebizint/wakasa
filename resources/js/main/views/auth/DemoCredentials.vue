<template></template>

<script>
import { defineComponent, reactive, ref, onMounted } from "vue";
import { SnippetsOutlined } from "@ant-design/icons-vue";

export default defineComponent({
	props: ["credentials"],
	components: {
		SnippetsOutlined,
	},
	setup() {
		const appEnv = window.config.app_env;
		const appType = window.config.app_type;
		const demoCredentialsColumns = ref([
			{
				title: "Details",
				dataIndex: "details",
			},
			{
				title: "action",
				dataIndex: "action",
			},
		]);
		const demoCredentials = ref([
			{
				name: "Admin",
				email: "admin@example.com",
				password: 12345678,
			},
			{
				name: "StockManager",
				email: "stockmanager@example.com",
				password: 12345678,
			},
			{
				name: "Salesman",
				email: "salesman@example.com",
				password: 12345678,
			},
		]);

		onMounted(() => {
			if (appType == "saas") {
				demoCredentials.value = [
					{
						name: "SuperAdmin",
						email: "superadmin@example.com",
						password: 12345678,
					},
					...demoCredentials.value,
				];
			}
		});

		return {
			appEnv,
			demoCredentials,
			demoCredentialsColumns,
		};
	},
});
</script>
