#! /bin/zsh

# 別名 snippetInsertMainfile: 將代碼片段插入到 main 檔
# snippetInsertMainfile <import代碼段> <app.use代碼段>
local file=$(getMatchedFile "./src/main")
if [[ ! $file ]]; then
  return 1
fi

local importSnippet=$(echo "$1" | gsed ':a;N;$!ba;s/\n/\\n/g')
local injectSnippet=$(echo "$2" | gsed ':a;N;$!ba;s/\n/\\n/g')

gsed -i "/createApp(App)/,\$! {/^$/d}
0,/createApp(App)/{// s|^|$importSnippet\n\n\n|}
/createApp(App)/,/app.mount('#app')/ {/^$/d}
0,/app.mount('#app')/{// s|^|$injectSnippet\n\n\n|}" $file

unset file importSnippet injectSnippet
