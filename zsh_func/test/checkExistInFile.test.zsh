#!/bin/zsh

# 創建一個臨時測試文件
test_file=$(mktemp)

echo "This is a test file" >"$test_file"
echo "It contains some keywords" >>"$test_file"
echo "Like 'apple' and 'banana'" >>"$test_file"

# 測試案例 1: 檢查存在的關鍵字
if checkExistInFile "test" "keywords" "apple" "$test_file"; then
  echo "測試案例 1 通過：成功檢測到所有存在的關鍵字"
else
  echo "測試案例 1 失敗：未能檢測到所有存在的關鍵字"
fi

# 測試案例 2: 檢查不存在的關鍵字
if ! checkExistInFile "nonexistent" "$test_file"; then
  echo "測試案例 2 通過：成功檢測到不存在的關鍵字"
else
  echo "測試案例 2 失敗：錯誤地檢測到不存在的關鍵字"
fi

# 測試案例 3: 檢查不存在的文件
if ! checkExistInFile "test" "/path/to/nonexistent/file"; then
  echo "測試案例 3 通過：成功處理不存在的文件"
else
  echo "測試案例 3 失敗：未能正確處理不存在的文件"
fi

# 清理臨時文件
rm "$test_file"

echo "測試完成"
