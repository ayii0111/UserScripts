#! /bin/zsh

# 別名 insertMainfile: 將代碼片段插入到 main 檔
# insertMainfile <import代碼段> <app.use代碼段>

# 先確認專案的 main.ts 是否存在 or 確認 main.js 是否存在
(
  local mainFile
  [[ -f "src/main.ts" ]] && mainFile="src/main.ts"
  [[ -f "src/main.js" ]] && mainFile="src/main.js"
  ! [[ -f "src/main.ts" || -f "src/main.js" ]] && echo "Error: main 檔不存在" >&2 && return 1

  # 若存在再確認 其中的 const app = createApp(App) 和 app.mount('#app') 兩行代碼是否存在
  if ! (grep -q "const app = createApp(App)" "$mainFile" && grep -q "app.mount('#app')" "$mainFile"); then
    echo "Error: main 檔中缺少 const app = createApp(App) 或 app.mount('#app')" >&2
    return 1
  fi

  local importSnippet=$(echo "$1" | gsed ':a;N;$!ba;s/\n/\\n/g')
  gsed -i "/createApp(App)/,\$! {/^$/d}
0,/createApp(App)/{// s|^|$importSnippet\n\n\n|}" $mainFile

  [[ ! $2 ]] && return 0
  local injectSnippet=$(echo "$2" | gsed ':a;N;$!ba;s/\n/\\n/g')
  gsed -i "/createApp(App)/,/app.mount('#app')/ {/^$/d}
0,/app.mount('#app')/{// s|^|$injectSnippet\n\n\n|}" $mainFile

  # unset mainFile importSnippet injectSnippet
)
