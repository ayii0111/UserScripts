#!/usr/bin/env zsh

echo "測試 some 函數"

echo "測試案例 1: 測試陣列中有元素滿足條件（數字大於 5）"
if some 1 3 6 8 2 '[ $1 -gt 5 ]'; then
  echo " \e[32m✔\e[0m 案例 1 通過：成功找到大於 5 的數字"
else
  echo " \e[31m✗\e[0m 案例 1 失敗：應該要找到大於 5 的數字"
fi

echo "測試案例 2: 測試陣列中沒有元素滿足條件（數字大於 10）"
if ! some 1 3 6 8 2 '[ $1 -gt 10 ]'; then
  echo " \e[32m✔\e[0m 案例 2 通過：正確地沒有找到大於 10 的數字"
else
  echo " \e[31m✗\e[0m 案例 2 失敗：不應該找到大於 10 的數字"
fi

echo "測試案例 3: 測試字串比對"
if some "apple" "banana" "cherry" '[ "$1" = "banana" ]'; then
  echo " \e[32m✔\e[0m 案例 3 通過：成功找到字串 'banana'"
else
  echo " \e[31m✗\e[0m 案例 3 失敗：應該要找到字串 'banana'"
fi

echo "測試案例 4: 測試參數不足的錯誤處理"
if ! some '[ $1 -gt 5 ]'; then
  echo " \e[32m✔\e[0m 案例 4 通過：正確處理參數不足的情況"
else
  echo " \e[31m✗\e[0m 案例 4 失敗：沒有正確處理參數不足的情況"
fi

echo "測試案例 5: 測試檔案存在檢查"
testFile=$(mktemp)
if some "$testFile" "/non/exist/file" '[ -f "$1" ]'; then
  echo " \e[32m✔\e[0m 案例 5 通過：成功檢測到存在的檔案"
else
  echo " \e[31m✗\e[0m 案例 5 失敗：應該要檢測到存在的檔案"
fi

# 清理測試環境
rm -f "$testFile"
