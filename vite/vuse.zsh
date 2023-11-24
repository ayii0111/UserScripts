#! /bin/zsh

# vuse 腳本
# 可快速安裝並配置
(
  checkNoInst @vueuse/core || return 1

  npm i @vueuse/core

  local file=""
  file=$(matchFile "./vite.config") || return 1

  # 暫時僅解除 '@vueuse/core', 這行註解
  # 若有 bug 再去找 notion 筆記記錄的配置
  gsed -i "s|// '@vueuse/core',|'@vueuse/core',|" $file

  unset file
)
