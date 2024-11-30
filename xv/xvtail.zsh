#! /bin/zsh
(
  # checkNoInst tailwindcss || return 1
  npm i -D tailwindcss postcss autoprefixer

  cat <<EOF >tailwind.config.js
/** @type {import('tailwindcss').Config} */
export default {
  content: [
    "./index.html",
    "./src/**/*.{vue,js,ts,jsx,tsx}",
  ],
  theme: {
    extend: {},
  },
  plugins: [],
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

  local file=""
  [[ ! -f src/assets/tw.css ]] && {

    mkdir -p public/assets
    cat <<EOF >public/assets/tw.css
@tailwind base;
@tailwind components;
@tailwind utilities;
EOF

    local twInsert="import '../public/assets/tw.css'"
    gsed -i "/createApp(Popup)/,\$! {/^$/d}
0,/createApp(Popup)/{// s|^|$twInsert\n\n\n|}" src/popup.ts
  }

  file=$(matchFile vite.config) || return 1

  local locate='export default defineConfig'
  local insertSnippet="import tailwindcss from 'tailwindcss'
import autoprefixer from 'autoprefixer'"

  insertSnippet=$(gsedWrapPreproc $insertSnippet)
  gsed -i "/^$/ d" $file
  gsed -i "
0,/$locate/ {// s|^|$insertSnippet\n\n|}
" $file

  insertSnippet='
  css: {
    postcss: {
      plugins: [tailwindcss, autoprefixer]
    }
  },'

  # 用來處理要插入多行時，行末需改為 \\n 的問題
  insertSnippet=$(gsedWrapPreproc $insertSnippet)
  gsed -i "
0,/$locate/ {// s|$|$insertSnippet|}
" $file

  local button='  <button class="bg-blue-500 hover:bg-blue-700 text-white font-bold py-2 px-4 rounded">Button</button><br><br>'
  gsed -i "/  <div>/ s|  <div>|  <div>\n$button|" src/pages/Home.vue

)
