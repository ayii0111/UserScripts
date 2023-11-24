#!/usr/bin/env zsh

# 建立測試環境
local curDir=$PWD
local testDir=$(mktemp -d)
cd $testDir

# 建立測試檔案
local testFile=$(mktemp)
cat <<'EOF' >$testFile
function test() {
    const field1 = 'test'
        const field2 = 'demo'
    const field3 = 'example'
}
EOF

echo "測試 zdemo 函式"

echo "測試案例 1: 測試查找存在的欄位"
if output=$(zdemo "const field2" $testFile) && [[ $output == "3 8" ]]; then
  echo " \e[32m✔\e[0m 案例 1 通過：成功找到欄位 field2 在第 3 行，縮排為 8"
else
  echo " \e[31m✗\e[0m 案例 1 失敗：預期輸出為 '3 8'，實際輸出為 '$output'"
fi

echo "測試案例 2: 測試查找不存在的欄位"
if output=$(zdemo "nonexistent" $testFile); then
  echo " \e[31m✗\e[0m 案例 2 失敗：預期不應該有輸出，實際輸出為 '$output'"
else
  echo " \e[32m✔\e[0m 案例 2 通過：欄位不存在時沒有輸出"
fi

echo "測試案例 3: 測試不存在的檔案"
if output=$(zdemo "field1" "nonexistent.txt" 2>&1); then
  echo " \e[31m✗\e[0m 案例 3 失敗：預期應該報錯，實際沒有報錯"
else
  [[ $output == "Error: 檔案不存在" ]] &&
    echo " \e[32m✔\e[0m 案例 3 通過：正確顯示檔案不存在錯誤" ||
    echo " \e[31m✗\e[0m 案例 3 失敗：錯誤訊息不符合預期"
fi

# 清理測試環境
rm -f $testFile
cd $curDir
rm -rf $testDir
