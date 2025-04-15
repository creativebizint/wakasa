<template>
    <a-layout-sider
        :width="240"
        :style="{
            margin: '0 0 0 0',
            overflowY: 'auto',
            position: 'fixed',
            paddingTop: '8px',
            zIndex: 998,
        }"
        :trigger="null"
        :collapsed="menuCollapsed"
        :theme="appSetting.left_sidebar_theme"
        class="sidebar-right-border"
    >
        <div v-if="menuCollapsed" class="logo">
            <img
                :style="{
                    height: '32px',
                }"
                :src="
                    appSetting.left_sidebar_theme == 'dark'
                        ? appSetting.small_dark_logo_url
                        : appSetting.small_light_logo_url
                "
            />
        </div>
        <div v-else>
            <img
                :style="{
                    width: '150px',
                    height: '53px',
                    paddingLeft: appSetting.rtl ? '0px' : '30px',
                    paddingRight: appSetting.rtl ? '30px' : '0px',
                    paddingTop: '5px',
                    paddingBottom: '20px',
                    marginLeft: appSetting.rtl ? '0px' : '10px',
                    marginRight: appSetting.rtl ? '10px' : '0px',
                }"
                :src="
                    appSetting.left_sidebar_theme == 'dark'
                        ? appSetting.dark_logo_url
                        : appSetting.light_logo_url
                "
            />
            <CloseOutlined
                v-if="innerWidth <= 991"
                :style="{
                    marginLeft: appSetting.rtl ? '0px' : '45px',
                    marginRight: appSetting.rtl ? '45px' : '0px',
                    verticalAlign: 'super',
                    color:
                        appSetting.left_sidebar_theme == 'dark'
                            ? '#fff'
                            : '#000000',
                }"
                @click="menuSelected"
            />
        </div>

        <div class="main-sidebar">
            <perfect-scrollbar
                :options="{
                    wheelSpeed: 1,
                    swipeEasing: true,
                    suppressScrollX: true,
                }"
            >
                <a-menu
                    :theme="appSetting.left_sidebar_theme"
                    :openKeys="openKeys"
                    v-model:selectedKeys="selectedKeys"
                    :mode="mode"
                    @openChange="onOpenChange"
                    :style="{ borderRight: 'none' }"
                >
                    <a-menu-item
                        @click="
                            () => {
                                menuSelected();
                                $router.push({ name: 'admin.dashboard.index' });
                            }
                        "
                        key="dashboard"
                    >
                        <HomeOutlined />
                        <span>{{ $t("menu.dashboard") }}</span>
                    </a-menu-item>


                <a-sub-menu
                        v-if="
                            permsArray.includes('customers_view') ||
                            permsArray.includes('suppliers_view') ||
                            permsArray.includes('admin')
                        "
                        key="app_configuration"
                    >    
                    <template #title>
                            <span>
                                <TeamOutlined />
                                <span>{{ $t("menu.app_configuration") }}</span>
                            </span>
                    </template>
                    <a-sub-menu
                        v-if="
                            permsArray.includes('customers_view') ||
                            permsArray.includes('suppliers_view') ||
                            permsArray.includes('admin')
                        "
                        key="parties"
                    >
                        <template #title>
                            <span>
                                <TeamOutlined />
                                <span>{{ $t("menu.parties") }}</span>
                            </span>
                        </template>
                        <a-menu-item
                            v-if="
                                permsArray.includes('customers_view') ||
                                permsArray.includes('admin')
                            "
                            @click="
                                () => {
                                    menuSelected();
                                    $router.push({
                                        name: 'admin.customers.index',
                                    });
                                }
                            "
                            key="customers"
                        >
                            {{ $t("menu.customers") }}
                        </a-menu-item>
                        <a-menu-item
                            v-if="
                                permsArray.includes('suppliers_view') ||
                                permsArray.includes('admin')
                            "
                            @click="
                                () => {
                                    menuSelected();
                                    $router.push({
                                        name: 'admin.suppliers.index',
                                    });
                                }
                            "
                            key="suppliers"
                        >
                            {{ $t("menu.suppliers") }}
                        </a-menu-item>
                    </a-sub-menu>

                    <a-sub-menu
                        key="shelf"
                        v-if="
                            permsArray.includes('floors_view') ||
                            permsArray.includes('rows_view') ||
                            permsArray.includes('shelf_groups_view') ||
                            permsArray.includes('shelf_numbers_view') ||
                            permsArray.includes('admin')
                        "
                    >
                        <template #title>
                            <span>
                                <ContainerOutlined />
                                <span>{{ $t("menu.shelf") }}</span>
                            </span>
                        </template>
                        <a-menu-item
                            @click="
                                () => {
                                    menuSelected();
                                    $router.push({
                                        name: 'admin.floors.index',
                                    });
                                }
                            "
                            key="floors"
                            v-if="
                                permsArray.includes('floors_view') ||
                                permsArray.includes('admin')
                            "
                        >
                            {{ $t("menu.floors") }}
                        </a-menu-item>

                        <a-menu-item
                            @click="
                                () => {
                                    menuSelected();
                                    $router.push({
                                        name: 'admin.shelfGroups.index',
                                    });
                                }
                            "
                            key="shelfgroups"
                            v-if="
                                permsArray.includes('shelf_groups_view') ||
                                permsArray.includes('admin')
                            "
                        >
                            {{ $t("menu.shelf_groups") }}
                        </a-menu-item>

                        <a-menu-item
                            @click="
                                () => {
                                    menuSelected();
                                    $router.push({
                                        name: 'admin.shelfNumbers.index',
                                    });
                                }
                            "
                            key="shelfnumbers"
                            v-if="
                                permsArray.includes('shelf_numbers_view') ||
                                permsArray.includes('admin')
                            "
                        >
                            {{ $t("menu.shelf_numbers") }}
                        </a-menu-item>

                        <a-menu-item
                            @click="
                                () => {
                                    menuSelected();
                                    $router.push({
                                        name: 'admin.rows.index',
                                    });
                                }
                            "
                            key="rows"
                            v-if="
                                permsArray.includes('rows_view') ||
                                permsArray.includes('admin')
                            "
                        >
                            {{ $t("menu.rows") }}
                        </a-menu-item>
                    </a-sub-menu>
                    
                    <a-menu-item
                            @click="
                                () => {
                                    menuSelected();
                                    $router.push({
                                        name: 'admin.products.index',
                                    });
                                }
                            "
                            key="products"
                            v-if="
                                permsArray.includes('products_view') ||
                                permsArray.includes('admin')
                            "
                        >
                        <AppstoreOutlined />
                            {{ $t("menu.products") }}
                    </a-menu-item>

                    <a-menu-item
                            @click="
                                () => {
                                    menuSelected();
                                    $router.push({
                                        name: 'admin.uom.index',
                                    });
                                }
                            "
                            key="uom"
                            v-if="
                                permsArray.includes('products_view') ||
                                permsArray.includes('admin')
                            "
                        >
                        <AppstoreOutlined />
                            {{ $t("menu.uom") }}
                    </a-menu-item>

                    <a-menu-item
                            @click="
                                () => {
                                    menuSelected();
                                    $router.push({
                                        name: 'admin.warehouses.index',
                                    });
                                }
                            "
                            key="warehouses"
                            v-if="
                                permsArray.includes('warehouses_view') ||
                                permsArray.includes('admin')
                            "
                        >
                        <ShopOutlined />
                            {{ $t("menu.warehouses") }}
                    </a-menu-item>
                </a-sub-menu>
                    


                    <a-sub-menu
                        key="product_manager"
                        v-if="
                            permsArray.includes('brands_view') ||
                            permsArray.includes('categories_view') ||
                            permsArray.includes('variations_view') ||
                            permsArray.includes('products_view') ||
                            permsArray.includes('admin')
                        "
                    >
                        <template #title>
                            <span>
                                <AppstoreOutlined />
                                <span>{{ $t("menu.master_product") }}</span>
                            </span>
                        </template>
                        <a-menu-item
                            @click="
                                () => {
                                    menuSelected();
                                    $router.push({
                                        name: 'admin.brands.index',
                                    });
                                }
                            "
                            key="brands"
                            v-if="
                                permsArray.includes('brands_view') ||
                                permsArray.includes('admin')
                            "
                        >
                            {{ $t("menu.brands") }}
                        </a-menu-item>
                        <a-menu-item
                            @click="
                                () => {
                                    menuSelected();
                                    $router.push({
                                        name: 'admin.parts.index',
                                    });
                                }
                            "
                            key="parts"
                            v-if="
                                permsArray.includes('parts_view') ||
                                permsArray.includes('admin')
                            "
                        >
                            {{ $t("menu.parts") }}
                        </a-menu-item>
                        <a-menu-item
                            @click="
                                () => {
                                    menuSelected();
                                    $router.push({
                                        name: 'admin.categories.index',
                                    });
                                }
                            "
                            key="categories"
                            v-if="
                                permsArray.includes('categories_view') ||
                                permsArray.includes('admin')
                            "
                        >
                            {{ $t("menu.categories") }}
                        </a-menu-item>
                        <a-menu-item
                            @click="
                                () => {
                                    menuSelected();
                                    $router.push({
                                        name: 'admin.barcode.index',
                                    });
                                }
                            "
                            key="barcode"
                            v-if="
                                permsArray.includes('barcode_view') ||
                                permsArray.includes('admin')
                            "
                        >
                            {{ $t("menu.barcode") }}
                        </a-menu-item>
                        
                        
                    </a-sub-menu>

                    
                    <a-sub-menu
                        key="stock_management"
                        v-if="
                            permsArray.includes('stock_managements_view') ||
                            permsArray.includes('admin')
                        "
                    >
                        <template #title>
                            <span>
                                <ClusterOutlined />
                                <span>{{ $t("menu.stock_management") }}</span>
                            </span>
                        </template>
                        
                        <a-menu-item
                            @click="
                                () => {
                                    menuSelected();
                                    $router.push({
                                        name: 'admin.inventory_in.index',
                                    });
                                }
                            "
                            key="inventory_in"
                            v-if="
                                permsArray.includes('inventory_in_view') ||
                                permsArray.includes('admin')
                            "
                        >
                            {{ $t("menu.inventory_in") }}
                        </a-menu-item>
                        
                        <a-menu-item
                            @click="
                                () => {
                                    menuSelected();
                                    $router.push({
                                        name: 'admin.barcode_registration.index',
                                    });
                                }
                            "
                            key="barcode_registration"
                            v-if="
                                permsArray.includes('barcode_registration_view') ||
                                permsArray.includes('admin')
                            "
                        >
                            {{ $t("menu.barcode_registration") }}
                        </a-menu-item>

                        <a-menu-item
                            @click="
                                () => {
                                    menuSelected();
                                    $router.push({
                                        name: 'admin.stock.stock-transfers.index',
                                    });
                                }
                            "
                            key="stock_transfer"
                            v-if="
                                (permsArray.includes('stock_transfers_view') ||
                                    permsArray.includes('admin')) &&
                                willSubscriptionModuleVisible('stock_transfer')
                            "
                        >
                            <span>{{ $t("menu.stock_transfer") }}</span>
                        </a-menu-item>
                        
                        <a-menu-item
                            @click="
                                () => {
                                    menuSelected();
                                    $router.push({
                                        name: 'admin.stock.stock-adjustment-orders.index',
                                    });
                                }
                            "
                            key="stock_adjustment"
                            v-if="
                                (permsArray.includes('stock_adjustments_view') ||
                                    permsArray.includes('admin')) &&
                                willSubscriptionModuleVisible('stock_adjustment')
                            "
                        >
                            <span>{{ $t("menu.stock_adjustment") }}</span>
                        </a-menu-item>

                        <a-menu-item
                            @click="
                                () => {
                                    menuSelected();
                                    $router.push({
                                        name: 'admin.inventory_out.index',
                                    });
                                }
                            "
                            key="inventory_out"
                            v-if="
                                permsArray.includes('inventory_out_view') ||
                                permsArray.includes('admin')
                            "
                        >
                            {{ $t("menu.inventory_out") }}
                        </a-menu-item>
                    </a-sub-menu>

                    <a-sub-menu
                        key="product_placement"
                        v-if="
                            permsArray.includes('product_placement_view') ||
                            permsArray.includes('admin')
                        "
                    >
                        <template #title>
                            <span>
                                <ClusterOutlined />
                                <span>{{ $t("menu.product_placement") }}</span>
                            </span>
                        </template>
                        
                        <a-menu-item
                            @click="
                                () => {
                                    menuSelected();
                                    $router.push({
                                        name: 'admin.product_placement.placement_in',
                                    });
                                }
                            "
                            key="placement_in"
                            v-if="
                                permsArray.includes('placement_in_view') ||
                                permsArray.includes('admin')
                            "
                        >
                            <span>{{ $t("menu.placement_in") }}</span>
                        </a-menu-item>
                    </a-sub-menu>

                    <a-sub-menu
                        key="order_fullfillment"
                        v-if="
                            permsArray.includes('order_fullfillment_view') ||
                            permsArray.includes('admin')
                        "
                    >
                        <template #title>
                            <span>
                                <ClusterOutlined />
                                <span>{{ $t("menu.order_fullfillment") }}</span>
                            </span>
                        </template>
                        
                        <a-menu-item
                            @click="
                                () => {
                                    menuSelected();
                                    $router.push({
                                        name: 'admin.order_fullfillment.picking_request',
                                    });
                                }
                            "
                            key="picking_request"
                            v-if="
                                permsArray.includes('order_fullfillment_view') ||
                                permsArray.includes('admin')
                            "
                        >
                            <span>{{ $t("menu.picking_request") }}</span>
                        </a-menu-item>

                        <a-menu-item
                            @click="
                                () => {
                                    menuSelected();
                                    $router.push({
                                        name: 'admin.order_fullfillment.picking_assignment',
                                    });
                                }
                            "
                            key="inventory_out"
                            v-if="
                                permsArray.includes('order_fullfillment_view') ||
                                permsArray.includes('admin')
                            "
                        >
                            {{ $t("menu.picking_assignment") }}
                        </a-menu-item>

                        <a-menu-item
                            @click="
                                () => {
                                    menuSelected();
                                    $router.push({
                                        name: 'admin.stock_management.out_history',
                                    });
                                }
                            "
                            key="out_history"
                            v-if="
                                permsArray.includes('stock_managements_view') ||
                                permsArray.includes('admin')
                            "
                        >
                            <span>{{ $t("menu.qc_packing") }}</span>
                        </a-menu-item>
                    </a-sub-menu>

                    
                    <a-sub-menu
                        key="inventory"
                        v-if="
                            permsArray.includes('inventory_in_view') ||
                            permsArray.includes('inventory_out_view') ||
                            permsArray.includes('admin')
                        "
                    >
                        <template #title>
                            <span>
                                <ContainerOutlined />
                                <span>{{ $t("menu.inventory") }}</span>
                            </span>
                        </template>
                        
                        <a-menu-item
                            @click="
                                () => {
                                    menuSelected();
                                    $router.push({
                                        name: 'admin.stock_management.index',
                                    });
                                }
                            "
                            key="product_placement"
                            v-if="
                                permsArray.includes('stock_managements_view') ||
                                permsArray.includes('admin')
                            "
                        >
                            <span>{{ $t("menu.stock_management") }}</span>
                        </a-menu-item>

                        <a-menu-item
                            @click="
                                () => {
                                    menuSelected();
                                    $router.push({
                                        name: 'admin.stock_management.in_history',
                                    });
                                }
                            "
                            key="in_history"
                            v-if="
                                permsArray.includes('stock_managements_view') ||
                                permsArray.includes('admin')
                            "
                        >
                            <span>{{ $t("menu.stock_in") }}</span>
                        </a-menu-item>

                        

                    </a-sub-menu>
                    

                    <a-menu-item
                        @click="
                            () => {
                                menuSelected();
                                $router.push({
                                    name: 'admin.stock_listing.index',
                                });
                            }
                        "
                        key="stock_listing"
                        v-if="
                            permsArray.includes('stock_listings_view') ||
                            permsArray.includes('admin')
                        "
                    >
                        <BuildOutlined />
                        <span>{{ $t("menu.stock_listing") }}</span>
                    </a-menu-item>

                    <a-sub-menu
                        v-if="
                            (((permsArray.includes('purchases_view') ||
                                permsArray.includes('sales_view') ||
                                permsArray.includes('purchase_returns_view') ||
                                permsArray.includes('sales_returns_view')) &&
                                permsArray.includes('order_payments_view')) ||
                                permsArray.includes('products_view') ||
                                permsArray.includes('customers_view') ||
                                permsArray.includes('suppliers_view') ||
                                permsArray.includes('expenses_view') ||
                                permsArray.includes('admin')) &&
                            willSubscriptionModuleVisible('reports')
                        "
                        key="reports"
                    >
                        <template #title>
                            <span>
                                <BarChartOutlined />
                                <span>{{ $t("menu.reports") }}</span>
                            </span>
                        </template>
                        <a-menu-item
                            v-if="
                                permsArray.includes('products_view') ||
                                permsArray.includes('admin')
                            "
                            @click="
                                () => {
                                    menuSelected();
                                    $router.push({
                                        name: 'admin.reports.stock.index',
                                    });
                                }
                            "
                            key="stock_alert"
                        >
                            {{ $t("menu.stock_alert") }}
                        </a-menu-item>
                        <a-menu-item
                            v-if="
                                permsArray.includes('products_view') ||
                                permsArray.includes('admin')
                            "
                            @click="
                                () => {
                                    menuSelected();
                                    $router.push({
                                        name: 'admin.reports.stock_summary.index',
                                    });
                                }
                            "
                            key="stock_summary"
                        >
                            {{ $t("menu.stock_summary") }}
                        </a-menu-item>
                        <a-menu-item
                            v-if="
                                permsArray.includes('customers_view') ||
                                permsArray.includes('suppliers_view') ||
                                permsArray.includes('admin')
                            "
                            @click="
                                () => {
                                    menuSelected();
                                    $router.push({
                                        name: 'admin.reports.users.index',
                                    });
                                }
                            "
                            key="users_reports"
                        >
                            {{ $t("menu.users_reports") }}
                        </a-menu-item>
                    </a-sub-menu>

                    
                    
                    <component
                        v-for="(appModule, index) in appModules"
                        :key="index"
                        v-bind:is="appModule + 'Menu'"
                        @menuSelected="menuSelected"
                    />
 


                    <a-sub-menu
                        key="setting"
                        v-if="
                            permsArray.includes('setting_view') ||
                            permsArray.includes('setting_view') ||
                            permsArray.includes('admin')
                        "
                    >
                        <template #title>
                            <span>
                                <SettingOutlined />
                                <span>{{ $t("menu.settings") }}</span>
                            </span>
                        </template>
                    <a-menu-item
                        @click="
                            () => {
                                menuSelected();
                                $router.push({
                                    name: 'admin.settings.profile.index',
                                });
                            }
                        "
                        key="settings"
                    >
                        <span>{{ $t("menu.general_settings") }}</span>
                    </a-menu-item>

                    <a-menu-item
                        v-if="
                            (permsArray.includes('users_view') ||
                                permsArray.includes('admin')) &&
                            appModules.includes('StockiflyHrm') == false
                        "
                        @click="
                            () => {
                                menuSelected();
                                $router.push({ name: 'admin.users.index' });
                            }
                        "
                        key="users"
                    >
                        <span>{{ $t("menu.users") }}</span>
                    </a-menu-item>

                    <a-menu-item
                        v-if="
                            (permsArray.includes('groups_view') ||
                                permsArray.includes('admin')) &&
                            appModules.includes('StockiflyHrm') == false
                        "
                        @click="
                            () => {
                                menuSelected();
                                $router.push({ name: 'admin.groups.index' });
                            }
                        "
                        key="groups"
                    >
                        <span>{{ $t("menu.groups") }}</span>
                    </a-menu-item>

                    </a-sub-menu>
 
                    <a-menu-item @click="logout" key="logout">
                        <LogoutOutlined />
                        <span>{{ $t("menu.logout") }}</span>
                    </a-menu-item>
                </a-menu>
            </perfect-scrollbar>
        </div>
    </a-layout-sider>
</template>

<script>
import { defineComponent, ref, watch, onMounted, computed } from "vue";
import { Layout } from "ant-design-vue";
import { useStore } from "vuex";
import { useRoute } from "vue-router";
import {
    HomeOutlined,
    LogoutOutlined,
    UserOutlined,
    SettingOutlined,
    CloseOutlined,
    ShoppingOutlined,
    ShoppingCartOutlined,
    AppstoreOutlined,
    ShopOutlined,
    BarChartOutlined,
    CalculatorOutlined,
    TeamOutlined,
    WalletOutlined,
    BankOutlined,
    RocketOutlined,
    LaptopOutlined,
    CarOutlined,
    DollarCircleOutlined,
    ClusterOutlined,
    ContainerOutlined,
    BuildOutlined,
} from "@ant-design/icons-vue";
import { PerfectScrollbar } from "vue3-perfect-scrollbar";
import common from "../../common/composable/common";
const { Sider } = Layout;

export default defineComponent({
    components: {
        Sider,
        PerfectScrollbar,
        Layout,

        HomeOutlined,
        LogoutOutlined,
        UserOutlined,
        SettingOutlined,
        CloseOutlined,
        ShoppingOutlined,
        ShoppingCartOutlined,
        AppstoreOutlined,
        ShopOutlined,
        BarChartOutlined,
        CalculatorOutlined,
        TeamOutlined,
        WalletOutlined,
        BankOutlined,
        RocketOutlined,
        LaptopOutlined,
        CarOutlined,
        DollarCircleOutlined,

        ClusterOutlined,
        ContainerOutlined,
        BuildOutlined,
    },
    setup(props, { emit }) {
        const {
            appSetting,
            appType,
            user,
            permsArray,
            appModules,
            menuCollapsed,
            willSubscriptionModuleVisible,
        } = common();
        const rootSubmenuKeys = [
            "dashboard",
            "product_manager",
            "stock_management",
            "pos",
            "stock_transfer",
            "stock_adjustment",
            "sales",
            "purchases",
            "expense_manager",
            "users",
            "reports",
            "settings",
            "online_orders",
            "website_setup",
            "cash_bank",
            "subscription",
            "hrm",
            "order_fullfillment",
            "app_configuration",
        ];
        const store = useStore();
        const route = useRoute();

        const innerWidth = window.innerWidth;
        const openKeys = ref([]);
        const selectedKeys = ref([]);
        const mode = ref("inline");

        onMounted(() => {
            var menuKey =
                typeof route.meta.menuKey == "function"
                    ? route.meta.menuKey(route)
                    : route.meta.menuKey;

            if (route.meta.menuParent == "settings") {
                menuKey = "settings";
            }

            if (route.meta.menuParent == "subscription") {
                menuKey = "subscription";
            }

            if (route.meta.menuParent == "staff") {
                menuKey = "staff";
            }

            if (route.meta.menuParent == "holidays") {
                menuKey = "holidays";
            }

            if (route.meta.menuParent == "leaves") {
                menuKey = "leaves";
            }

            if (route.meta.menuParent == "attendances") {
                menuKey = "attendances";
            }

            if (route.meta.menuParent == "payrolls") {
                menuKey = "payrolls";
            }

            if (route.meta.menuParent == "appreciations") {
                menuKey = "appreciations";
            }

            if (innerWidth <= 991) {
                openKeys.value = [];
            } else if (
                route.meta.menuParent == "staff" ||
                route.meta.menuParent == "leaves" ||
                route.meta.menuParent == "attendances" ||
                route.meta.menuParent == "payrolls" ||
                route.meta.menuParent == "appreciations" ||
                route.meta.menuParent == "holidays"
            ) {
                openKeys.value = menuCollapsed.value ? [] : ["hrm"];
            } else {
                openKeys.value = menuCollapsed.value
                    ? []
                    : [route.meta.menuParent];
            }

            selectedKeys.value = [menuKey.replace("-", "_")];
        });

        const logout = () => {
            store.dispatch("auth/logout");
        };

        const menuSelected = () => {
            if (innerWidth <= 991) {
                store.commit("auth/updateMenuCollapsed", true);
            }
        };

        const onOpenChange = (currentOpenKeys) => {
            const latestOpenKey = currentOpenKeys.find(
                (key) => openKeys.value.indexOf(key) === -1
            );

            if (rootSubmenuKeys.indexOf(latestOpenKey) === -1) {
                openKeys.value = currentOpenKeys;
            } else {
                openKeys.value = latestOpenKey ? [latestOpenKey] : [];
            }
        };

        watch(route, (newVal, oldVal) => {
            const menuKey =
                typeof newVal.meta.menuKey == "function"
                    ? newVal.meta.menuKey(newVal)
                    : newVal.meta.menuKey;

            if (innerWidth <= 991) {
                openKeys.value = [];
            } else if (
                newVal.meta.menuParent == "staff" ||
                newVal.meta.menuParent == "leaves" ||
                newVal.meta.menuParent == "attendances" ||
                newVal.meta.menuParent == "payrolls" ||
                newVal.meta.menuParent == "appreciations" ||
                newVal.meta.menuParent == "holidays"
            ) {
                openKeys.value = ["hrm"];
            } else {
                openKeys.value = [newVal.meta.menuParent];
            }

            if (newVal.meta.menuParent == "settings") {
                selectedKeys.value = ["settings"];
            } else if (newVal.meta.menuParent == "subscription") {
                selectedKeys.value = ["subscription"];
            } else if (newVal.meta.menuParent == "staff") {
                selectedKeys.value = ["staff"];
            } else if (newVal.meta.menuParent == "leaves") {
                selectedKeys.value = ["leaves"];
            } else if (newVal.meta.menuParent == "holidays") {
                selectedKeys.value = ["holidays"];
            } else if (newVal.meta.menuParent == "payrolls") {
                selectedKeys.value = ["payrolls"];
            } else if (newVal.meta.menuParent == "attendances") {
                selectedKeys.value = ["attendances"];
            } else if (newVal.meta.menuParent == "appreciations") {
                selectedKeys.value = ["appreciations"];
            } else {
                selectedKeys.value = [menuKey.replace("-", "_")];
            }
        });

        watch(
            () => menuCollapsed.value,
            (newVal, oldVal) => {
                const menuKey =
                    typeof route.meta.menuKey == "function"
                        ? route.meta.menuKey(route)
                        : route.meta.menuKey;

                if (innerWidth <= 991 && menuCollapsed.value) {
                    openKeys.value = [];
                } else {
                    openKeys.value = menuCollapsed.value
                        ? []
                        : [route.meta.menuParent];
                }

                if (
                    route.meta.menuParent &&
                    route.meta.menuParent == "settings"
                ) {
                    selectedKeys.value = ["settings"];
                } else if (
                    route.meta.menuParent &&
                    route.meta.menuParent == "subscription"
                ) {
                    selectedKeys.value = ["subscription"];
                } else if (
                    route.meta.menuParent &&
                    route.meta.menuParent == "staff"
                ) {
                    selectedKeys.value = ["staff"];
                } else if (
                    route.meta.menuParent &&
                    route.meta.menuParent == "leaves"
                ) {
                    selectedKeys.value = ["leaves"];
                } else if (
                    route.meta.menuParent &&
                    route.meta.menuParent == "holidays"
                ) {
                    selectedKeys.value = ["holidays"];
                } else if (
                    route.meta.menuParent &&
                    route.meta.menuParent == "payrolls"
                ) {
                    selectedKeys.value = ["payrolls"];
                } else if (
                    route.meta.menuParent &&
                    route.meta.menuParent == "appreciations"
                ) {
                    selectedKeys.value = ["appreciations"];
                } else if (
                    route.meta.menuParent &&
                    route.meta.menuParent == "attendances"
                ) {
                    selectedKeys.value = ["attendances"];
                } else {
                    selectedKeys.value = [menuKey.replace("-", "_")];
                }
            }
        );

        return {
            mode,
            selectedKeys,
            openKeys,
            logout,
            innerWidth: window.innerWidth,

            onOpenChange,
            menuSelected,
            menuCollapsed,
            appSetting,
            appType,
            user,
            permsArray,
            appModules,
            willSubscriptionModuleVisible,
        };
    },
});
</script>

<style lang="less">
.main-sidebar .ps {
    height: calc(100vh - 62px);
}

@media only screen and (max-width: 1150px) {
    .ant-layout-sider.ant-layout-sider-collapsed {
        left: -80px !important;
    }
}
</style>
