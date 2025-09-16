export default [
    {
        path: "/",
        component: () => import("../../common/layouts/Admin.vue"),
        children: [
            {
                path: "/admin/brands",
                component: () =>
                    import("../views/product-manager/brands/index.vue"),
                name: "admin.brands.index",
                meta: {
                    requireAuth: true,
                    menuParent: "product_manager",
                    menuKey: (route) => "brands",
                    permission: "brands_view",
                },
            },
            {
                path: "/admin/parts",
                component: () =>
                    import("../views/product-manager/parts/index.vue"),
                name: "admin.parts.index",
                meta: {
                    requireAuth: true,
                    menuParent: "product_manager",
                    menuKey: (route) => "parts",
                    permission: "parts_view",
                },
            },
            {
                path: "/admin/qrcode",
                component: () =>
                    import("../views/product-manager/barcode/index.vue"),
                name: "admin.barcode.index",
                meta: {
                    requireAuth: true,
                    menuParent: "product_manager",
                    menuKey: (route) => "barcode",
                    permission: "barcode_view",
                },
            },
            {
                path: "/admin/categories",
                component: () =>
                    import("../views/product-manager/categories/index.vue"),
                name: "admin.categories.index",
                meta: {
                    requireAuth: true,
                    menuParent: "product_manager",
                    menuKey: (route) => "categories",
                    permission: "categories_view",
                },
            },
            {
                path: "/admin/products",
                component: () =>
                    import("../views/product-manager/products/index.vue"),
                name: "admin.products.index",
                meta: {
                    requireAuth: true,
                    menuParent: "app_configuration",
                    menuKey: (route) => "products",
                    permission: "products_view",
                },
            },
            
            {
                path: "/admin/uom",
                component: () =>
                    import("../views/product-manager/uom/index.vue"),
                name: "admin.uom.index",
                meta: {
                    requireAuth: true,
                    menuParent: "app_configuration",
                    menuKey: (route) => "uom",
                    permission: "products_view",
                },
            },
            
            {
                path: '/admin/stock-listing',
                component: () =>
                    import("../views/product-manager/stock-listing/index.vue"),
                name: 'admin.stock_listing.index',
                meta: {
                    requireAuth: true,
                    menuParent: "master",
                    menuKey: (route) => "stock_listing",
                    permission: "stock_listings_view",
                }
            },
            {
                path: '/admin/placement-listing',
                component: () =>
                    import("../views/product-manager/placement-listing/index.vue"),
                name: 'admin.placement_listing.index',
                meta: {
                    requireAuth: true,
                    menuParent: "master",
                    menuKey: (route) => "placement_listing",
                    permission: "placement_listings_view",
                }
            },
            {
                path: "/admin/variations",
                component: () =>
                    import("../views/product-manager/variations/index.vue"),
                name: "admin.variations.index",
                meta: {
                    requireAuth: true,
                    menuParent: "product_manager",
                    menuKey: (route) => "variations",
                    permission: "products_view",
                },
            },
            {
                path: "/admin/print-barcode",
                component: () =>
                    import("../views/product-manager/print-barcode/index.vue"),
                name: "admin.print_barcode.index",
                meta: {
                    requireAuth: true,
                    menuParent: "product_manager",
                    menuKey: (route) => "print_barcodes",
                    permission: "products_view",
                },
            },
            
            //additional
            {
                path: '/admin/floors',
                component: () =>
                    import('../views/product-manager/floors/index.vue'),
                name: 'admin.floors.index',
                meta: {
                    requireAuth: true,
                    menuParent: "shelf",
                    menuKey: (route) => "floors",
                    permission: "floors_view",
                }
            },
            {
                path: '/admin/rows',
                component: () =>
                    import('../views/product-manager/rows/index.vue'),
                name: 'admin.rows.index',
                meta: {
                    requireAuth: true,
                    menuParent: "shelf",
                    menuKey: (route) => "rows",
                    permission: "rows_view",
                }
            },
            
            {
                path: '/admin/shelf-groups',
                component: () =>
                    import('../views/product-manager/shelfgroups/index.vue'),
                name: 'admin.shelfGroups.index',
                meta: {
                    requireAuth: true,
                    menuParent: "shelf",
                    menuKey: (route) => "shelfgroups",
                    permission: "shelf_groups_view",
                }
            },
            
            {
                path: '/admin/shelf-numbers',
                component: () =>
                    import('../views/product-manager/shelfnumbers/index.vue'),
                name: 'admin.shelfNumbers.index',
                meta: {
                    requireAuth: true,
                    menuParent: "shelf",
                    menuKey: (route) => "shelfnumbers",
                    permission: "shelf_numbers_view",
                }
            },
            
//            {
//                path: '/admin/stock-management/in',
//                component: ()=>
//                import('../views/stock-management/product-placement/in.vue'),
//                name: 'admin.stock_management.in',
//                meta: {
//                    requireAuth: true,
//                    menuParent: "stock_management",
//                    menuKey: route => "stock_management_in",
//                    permission: "stock_managements_view",
//                }
//            },
//            {
//                path: '/admin/stock-management/out',
//                component: ()=>
//                import('../views/stock-management/product-placement/out.vue'),
//                name: 'admin.stock_management.out',
//                meta: {
//                    requireAuth: true,
//                    menuParent: "stock_management",
//                    menuKey: route => "stock_management_out",
//                    permission: "stock_managements_view",
//                }
//            },
            
//            {
//                path: '/admin/stock-management',
//                component: () =>
//                    import('../views/stock-management/product-placement/index.vue'),
//                name: 'admin.stock_management.index',
//                meta: {
//                    requireAuth: true,
//                    menuParent: "stock_management",
//                    menuKey: route => "product_placement",
//                    permission: "stock_managements_view",
//                }
//            },
//            {
//                path: '/admin/stock-management/in-history',
//                component:  () =>
//                    import('../views/stock-management/product-placement/in_history.vue'),
//                name: 'admin.stock_management.in_history',
//                meta: {
//                    requireAuth: true,
//                    menuParent: "stock_management",
//                    menuKey: route => "in_history",
//                    permission: "products_view",
//                }
//            },
//            {
//                path: '/admin/stock-management/out-history',
//                component:  () =>
//                    import('../views/stock-management/product-placement/out_history.vue'),
//                name: 'admin.stock_management.out_history',
//                meta: {
//                    requireAuth: true,
//                    menuParent: "order_fullfillment",
//                    menuKey: route => "out_history",
//                    permission: "products_view",
//                }
//            },
            
            {
                path: '/admin/order-fullfillment/picking-request',
                component:  () =>
                    import('../views/order-fullfillment/picking-request/index.vue'),
                name: 'admin.order_fullfillment.picking_request',
                meta: {
                    requireAuth: true,
                    menuParent: "order_fullfillment",
                    menuKey: (route) => "picking_request",
                    permission: (route) => "order_fullfillment_view",
                    orderType: "inventory_out",
                }
            },
            {
                path: '/admin/order-fullfillment/picking-assignment',
                component:  () =>
                    import('../views/order-fullfillment/picking-assignment/index.vue'),
                name: 'admin.order_fullfillment.picking_assignment',
                meta: {
                    requireAuth: true,
                    menuParent: "order_fullfillment",
                    menuKey: (route) => "picking_assignment",
                    permission: (route) => "order_fullfillment_view",
                    orderType: "inventory_out",
                }
            },
            
            {
                path: '/admin/order-fullfillment/qc-picking',
                component:  () =>
                    import('../views/order-fullfillment/qc-picking/index.vue'),
                name: 'admin.order_fullfillment.qc_picking',
                meta: {
                    requireAuth: true,
                    menuParent: "order_fullfillment",
                    menuKey: (route) => "qc_picking",
                    permission: (route) => "order_fullfillment_view",
                    orderType: "inventory_out",
                }
            },
            
            {
                path: '/admin/order-fullfillment/picking-assignment/:id',
                component:  () =>
                    import('../views/order-fullfillment/picking-assignment-per-so/index.vue'),
                name: 'admin.order_fullfillment.picking_assignment_so',
                meta: {
                    requireAuth: true,
                    menuParent: "order_fullfillment",
                    menuKey: (route) => "picking_assignment_so",
                    permission: (route) => "order_fullfillment_view",
                    orderType: "inventory_out",
                }
            },
            
            {
                path: '/admin/warehouse',
                component: () =>
                    import('../views/product-manager/warehouses/index.vue'),
                name: 'admin.warehouses.index',
                meta: {
                    requireAuth: true,
                    menuParent: "app_configuration",
                    menuKey: route => "warehouses",
                    permission: "warehouses_view",
                }
            },
            
        ],
    },
];
