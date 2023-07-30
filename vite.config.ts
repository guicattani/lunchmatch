import { defineConfig } from 'vite'
import RubyPlugin from 'vite-plugin-ruby'
import ViteReact from '@vitejs/plugin-react'
import WindiCSS from 'vite-plugin-windicss'
import FullReload from "vite-plugin-full-reload";

export default defineConfig({
  plugins: [
    RubyPlugin(),
    ViteReact(),
    WindiCSS({
      root: __dirname,
      scan: {
        fileExtensions: ['erb', 'html', 'vue', 'jsx', 'tsx'], // and maybe haml
        dirs: ['app/views', 'app/frontend'], // or app/javascript
      },
    }),
    FullReload(["app/views/**/*.erb"]),
  ],
})
