#!/bin/zsh

# 確認是否有傳入參數
if [ $# -eq 0 ]; then
  echo "錯誤：請提供套件名稱" >&2
  return 1
fi

# 套件名稱
local PACKAGE_NAME=$1
local VERSION
local PACKAGE_INFO

# 使用 npm list 檢查套件是否已安裝
PACKAGE_INFO=$(npm list $PACKAGE_NAME 2>/dev/null | grep $PACKAGE_NAME)

# 判斷套件是否已安裝
if [ -z "$PACKAGE_INFO" ]; then
  echo "  沒有安裝 $PACKAGE_NAME $failMark"

else
  # 從輸出中提取版本信息
  VERSION=$(echo $PACKAGE_INFO | grep -o '@[^ ]*' | tail -1)
  echo "  已安裝 $PACKAGE_NAME$VERSION $okMark"


fi

unset PACKAGE_NAME VERSION PACKAGE_INFO