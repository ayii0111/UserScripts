#!/bin/zsh

# 儲存當前目錄
current_dir=$(pwd)

# 建立測試目錄
test_dir=$(mktemp -d)
cd "$test_dir"

# 建立測試檔案
create_test_files() {
  local source_content="$1"
  local target_content="$2"

  echo "$source_content" >source.txt
  echo "$target_content" >target.txt
}

# 載入要測試的函數
# source ../zsh_func/cfsyn.zsh

echo "測試案例 1: 當檔案內容完全相同時"
create_test_files "test content" "test content"
if confsync source.txt target.txt | grep -q "檔案狀態已同步"; then
  echo " \e[32m✔\e[0m 案例 1 通過：正確顯示檔案已同步訊息"
else
  echo " \e[31m✗\e[0m 案例 1 失敗：未正確處理相同檔案情況"
fi

echo "\n測試案例 2: 當來源檔完全包含目標檔內容時"
create_test_files "line1\nline2\nline3" "line1\nline2"
if confsync source.txt target.txt | grep -q "來源檔包含目標檔"; then
  echo " \e[32m✔\e[0m 案例 2 通過：正確識別來源檔包含目標檔情況"
else
  echo " \e[31m✗\e[0m 案例 2 失敗：未正確識別包含關係"
fi

echo "\n測試案例 3: 當來源檔不完全包含目標檔內容時"
create_test_files "line1\nline3" "line1\nline2"
if confsync source.txt target.txt | grep -q "來源檔「不包含」目標檔"; then
  echo " \e[32m✔\e[0m 案例 3 通過：正確識別不完全包含情況"
else
  echo " \e[31m✗\e[0m 案例 3 失敗：未正確識別不完全包含情況"
fi

# 清理測試環境
cd "$current_dir"
rm -rf "$test_dir"
