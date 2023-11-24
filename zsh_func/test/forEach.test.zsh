#!/bin/zsh

# 載入被測試的函數

# 測試案例 1: 基本功能測試 - 列印數字
echo "測試案例 1: 測試基本的數字列印功能"
result=$(forEach 1 2 3 'echo $1')
expected="1
2
3"
if [[ "$result" == "$expected" ]]; then
  echo " \e[32m✔\e[0m 案例 1 通過：成功列印出所有數字"
else
  echo " \e[31m✗\e[0m 案例 1 失敗：輸出結果與預期不符"
fi

# 測試案例 2: 使用自定義回調函數
echo "測試案例 2: 測試自定義回調函數"
arr=("apple" "banana" "orange")
result=$(forEach $arr 'echo 水果: $1')
expected="水果: apple
水果: banana
水果: orange"
if [[ "$result" == "$expected" ]]; then
  echo " \e[32m✔\e[0m 案例 2 通過：成功使用自定義回調函數"
else
  echo " \e[31m✗\e[0m 案例 2 失敗：自定義回調函數執行失敗"
fi

# 測試案例 3: 錯誤處理 - 參數不足
echo "測試案例 3: 測試參數不足的情況"
result=$(forEach "11")
if (($?)); then
  echo " \e[32m✔\e[0m 案例 3 通過：正確處理參數不足的情況"
else
  echo " \e[31m✗\e[0m 案例 3 失敗：未正確處理參數不足的情況"
fi

# 測試案例 4: 使用複雜的回調函數
echo "測試案例 4: 測試複雜的回調函數"
cb='r=$(($1*2));
echo $r
'
result=$(forEach 1 2 3 $cb)
expected="2
4
6"
if [[ "$result" == "$expected" ]]; then
  echo " \e[32m✔\e[0m 案例 4 通過：成功執行複雜的回調函數"
else
  echo " \e[31m✗\e[0m 案例 4 失敗：複雜回調函數執行失敗"
fi
