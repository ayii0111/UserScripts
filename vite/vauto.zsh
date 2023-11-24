#! /bin/zsh

# 別名 vauto: 快速安裝配置 unplugin-auto-import

checkNoInst unplugin-auto-import || return 1
npm i -D unplugin-auto-import

local file=""
file=$(matchFile "./vite.config") || return 1
# 在 export那一行前面的區塊的空行全部刪除，以及有著 https:的默認註解也刪除
# 在 export那一行，的前面插入 import...代碼還有兩個空行
gsed -i "/^export/,\$! {/^$/d; /https:/d}
0,/export/{// s|^|import AutoImport from 'unplugin-auto-import/vite'\n\n\n|}; " $file

local auto_import1="
AutoImport({
  include: [
    /\.[tj]sx?$/,
    /\.vue$/,
    /\.vue\?vue/,
    /\.md$/,
  ],

  imports: [
    'vue',
    'vue-router',
		// 需在安裝 vueuse 後，才能解開下面註解
		// '@vueuse/core',

		// 引入型別模組
    {
      from: 'vue-router',
      imports: ['RouteLocationRaw'],
      type: true,
    }
  ],

  defaultExportByFilename: false,
  dts: './auto-imports.d.ts',
  vueTemplate: false,
  injectAtEnd: true,

  eslintrc: {
    enabled: false,
    filepath: './.eslintrc-auto-import.json',
    globalsPropValue: true,
  },
})"

# 可避免字串變數中的換行，造成 gsed 無法寫入
auto_import1=$(echo "$auto_import1" | gsed ':a;N;$!ba;s/\n/\\n/g')

gsed -i "/vue()/ s|vue()|vue(),$auto_import1|" $file

# tsconfig.app.json 檔添加項目
gsed -i '/include/,$ { 0,/]/{// s|]|, "./auto-imports.d.ts"]|} }' ./tsconfig.app.json

# .eslintrc.cjs 添加項目
local auto_import2=",
    './eslintrc-auto-import.json'"

auto_import2=$(echo "$auto_import2" | gsed ':a;N;$!ba;s/\n/\\n/g')
gsed -i "/extends*.: /,$ { 0,/'$/ {// s|$|$auto_import2|}}" ./.eslintrc.cjs
unset auto_import2 file auto_import1
# 背景執行 相當於 npm run dev 的指令效果
npx vite --no-open >/dev/null &
# 等待兩秒來啟動相關配置後，在將背景執行的 npr dev 結束
sleep 2
kill -9 %+

# 執行 npm run dev 產生 auto-imports.d.ts檔
# npm run dev > /dev/null  &

# echo '行直接執行下面預設的指令「kill -9 %2」，來結束 npr dev 的預執行'
# print -z 'kill -9 %2'
