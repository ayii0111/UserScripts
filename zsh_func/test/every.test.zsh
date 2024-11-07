#!/usr/bin/env zsh

echo "測試案例 1: 所有數字都小於 3"
if every 1 2 '(($1 < 3))'; then
  echo " \e[32m✔\e[0m 案例 1 通過：所有數字確實都小於 3"
else
  echo " \e[31m✗\e[0m 案例 1 失敗：應該要通過，因為 1 和 2 都小於 3"
fi

echo "\n測試案例 2: 部分數字大於 3"
if ! every 1 4 2 '(($1 < 3))'; then
  echo " \e[32m✔\e[0m 案例 2 通過：正確檢測到不是所有數字都小於 3"
else
  echo " \e[31m✗\e[0m 案例 2 失敗：應該要失敗，因為 4 大於 3"
fi

echo "\n測試案例 3: 測試空字串檢查"
if every "hello" "world" '[ ! -z $1 ]'; then
  echo " \e[32m✔\e[0m 案例 3 通過：所有字串都不為空"
else
  echo " \e[31m✗\e[0m 案例 3 失敗：所有字串都不為空，應該要通過"
fi

echo "\n測試案例 4: 參數不足的情況"
if ! every '(($1 < 3))'; then
  echo " \e[32m✔\e[0m 案例 4 通過：正確檢測到參數不足"
else
  echo " \e[31m✗\e[0m 案例 4 失敗：參數不足時應該要失敗"
fi

echo "\n測試案例 5: 測試數字相等"
if every 5 5 5 '(($1 == 5))'; then
  echo " \e[32m✔\e[0m 案例 5 通過：所有數字都等於 5"
else
  echo " \e[31m✗\e[0m 案例 5 失敗：所有數字都是 5，應該要通過"
fi

echo "\n測試案例 5: 多個驗證回調作為陣列元素"
str="/Users/ayii/UserScripts/demo"
# 要驗證該路徑為絕對路徑
# 屬於位於某用戶的目錄中
# 目錄名稱為 demo
# local arr=(
#   "$str == /*"
#   "$str == *Users/ayii/*"
#   "$str == */demo"
# )
local arr=(
  "[[ $str == /* ]]"
  "[[ $str == *Users/ayii/* ]]"
  "[[ $str == */demo ]]"
)
# 不知道為什麼，不可以這樣 every $arr '$1' 使用，把 [[ ]] 移到陣列的字串中，會莫名產生，類似路徑展開的錯誤
# if every $arr '[[ $1 ]]'; then
if every $arr '$1'; then
  echo " \e[32m✔\e[0m 案例 5 通過：驗證成功"
else
  echo " \e[31m✗\e[0m 案例 5 失敗：驗證失敗"
fi
