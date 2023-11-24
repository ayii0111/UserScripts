#!/bin/zsh

# 儲存原始工作目錄
original_pwd=$(pwd)

# 建立測試目錄結構
echo "建立測試環境..."
test_root="/tmp/test_telp_$(date +%s)"
mkdir -p "$test_root/source/nested"
mkdir -p "$test_root/target"
mkdir -p "$test_root/target_with_conflict/source"

# 在測試目錄中建立一些測試檔案
echo "test file" > "$test_root/source/test.txt"

# 切換到測試目錄
cd "$test_root/source" || exit 1

echo "測試案例 1: 基本功能 - 移動目錄到有效目標位置"
if telp "$test_root/target"; then
  [[ -d "$test_root/target/source" ]] && \
  [[ -f "$test_root/target/source/test.txt" ]] && \
  [[ $(pwd) == "$test_root/target/source" ]]
  if [[ $? -eq 0 ]]; then
    echo " \e[32m✔\e[0m 案例 1 通過：成功移動目錄並跳轉到新位置"
  else
    echo " \e[31m✗\e[0m 案例 1 失敗：移動後的目錄結構不符合預期"
  fi
else
  echo " \e[31m✗\e[0m 案例 1 失敗：telp 命令執行失敗"
fi

# 測試撤銷功能
echo "測試案例 2: 測試 undo 功能"
if undo; then
  [[ -d "$test_root/source" ]] && \
  [[ -f "$test_root/source/test.txt" ]] && \
  [[ $(pwd) == "$test_root/source" ]]
  if [[ $? -eq 0 ]]; then
    echo " \e[32m✔\e[0m 案例 2 通過：成功撤銷移動操作"
  else
    echo " \e[31m✗\e[0m 案例 2 失敗：撤銷後的目錄結構不符合預期"
  fi
else
  echo " \e[31m✗\e[0m 案例 2 失敗：undo 命令執行失敗"
fi

echo "測試案例 3: 測試移動到衝突目錄"
if ! telp "$test_root/target_with_conflict"; then
  echo " \e[32m✔\e[0m 案例 3 通過：正確阻止了移動到具有衝突的目標位置"
else
  echo " \e[31m✗\e[0m 案例 3 失敗：未能阻止移動到具有衝突的目標位置"
fi

echo "測試案例 4: 測試無參數情況"
if ! telp; then
  echo " \e[32m✔\e[0m 案例 4 通過：正確處理了無參數情況"
else
  echo " \e[31m✗\e[0m 案例 4 失敗：未能正確處理無參數情況"
fi

echo "測試案例 5: 測試移動到不存在的目標路徑"
if ! telp "$test_root/non_existent_dir/test"; then
  echo " \e[32m✔\e[0m 案例 5 通過：正確處理了不存在的目標路徑"
else
  echo " \e[31m✗\e[0m 案例 5 失敗：未能正確處理不存在的目標路徑"
fi

# 清理測試環境
cd "$original_pwd" || exit 1
rm -rf "$test_root"
echo "測試環境已清理"