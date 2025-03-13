export default [
    {
        path: "/admin/stock/pos",
        component: () => import("../views/stock-management/pos/Pos.vue"),
        name: "admin.pos.index",
        meta: {
            requireAuth: true,
            menuParent: "pos",
            menuKey: "pos",
            permission: "pos_view",
        },
    },
    {
        path: "/admin/stock/",
        component: () => import("../../common/layouts/Admin.vue"),
        children: [
            {
                path: "adjustments",
                component: () =>
                    import("../views/stock-management/adjustment/index.vue"),
                name: "admin.stock_adjustments.index",
                meta: {
                    requireAuth: true,
                    menuParent: "stock_adjustment",
                    menuKey: "stock_adjustment",
                    permission: "stock_adjustments_view",
                },
            },
            
            // Adjustment Orders
            {
                path: "stock-adjustment-orders/edit/:id",
                component: () =>
                    import("../views/stock-management/adjustment-orders/Edit.vue"),
                name: "admin.stock.stock-adjustment-orders.edit",
                meta: {
                    requireAuth: true,
                    menuParent: "stock_adjustment",
                    menuKey: (route) => "stock_adjustment",
                    permission: (route) => "stock_adjustments_edit",
                    orderType: "stock-adjustment-orders",
                },
            },
            {
                path: "stock-adjustment-orders/create",
                component: () =>
                    import("../views/stock-management/adjustment-orders/Create.vue"),
                name: "admin.stock.stock-adjustment-orders.create",
                meta: {
                    requireAuth: true,
                    menuParent: "stock_adjustment",
                    menuKey: (route) => "stock_adjustment",
                    permission: (route) => "stock_adjustments_create",
                    orderType: "stock-adjustment-orders",
                },
            },
            {
                path: "stock-adjustment-orders",
                component: () =>
                    import("../views/stock-management/adjustment-orders/index.vue"),
                name: "admin.stock.stock-adjustment-orders.index",
                meta: {
                    requireAuth: true,
                    menuParent: "stock_adjustment",
                    menuKey: (route) => "stock_adjustment",
                    permission: (route) => "stock_adjustments_view",
                    orderType: "stock-adjustment-orders",
                },
            },
            
            // Purchases
            {
                path: "purchases/edit/:id",
                component: () =>
                    import("../views/stock-management/purchases/Edit.vue"),
                name: "admin.stock.purchases.edit",
                meta: {
                    requireAuth: true,
                    menuParent: "purchases",
                    menuKey: (route) => "purchases",
                    permission: (route) => "purchases_edit",
                    orderType: "purchases",
                },
            },
            {
                path: "purchases/create",
                component: () =>
                    import("../views/stock-management/purchases/Create.vue"),
                name: "admin.stock.purchases.create",
                meta: {
                    requireAuth: true,
                    menuParent: "purchases",
                    menuKey: (route) => "purchases",
                    permission: (route) => "purchases_create",
                    orderType: "purchases",
                },
            },
            {
                path: "purchases",
                component: () =>
                    import("../views/stock-management/purchases/index.vue"),
                name: "admin.stock.purchases.index",
                meta: {
                    requireAuth: true,
                    menuParent: "purchases",
                    menuKey: (route) => "purchases",
                    permission: (route) => "purchases_view",
                    orderType: "purchases",
                },
            },
            
            //inventory in            
            {
                path: "inventory-in/edit/:id",
                component: () =>
                    import("../views/stock-management/inventory/Edit.vue"),
                name: "admin.inventory_in.edit",
                meta: {
                    requireAuth: true,
                    menuParent: "stock_management",
                    menuKey: (route) => "inventory_in",
                    permission: (route) => "inventory_in_edit",
                    orderType: "inventory_in",
                },
            },
            {
                path: "inventory-in/create",
                component: () =>
                    import("../views/stock-management/inventory/Create.vue"),
                name: "admin.inventory_in.create",
                meta: {
                    requireAuth: true,
                    menuParent: "stock_management",
                    menuKey: (route) => "inventory_in",
                    permission: (route) => "inventory_in_create",
                    orderType: "inventory_in",
                },
            },
            {
                path: "inventory-in",
                component: () =>
                    import("../views/stock-management/inventory/index.vue"),
                name: "admin.inventory_in.index",
                meta: {
                    requireAuth: true,
                    menuParent: "stock_management",
                    menuKey: (route) => "inventory_in",
                    permission: (route) => "inventory_in_view",
                    orderType: "inventory_in",
                },
            },
            
            //registrasi barcode
            {
                path: "barcode-registration",
                component: () =>
                    import("../views/stock-management/barcode-registration/index.vue"),
                name: "admin.barcode_registration.index",
                meta: {
                    requireAuth: true,
                    menuParent: "stock_management",
                    menuKey: (route) => "barcode_registration",
                    permission: (route) => "barcode_registration_view",
                    orderType: "inventory_in",
                },
            },
            {
                path: "barcode-registration/:id",
                component: () =>
                    import("../views/stock-management/barcode-registration/index.vue"),
                name: "admin.barcode_registration.scan",
                meta: {
                    requireAuth: true,
                    menuParent: "stock_management",
                    menuKey: (route) => "barcode_registration",
                    permission: (route) => "barcode_registration_scan",
                    orderType: "inventory_in",
                },
            },
            
            //inventory out            
            {
                path: "inventory-out/edit/:id",
                component: () =>
                    import("../views/stock-management/inventory/Edit.vue"),
                name: "admin.inventory_out.edit",
                meta: {
                    requireAuth: true,
                    menuParent: "stock_management",
                    menuKey: (route) => "inventory_out",
                    permission: (route) => "inventory_out_edit",
                    orderType: "inventory_out",
                },
            },
            {
                path: "inventory-out/create",
                component: () =>
                    import("../views/stock-management/inventory/Create.vue"),
                name: "admin.inventory_out.create",
                meta: {
                    requireAuth: true,
                    menuParent: "stock_management",
                    menuKey: (route) => "inventory_out",
                    permission: (route) => "inventory_out_create",
                    orderType: "inventory_out",
                },
            },
            {
                path: "inventory-out",
                component: () =>
                    import("../views/stock-management/inventory/index.vue"),
                name: "admin.inventory_out.index",
                meta: {
                    requireAuth: true,
                    menuParent: "stock_management",
                    menuKey: (route) => "inventory_out",
                    permission: (route) => "inventory_out_view",
                    orderType: "inventory_out",
                },
            },

            // Purchase Returns
            {
                path: "purchase-returns/edit/:id",
                component: () =>
                    import("../views/stock-management/purchases/Edit.vue"),
                name: "admin.stock.purchase-returns.edit",
                meta: {
                    requireAuth: true,
                    menuParent: "purchases",
                    menuKey: (route) => "purchase_returns",
                    permission: (route) => "purchase_returns_edit",
                    orderType: "purchase-returns",
                },
            },
            {
                path: "purchase-returns/create",
                component: () =>
                    import("../views/stock-management/purchases/Create.vue"),
                name: "admin.stock.purchase-returns.create",
                meta: {
                    requireAuth: true,
                    menuParent: "purchases",
                    menuKey: (route) => "purchase_returns",
                    permission: (route) => "purchase_returns_create",
                    orderType: "purchase-returns",
                },
            },
            {
                path: "purchase-returns",
                component: () =>
                    import("../views/stock-management/purchases/index.vue"),
                name: "admin.stock.purchase-returns.index",
                meta: {
                    requireAuth: true,
                    menuParent: "purchases",
                    menuKey: (route) => "purchase_returns",
                    permission: (route) => "purchase_returns_view",
                    orderType: "purchase-returns",
                },
            },

            // Sales
            {
                path: "sales/edit/:id",
                component: () =>
                    import("../views/stock-management/purchases/Edit.vue"),
                name: "admin.stock.sales.edit",
                meta: {
                    requireAuth: true,
                    menuParent: "sales",
                    menuKey: (route) => "sales",
                    permission: (route) => "sales_edit",
                    orderType: "sales",
                },
            },
            {
                path: "sales/create",
                component: () =>
                    import("../views/stock-management/purchases/Create.vue"),
                name: "admin.stock.sales.create",
                meta: {
                    requireAuth: true,
                    menuParent: "sales",
                    menuKey: (route) => "sales",
                    permission: (route) => "sales_create",
                    orderType: "sales",
                },
            },
            {
                path: "sales",
                component: () =>
                    import("../views/stock-management/purchases/index.vue"),
                name: "admin.stock.sales.index",
                meta: {
                    requireAuth: true,
                    menuParent: "sales",
                    menuKey: (route) => "sales",
                    permission: (route) => "sales_view",
                    orderType: "sales",
                },
            },

            // Sales Returns
            {
                path: "sales-returns/edit/:id",
                component: () =>
                    import("../views/stock-management/purchases/Edit.vue"),
                name: "admin.stock.sales-returns.edit",
                meta: {
                    requireAuth: true,
                    menuParent: "sales",
                    menuKey: (route) => "sales_returns",
                    permission: (route) => "sales_returns_edit",
                    orderType: "sales-returns",
                },
            },
            {
                path: "sales-returns/create",
                component: () =>
                    import("../views/stock-management/purchases/Create.vue"),
                name: "admin.stock.sales-returns.create",
                meta: {
                    requireAuth: true,
                    menuParent: "sales",
                    menuKey: (route) => "sales_returns",
                    permission: (route) => "sales_returns_create",
                    orderType: "sales-returns",
                },
            },
            {
                path: "sales-returns",
                component: () =>
                    import("../views/stock-management/purchases/index.vue"),
                name: "admin.stock.sales-returns.index",
                meta: {
                    requireAuth: true,
                    menuParent: "sales",
                    menuKey: (route) => "sales_returns",
                    permission: (route) => "sales_returns_view",
                    orderType: "sales-returns",
                },
            },

            // Quotaiton/Estimate
            {
                path: "quotations/edit/:id",
                component: () =>
                    import("../views/stock-management/purchases/Edit.vue"),
                name: "admin.stock.quotations.edit",
                meta: {
                    requireAuth: true,
                    menuParent: "sales",
                    menuKey: (route) => "quotations",
                    permission: (route) => "quotations_edit",
                    orderType: "quotations",
                },
            },
            {
                path: "quotations/create",
                component: () =>
                    import("../views/stock-management/purchases/Create.vue"),
                name: "admin.stock.quotations.create",
                meta: {
                    requireAuth: true,
                    menuParent: "sales",
                    menuKey: (route) => "quotations",
                    permission: (route) => "quotations_create",
                    orderType: "quotations",
                },
            },
            {
                path: "quotations",
                component: () =>
                    import("../views/stock-management/purchases/index.vue"),
                name: "admin.stock.quotations.index",
                meta: {
                    requireAuth: true,
                    menuParent: "sales",
                    menuKey: (route) => "quotations",
                    permission: (route) => "quotations_view",
                    orderType: "quotations",
                },
            },

            // Online Orders
            {
                path: "online-orders",
                component: () =>
                    import("../views/stock-management/online-orders/index.vue"),
                name: "admin.online_orders.index",
                meta: {
                    requireAuth: true,
                    menuParent: "online_orders",
                    menuKey: "online_orders",
                    orderType: "online-orders",
                },
            },

            // Stock Transfer
            {
                path: "stock-transfers/edit/:id",
                component: () =>
                    import("../views/stock-management/purchases/Edit.vue"),
                name: "admin.stock.stock-transfers.edit",
                meta: {
                    requireAuth: true,
                    menuParent: "stock_transfer",
                    menuKey: (route) => "stock_transfer",
                    permission: (route) => "stock_transfers_edit",
                    orderType: "stock-transfers",
                },
            },
            {
                path: "stock-transfers/create",
                component: () =>
                    import("../views/stock-management/purchases/Create.vue"),
                name: "admin.stock.stock-transfers.create",
                meta: {
                    requireAuth: true,
                    menuParent: "stock_transfer",
                    menuKey: (route) => "stock_transfer",
                    permission: (route) => "stock_transfers_create",
                    orderType: "stock-transfers",
                },
            },
            {
                path: "stock-transfers",
                component: () =>
                    import(
                        "../views/stock-management/stock-transfer/index.vue"
                    ),
                name: "admin.stock.stock-transfers.index",
                meta: {
                    requireAuth: true,
                    menuParent: "stock_transfer",
                    menuKey: (route) => "stock_transfer",
                    permission: (route) => "stock_transfers_view",
                    orderType: "stock-transfers",
                },
            },
        ],
    },
    {
        path: "/admin/payment/",
        component: () => import("../../common/layouts/Admin.vue"),
        children: [
            {
                path: "in",
                component: () =>
                    import("../views/stock-management/payments/index.vue"),
                name: "admin.payments.in",
                meta: {
                    requireAuth: true,
                    menuParent: "sales",
                    menuKey: "payment_in",
                    permission: "payment_in_view",
                    paymentType: "in",
                },
            },
            {
                path: "out",
                component: () =>
                    import("../views/stock-management/payments/index.vue"),
                name: "admin.payments.out",
                meta: {
                    requireAuth: true,
                    menuParent: "purchases",
                    menuKey: "payment_out",
                    permission: "payment_out_view",
                    paymentType: "out",
                },
            },
        ],
    },
];
