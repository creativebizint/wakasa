// vite.config.js
import { defineConfig } from "file:///C:/xampp4/htdocs/wakasa6/node_modules/vite/dist/node/index.js";
import laravel from "file:///C:/xampp4/htdocs/wakasa6/node_modules/laravel-vite-plugin/dist/index.js";
import vue from "file:///C:/xampp4/htdocs/wakasa6/node_modules/@vitejs/plugin-vue/dist/index.mjs";
import Components from "file:///C:/xampp4/htdocs/wakasa6/node_modules/unplugin-vue-components/dist/vite.mjs";
import { AntDesignVueResolver } from "file:///C:/xampp4/htdocs/wakasa6/node_modules/unplugin-vue-components/dist/resolvers.mjs";
var vite_config_default = defineConfig({
  plugins: [
    laravel({
      input: ["resources/js/app.js"]
    }),
    vue({
      template: {
        transformAssetUrls: {
          base: null,
          includeAbsolute: false
        }
      }
    }),
    Components({
      resolvers: [
        AntDesignVueResolver({
          importStyle: false
          // css in js
        })
      ]
    })
  ],
  // build: {
  //     // chunkSizeWarningLimit: 900000,
  //     rollupOptions: {
  //         output: {
  //             entryFileNames: `assets/[name].js`,
  //             chunkFileNames: function (file) {
  //                 return `assets/[name].js`;
  //             },
  //             assetFileNames: (assetInfo) => {
  //                 return `assets/[name][extname]`;
  //             },
  //             manualChunks: {
  //                 ant_design_vue: ["ant-design-vue"],
  //             },
  //         },
  //     },
  // },
  server: {
    hmr: {
      host: "localhost"
    },
    cors: true
  }
});
export {
  vite_config_default as default
};
//# sourceMappingURL=data:application/json;base64,ewogICJ2ZXJzaW9uIjogMywKICAic291cmNlcyI6IFsidml0ZS5jb25maWcuanMiXSwKICAic291cmNlc0NvbnRlbnQiOiBbImNvbnN0IF9fdml0ZV9pbmplY3RlZF9vcmlnaW5hbF9kaXJuYW1lID0gXCJDOlxcXFx4YW1wcDRcXFxcaHRkb2NzXFxcXHdha2FzYTZcIjtjb25zdCBfX3ZpdGVfaW5qZWN0ZWRfb3JpZ2luYWxfZmlsZW5hbWUgPSBcIkM6XFxcXHhhbXBwNFxcXFxodGRvY3NcXFxcd2FrYXNhNlxcXFx2aXRlLmNvbmZpZy5qc1wiO2NvbnN0IF9fdml0ZV9pbmplY3RlZF9vcmlnaW5hbF9pbXBvcnRfbWV0YV91cmwgPSBcImZpbGU6Ly8vQzoveGFtcHA0L2h0ZG9jcy93YWthc2E2L3ZpdGUuY29uZmlnLmpzXCI7aW1wb3J0IHsgZGVmaW5lQ29uZmlnIH0gZnJvbSBcInZpdGVcIjtcclxuaW1wb3J0IGxhcmF2ZWwgZnJvbSBcImxhcmF2ZWwtdml0ZS1wbHVnaW5cIjtcclxuaW1wb3J0IHZ1ZSBmcm9tIFwiQHZpdGVqcy9wbHVnaW4tdnVlXCI7XHJcbmltcG9ydCBDb21wb25lbnRzIGZyb20gXCJ1bnBsdWdpbi12dWUtY29tcG9uZW50cy92aXRlXCI7XHJcbmltcG9ydCB7IEFudERlc2lnblZ1ZVJlc29sdmVyIH0gZnJvbSBcInVucGx1Z2luLXZ1ZS1jb21wb25lbnRzL3Jlc29sdmVyc1wiO1xyXG5cclxuZXhwb3J0IGRlZmF1bHQgZGVmaW5lQ29uZmlnKHtcclxuICAgIHBsdWdpbnM6IFtcclxuICAgICAgICBsYXJhdmVsKHtcclxuICAgICAgICAgICAgaW5wdXQ6IFtcInJlc291cmNlcy9qcy9hcHAuanNcIl0sXHJcbiAgICAgICAgfSksXHJcbiAgICAgICAgdnVlKHtcclxuICAgICAgICAgICAgdGVtcGxhdGU6IHtcclxuICAgICAgICAgICAgICAgIHRyYW5zZm9ybUFzc2V0VXJsczoge1xyXG4gICAgICAgICAgICAgICAgICAgIGJhc2U6IG51bGwsXHJcbiAgICAgICAgICAgICAgICAgICAgaW5jbHVkZUFic29sdXRlOiBmYWxzZSxcclxuICAgICAgICAgICAgICAgIH0sXHJcbiAgICAgICAgICAgIH0sXHJcbiAgICAgICAgfSksXHJcbiAgICAgICAgQ29tcG9uZW50cyh7XHJcbiAgICAgICAgICAgIHJlc29sdmVyczogW1xyXG4gICAgICAgICAgICAgICAgQW50RGVzaWduVnVlUmVzb2x2ZXIoe1xyXG4gICAgICAgICAgICAgICAgICAgIGltcG9ydFN0eWxlOiBmYWxzZSwgLy8gY3NzIGluIGpzXHJcbiAgICAgICAgICAgICAgICB9KSxcclxuICAgICAgICAgICAgXSxcclxuICAgICAgICB9KSxcclxuICAgIF0sXHJcbiAgICAvLyBidWlsZDoge1xyXG4gICAgLy8gICAgIC8vIGNodW5rU2l6ZVdhcm5pbmdMaW1pdDogOTAwMDAwLFxyXG4gICAgLy8gICAgIHJvbGx1cE9wdGlvbnM6IHtcclxuICAgIC8vICAgICAgICAgb3V0cHV0OiB7XHJcbiAgICAvLyAgICAgICAgICAgICBlbnRyeUZpbGVOYW1lczogYGFzc2V0cy9bbmFtZV0uanNgLFxyXG4gICAgLy8gICAgICAgICAgICAgY2h1bmtGaWxlTmFtZXM6IGZ1bmN0aW9uIChmaWxlKSB7XHJcbiAgICAvLyAgICAgICAgICAgICAgICAgcmV0dXJuIGBhc3NldHMvW25hbWVdLmpzYDtcclxuICAgIC8vICAgICAgICAgICAgIH0sXHJcbiAgICAvLyAgICAgICAgICAgICBhc3NldEZpbGVOYW1lczogKGFzc2V0SW5mbykgPT4ge1xyXG4gICAgLy8gICAgICAgICAgICAgICAgIHJldHVybiBgYXNzZXRzL1tuYW1lXVtleHRuYW1lXWA7XHJcbiAgICAvLyAgICAgICAgICAgICB9LFxyXG4gICAgLy8gICAgICAgICAgICAgbWFudWFsQ2h1bmtzOiB7XHJcbiAgICAvLyAgICAgICAgICAgICAgICAgYW50X2Rlc2lnbl92dWU6IFtcImFudC1kZXNpZ24tdnVlXCJdLFxyXG4gICAgLy8gICAgICAgICAgICAgfSxcclxuICAgIC8vICAgICAgICAgfSxcclxuICAgIC8vICAgICB9LFxyXG4gICAgLy8gfSxcclxuICAgIHNlcnZlcjoge1xyXG4gICAgICAgIGhtcjoge1xyXG4gICAgICAgICAgICBob3N0OiBcImxvY2FsaG9zdFwiLFxyXG4gICAgICAgIH0sXHJcbiAgICAgICAgY29yczogdHJ1ZSxcclxuICAgIH0sXHJcbn0pO1xyXG4iXSwKICAibWFwcGluZ3MiOiAiO0FBQWtRLFNBQVMsb0JBQW9CO0FBQy9SLE9BQU8sYUFBYTtBQUNwQixPQUFPLFNBQVM7QUFDaEIsT0FBTyxnQkFBZ0I7QUFDdkIsU0FBUyw0QkFBNEI7QUFFckMsSUFBTyxzQkFBUSxhQUFhO0FBQUEsRUFDeEIsU0FBUztBQUFBLElBQ0wsUUFBUTtBQUFBLE1BQ0osT0FBTyxDQUFDLHFCQUFxQjtBQUFBLElBQ2pDLENBQUM7QUFBQSxJQUNELElBQUk7QUFBQSxNQUNBLFVBQVU7QUFBQSxRQUNOLG9CQUFvQjtBQUFBLFVBQ2hCLE1BQU07QUFBQSxVQUNOLGlCQUFpQjtBQUFBLFFBQ3JCO0FBQUEsTUFDSjtBQUFBLElBQ0osQ0FBQztBQUFBLElBQ0QsV0FBVztBQUFBLE1BQ1AsV0FBVztBQUFBLFFBQ1AscUJBQXFCO0FBQUEsVUFDakIsYUFBYTtBQUFBO0FBQUEsUUFDakIsQ0FBQztBQUFBLE1BQ0w7QUFBQSxJQUNKLENBQUM7QUFBQSxFQUNMO0FBQUE7QUFBQTtBQUFBO0FBQUE7QUFBQTtBQUFBO0FBQUE7QUFBQTtBQUFBO0FBQUE7QUFBQTtBQUFBO0FBQUE7QUFBQTtBQUFBO0FBQUE7QUFBQTtBQUFBLEVBa0JBLFFBQVE7QUFBQSxJQUNKLEtBQUs7QUFBQSxNQUNELE1BQU07QUFBQSxJQUNWO0FBQUEsSUFDQSxNQUFNO0FBQUEsRUFDVjtBQUNKLENBQUM7IiwKICAibmFtZXMiOiBbXQp9Cg==
