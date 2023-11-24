#!/bin/zsh

# 載入被測試的函數
source ../zsh_func/disablePWD.zsh

# 儲存當前目錄
current_dir=$PWD

# 建立測試環境
echo "建立測試環境..."
test_root=$(mktemp -d)
mkdir -p $test_root/allowed/subdir
mkdir -p $test_root/forbidden/subdir
mkdir -p $test_root/normal/subdir

# 測試案例
echo "測試案例 1: 無參數呼叫"
if ! disablePWD; then
  echo "測試案例 1 通過：無參數時應該回傳錯誤"
else
  echo "測試案例 1 失敗：無參數時應該回傳錯誤，但卻回傳成功"
fi

echo "\n測試案例 2: 在允許目錄中執行"
cd $test_root/allowed
if disablePWD "forbidden" -a "allowed"; then
  echo "測試案例 2 通過：在允許目錄中應該回傳成功"
else
  echo "測試案例 2 失敗：在允許目錄中卻回傳錯誤"
fi

echo "\n測試案例 3: 在禁用目錄中執行"
cd $test_root/forbidden
if ! disablePWD "forbidden" -a "allowed"; then
  echo "測試案例 3 通過：在禁用目錄中應該回傳錯誤"
else
  echo "測試案例 3 失敗：在禁用目錄中卻回傳成功"
fi

echo "\n測試案例 4: 在一般目錄中執行"
cd $test_root/normal
if disablePWD "forbidden" -a "allowed"; then
  echo "測試案例 4 通過：在一般目錄中應該回傳成功"
else
  echo "測試案例 4 失敗：在一般目錄中卻回傳錯誤"
fi

echo "\n測試案例 5: 使用完整路徑作為禁用目錄"
cd $test_root/forbidden
if ! disablePWD "$test_root/forbidden"; then
  echo "測試案例 5 通過：使用完整路徑時在禁用目錄中應該回傳錯誤"
else
  echo "測試案例 5 失敗：使用完整路徑時在禁用目錄中卻回傳成功"
fi

echo "\n測試案例 6: -a 選項後無參數"
if ! disablePWD "forbidden" -a; then
  echo "測試案例 6 通過：-a 選項後無參數應該回傳錯誤"
else
  echo "測試案例 6 失敗：-a 選項後無參數卻回傳成功"
fi

# 清理測試環境
echo "\n清理測試環境..."
cd $current_dir
rm -rf $test_root

echo "測試完成"