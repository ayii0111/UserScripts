#!/usr/bin/env zsh

# 載入被測試的函數

# 測試案例 1: 基本數字過濾
echo "測試案例 1: 過濾包含 '1' 的數字"
result=$(filter 1 11 21 31 41 "[[ \$1 == *1* ]]")
expected="1 11 21 31 41"
if [[ "$result" == "$expected" ]]; then
  echo " \e[32m✔\e[0m 案例 1 通過：成功過濾出包含 '1' 的數字"
else
  echo " \e[31m✗\e[0m 案例 1 失敗：預期得到 '$expected'，實際得到 '$result'"
fi

# 測試案例 2: 空陣列
echo "測試案例 2: 傳入空陣列"
result=$(filter "[[ \$1 == *1* ]]")
if [[ $? -eq 1 ]]; then
  echo " \e[32m✔\e[0m 案例 2 通過：正確處理參數不足的情況"
else
  echo " \e[31m✗\e[0m 案例 2 失敗：應該回傳錯誤狀態"
fi

# 測試案例 3: 過濾字串
echo "測試案例 3: 過濾包含 'test' 的字串"
result=$(filter "test1" "hello" "testing" "world" "test2" "[[ \$1 == *test* ]]")
expected="test1 testing test2"
if [[ "$result" == "$expected" ]]; then
  echo " \e[32m✔\e[0m 案例 3 通過：成功過濾出包含 'test' 的字串"
else
  echo " \e[31m✗\e[0m 案例 3 失敗：預期得到 '$expected'，實際得到 '$result'"
fi

# 測試案例 4: 複雜條件過濾
echo "測試案例 4: 過濾大於 5 的數字"
result=$(filter 1 3 5 7 9 2 4 6 8 "[[ \$1 -gt 5 ]]")
expected="7 9 6 8"
if [[ "$result" == "$expected" ]]; then
  echo " \e[32m✔\e[0m 案例 4 通過：成功過濾出大於 5 的數字"
else
  echo " \e[31m✗\e[0m 案例 4 失敗：預期得到 '$expected'，實際得到 '$result'"
fi

# 測試案例 5: 無匹配結果
echo "測試案例 5: 測試無匹配結果的情況"
result=$(filter 1 2 3 4 5 "[[ \$1 -gt 10 ]]")
if [[ -z "$result" ]]; then
  echo " \e[32m✔\e[0m 案例 5 通過：當沒有匹配項時正確返回空字串"
else
  echo " \e[31m✗\e[0m 案例 5 失敗：應該返回空字串，實際得到 '$result'"
fi