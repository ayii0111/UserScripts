#!/bin/zsh

# eslex 別名
# 可用來將專案中的 eslint 設定檔配置，直接覆蓋到一個統一的設定檔中

sourceFile=./eslint.config.mjs
targetFile=$HOME/UserConfig/config/eslint.config.mjs
cfsyn $sourceFile $targetFile

unset sourceFile targetFile
