#!/bin/zsh

# eslim 腳本
# 可以將統一的 eslint 設定檔覆蓋到專案中
sourceFile=$HOME/UserConfig/config/eslint.config.mjs
targetFile=./eslintrc.mjs
cfsyn $sourceFile $targetFile

unset sourceFile targetFile
