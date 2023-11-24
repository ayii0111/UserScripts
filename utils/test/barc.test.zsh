#!/bin/zsh

# 保存當前目錄
local origDir=$PWD

# 創建測試目錄結構
local testRoot=$(mktemp -d)
local testArcDir="$testRoot/Arc"
local testBackupDir="$testRoot/Backup"

# 創建測試用的 Arc 配置文件
mkdir -p "$testArcDir"
echo "test1" > "$testArcDir/config1"
echo "test2" > "$testArcDir/config2"
mkdir -p "$testArcDir/subdir"
echo "test3" > "$testArcDir/subdir/config3"

# 修改環境變數以使用測試目錄
HOME=$testRoot

echo "測試 Arc 配置備份功能"

echo "測試案例 1: 正常備份情境"
if source ../barc.zsh; then
    # 驗證文件是否正確備份
    if [[ -f "$testBackupDir/config1" && -f "$testBackupDir/config2" && -f "$testBackupDir/subdir/config3" ]]; then
        echo " \e[32m✔\e[0m 案例 1 通過：成功備份所有配置文件"
    else
        echo " \e[31m✗\e[0m 案例 1 失敗：部分文件未被備份"
    fi
fi

echo "測試案例 2: 重複備份情境"
echo "new_test" > "$testArcDir/config1"
if source ../barc.zsh; then
    if [[ $(cat "$testBackupDir/config1") == "new_test" ]]; then
        echo " \e[32m✔\e[0m 案例 2 通過：成功更新已存在的備份文件"
    else
        echo " \e[31m✗\e[0m 案例 2 失敗：未能正確更新已存在的備份文件"
    fi
fi

# 清理測試環境
cd $origDir
rm -rf $testRoot

# 回收變數
unset origDir testRoot testArcDir testBackupDir