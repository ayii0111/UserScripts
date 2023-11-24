#! /bin/zsh

# 別名 vlodash
# 可以安裝 lodash 與其型別，還有 lodash 不需要的函式
(
  checkNoInst lodash-es || return 1
  npm i lodash-es

  # 安裝型別
  npm i -D @types/lodash-es

  # ------------------------------ vite.config 修改 ------------------------------
  # 以下為 auto-import 的配置
  local autoImportConfig=",
        {'lodash-es': ['cloneDeep', 'camelCase', 'isPlainObject', 'merge']}"

  autoImportConfig=$(echo "$autoImportConfig" | gsed ':a;N;$!ba;s/\n/\\n/g')
  for file in ./vite.config.{t,j}s; do
    if [[ -f $file ]]; then
      # 在搜尋時，若有[] 需轉譯
      sed -i "/imports: \[/,/\]/ s/\]$/,$autoImportConfig]/" "$file"
    fi
  done

  # ------------------------------ package.json 修改 ------------------------------
  # 檢查是否存在 package.json
  if [[ ! -f package.json ]]; then
    echo "package.json 文件不存在，請檢查後重試。"
    return 1
  fi

  # 讀取當前的 type 屬性值
  current_type=$(gsed -n 's/.*"type"[ ]*:[ ]*"\(.*\)".*/\1/p' package.json | head -n 1)

  # 檢查是否有找到 type 屬性
  if [[ -z "$current_type" ]]; then
    # 若不存在，則新增 type: "module"
    gsed -i '1,/\{/s/\{/\{\n  "type": "module",/' package.json
  else
    # 若存在且不是 'module'，則輸出當前值並詢問是否覆蓋
    if [[ "$current_type" != "module" ]]; then
      echo "當前 'type' 值為: $current_type"
      read -p "是否要覆蓋為 'module'？ (y/n): " answer
      if [[ "$answer" == "y" ]]; then
        gsed -i 's/"type"[ ]*:[ ]*"[^"]*"/"type": "module"/' package.json
        echo "'type' 屬性已更新為 'module'。"
      else
        echo "保留當前的 'type' 值：$current_type"
      fi
    fi
  fi

  unset eslintImport eslintPluginConfig autoImportConfig
)
