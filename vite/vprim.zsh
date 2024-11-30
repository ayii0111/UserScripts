#! /bin/zsh
# 別名 vprim: 快速安裝配置 primevue
# 基礎安裝
(
  checkNoInst primevue || return 1
  # ------------------------------ primevue 核心、主題、自動匯入 ------------------------------
  npm i primevue
  npm i @primevue/themes
  npm i unplugin-vue-components -D
  npm i @primevue/auto-import-resolver -D

  local mainImp="import PrimeVue from 'primevue/config';
import Aura from '@primevue/themes/aura';
"
  local mainAppUse="app.use(PrimeVue, {
  // Default theme configuration
  theme: {
    preset: Aura,
    options: {
      // 設定主題所屬 css變數、class 的前綴
      // 例如 --p-primary-color
      prefix: 'p',
      // 深色模式隨瀏覽器決定
      darkModeSelector: 'system',
      cssLayer: {
        name: 'primevue',
        order: 'tailwind-base, primevue, tailwind-utilities'
      }
    }
  }
})
"
  insertMainfile $mainImp $mainAppUse

  local file=""
  file=$(matchFile "./vite.config") || return 1
  # 在 export那一行前面的區塊的空行全部刪除，以及有著 https:的默認註解也刪除
  # 在 export那一行，的前面插入 import...代碼還有兩個空行
  gsed -i "/^export/,\$! {/^$/d; /https:/d}
0,/export/{// s|^|import { PrimeVueResolver } from '@primevue/auto-import-resolver'\n\n\n|}; " $file

  local insertComp="    Components({
      resolvers: [
        PrimeVueResolver(),
      ],"
  insertComp=$(echo "$insertComp" | gsed ':a;N;$!ba;s/\n/\\n/g')

  gsed -i "/Components({/ s|Components({|$insertComp|" $file

  local button=''
  button='   <Button label="主題測試 \& tw覆蓋測試" severity="help" class="p-8" /><br><br>'
  gsed -i "/  <div>/ s|  <div>|  <div>\n$button|" src/views/HomeView.vue

  button='   <Button label="tailwindcss-primeui 樣式測試" class="bg-emphasis border-surface " /><br><br>'
  gsed -i "/  <div>/ s|  <div>|  <div>\n$button|" src/views/HomeView.vue

  # ------------------------------ 整合 tailwindcss ------------------------------

  vtail # 安裝並配置基礎 tailwind
  npm i tailwindcss-primeui

  cat <<EOF >tailwind.config.js
/** @type {import('tailwindcss').Config} */
import twPrimeui from "tailwindcss-primeui"
export default {
  content: [
    "./index.html",
    "./src/**/*.{vue,js,ts,jsx,tsx}",
  ],
  theme: {
    extend: {},
  },
  plugins: [twPrimeui],
}

EOF

  cat <<EOF >postcss.config.js
export default {
  plugins: {
    tailwindcss: {},
    autoprefixer: {}
  }
}
EOF

  mkdir -p src/assets
  cat <<EOF >src/assets/tw.css
@layer tailwind-base, primevue, tailwind-utilities;

@layer tailwind-base {
  @tailwind base;
}

@layer tailwind-utilities {
  @tailwind components;
  @tailwind utilities;
}
EOF
)
