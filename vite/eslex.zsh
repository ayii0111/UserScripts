#!/bin/zsh

# 別名 eslex： eslint 設定匯出
# 可用來將專案中的 eslint 設定檔配置，直接覆蓋到一個統一的設定檔中

sourceFile=./eslint.config.mjs
targetFile=$HOME/UserConfig/config/eslint.config.mjs
confsync $sourceFile $targetFile

unset sourceFile targetFile
