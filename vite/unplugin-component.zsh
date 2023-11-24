#! /bin/zsh

# 別名 vcomp
# 安裝並配置 unplugin-vue-components
npm i unplugin-vue-components -D


local _import="import Components from 'unplugin-vue-components/vite'
import { ElementPlusResolver } from 'unplugin-vue-components/resolvers'"

_import=$(echo "$_import" | gsed ':a;N;$!ba;s/\n/\\n/g')

local file=$(getMatchedFile "./vite.config")
if [[ ! $file ]] return 1


# 在 export那一行前面的區塊的空行全部刪除，以及有著 https:的默認註解也刪除
# 在 export那一行，的前面插入 import...代碼還有兩個空行
gsed -i "/^export/,\$! {/^$/d; /https:/d}; 0,/export/{// s|^|$_import\n\n\n|};" $file

local Components="
  Components({
		dirs: ['src/components', 'src/views'],
    resolvers: [ElementPlusResolver()],
    dts: true,
    include: [/\.vue$/, /\.vue\?vue/, /\.md$/]
  }),"

Components=$(echo "$Components" | gsed ':a;N;$!ba;s/\n/\\n/g')

gsed -i "/vue()/ s|vue()|vue(),$Components|" $file


unset _import Components file