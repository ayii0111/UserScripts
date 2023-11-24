#! /bin/zsh

# vawait 腳本
# 可快速在 vite 環境中安裝配置 await-to-js 套件
# 並整合 auto-import 配置
(
  checkNoInst await-to-js || return 1
  npm i await-to-js

  # 以下為 auto-import 的配置
  local auto_import=",
        {'await-to-js': ['to']}"

  auto_import=$(echo "$auto_import" | gsed ':a;N;$!ba;s/\n/\\n/g')

  local file=""
  file=$(matchFile "./vite.config") || return 1
  gsed -i "/imports: \[/,$ { 0,/\}$/ {// s|$|$auto_import|}}" $file
)
