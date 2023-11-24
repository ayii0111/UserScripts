#! /bin/zsh

# 別名 vtail
# tailwind 快速安裝配置
(
  checkNoInst tailwindcss || return 1
  npm i -D tailwindcss postcss autoprefixer

  # 由於 \' 沒有轉義效果，只能使用 '"'"'
  echo '/** @type {import('"'"'tailwindcss'"'"').Config} */
export default {
  content: [
    "./index.html",
    "./src/**/*.{vue,js,ts,jsx,tsx}",
  ],
  theme: {
    extend: {},
  },
  plugins: [],
}' >tailwind.config.js

  echo 'export default {
  plugins: {
    tailwindcss: {},
    autoprefixer: {}
  }
}' >postcss.config.js

  echo '@tailwind base;
@tailwind components;
@tailwind utilities;' >./src/assets/tw.css

  gsed -i "/^$/ d" vite.config.ts

  local locate='export default defineConfig'
  local insertSnippet="import tailwindcss from 'tailwindcss'
import autoprefixer from 'autoprefixer'"
  insertSnippet=$(echo "$insertSnippet" | gsed ':a;N;$!ba;s|\n|\\n|g')
  gsed -i "
0,/$locate/ {// s|^|$insertSnippet\n\n|}
" vite.config.ts

  insertSnippet='
  css: {
    postcss: {
      plugins: [tailwindcss, autoprefixer]
    }
  },'

  # 用來處理要插入多行時，行末需改為 \\n 的問題
  insertSnippet=$(echo "$insertSnippet" | gsed ':a;N;$!ba;s|\n|\\n|g')
  gsed -i "
0,/$locate/ {// s|$|$insertSnippet|}
" vite.config.ts

  locate='createApp(App)'
  insertSnippet="import './assets/tw.css'"
  gsed -i "/^$/ d" src/main.ts
  gsed -i "
0,/$locate/ {// s|^|$insertSnippet\n\n\n|}
" src/main.ts

  local button='  <button class="bg-blue-500 hover:bg-blue-700 text-white font-bold py-2 px-4 rounded">Button</button>'
  gsed -i "/<template>/ s|$|\n$button|" src/views/HomeView.vue

  unset locate insertSnippet button
)
