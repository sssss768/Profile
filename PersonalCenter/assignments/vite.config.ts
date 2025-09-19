import { defineConfig } from 'vite'
import { resolve } from 'path';
import vue from '@vitejs/plugin-vue'

export default defineConfig({
  plugins: [vue()],
  server: {
    host : '0.0.0.0',
    port : 7000,
    proxy: {
      '/api': {
        target: 'http://localhost:8080', 
        changeOrigin: true, // 是否改变域名
        rewrite: (path) => path.replace(/^\/api/, '') // 路径重写
      }
    }
  },
  resolve: {
    alias: {
      "@": resolve(__dirname, "./src"),
    }
  },
})
