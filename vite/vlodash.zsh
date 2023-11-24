#! /bin/zsh

# 別名 vlodash
# 可以安裝 lodash 與其型別，還有 lodash 不需要的函式
npm i lodash-es

# 安裝型別
npm i -D @types/lodash-es

# lodash廢棄判斷插件
# npm i -D eslint-plugin-you-dont-need-lodash-underscore


# 下面兩種格式，可以透過路徑展開匹配，就不需要使用 if 判斷式了
# 適用於 flat 新式 eslint 設定檔的標準格式
# local eslintImport="import { udnLodash } from 'eslint-plugin-you-dont-need-lodash-underscore'"
# gsed -i "/^$/ d" eslint.config*
# gsed -i "0,/export default/ {// s|^|$eslintImport\n\n|}" eslint.config.*
# local eslintPluginConfig="
#   {
#     ...udnLodash
#   },"
# eslintPluginConfig=$(echo "$eslintPluginConfig" | gsed ':a;N;$!ba;s/\n/\\n/g')
# gsed -i "0,/^  },/ {// s|$|$eslintPluginConfig|}" eslint.config.*


# 適用於舊式 eslint 設定檔
# eslintPluginConfig=",
#     'plugin:you-dont-need-lodash-underscore/compatible'"

# eslintPluginConfig=$(echo "$eslintPluginConfig" | gsed ':a;N;$!ba;s/\n/\\n/g')
# gsed -i "/extends*.: /,$ { 0,/'$/ {// s|$|$eslintPluginConfig|}}" ./.eslintrc.*





# 以下為 auto-import 的配置
local autoImportConfig=",
        {'lodash-es': ['cloneDeep', 'camelCase', 'isPlainObject', 'merge']}"

autoImportConfig=$(echo "$autoImportConfig" | gsed ':a;N;$!ba;s/\n/\\n/g')
for file (./vite.config.{t,j}s) {
  if [[ -f $file ]] {
  # 在搜尋時，若有[] 需轉譯
  gsed -i "/imports: \[/,$ { 0,/\}$/ {// s|$|$autoImportConfig|}}" $file
  }
}


unset eslintImport eslintPluginConfig autoImportConfig