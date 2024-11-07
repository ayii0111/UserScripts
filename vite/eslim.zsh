#!/bin/zsh

# 別名 eslim: eslint 設定匯入
# 可以將統一的 eslint 設定檔覆蓋到專案中
sourceFile=$HOME/UserConfig/config/eslint.config.mjs
targetFile=./eslint.config.mjs
confsync $sourceFile $targetFile

unset sourceFile targetFile
