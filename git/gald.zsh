#! /bin/zsh

# gald 腳本：載入某檔暫存狀態：gald [file]
# 無參數時，默認為載入當前專案暫存狀態
# 測試情境：新建一個檔案後暫存，再次新建一個檔案後，載入暫存
if (( $# == 0 )) {
  git checkout .
  git clean -fd
} else {
  git checkout -- $*
  git clean -fd $*
}