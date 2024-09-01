#!/bin/zsh

# 測試 cfsyn 腳本

# 建立測試用的臨時檔案
sourceFile="source_test.txt"
targetFile="target_test.txt"

# 準備測試情境 1：目標檔包含來源檔的所有行
echo "測試情境 1：目標檔包含來源檔的所有行"
echo "設定A=開啟" >$sourceFile
echo "設定B=關閉" >>$sourceFile
echo "設定C=允許" >>$sourceFile

echo "設定A=開啟" >$targetFile
echo "設定B=關閉" >>$targetFile
echo "設定C=允許" >>$targetFile
echo "設定D=特別模式" >>$targetFile

source ../cfsyn.zsh $sourceFile $targetFile
echo

# 準備測試情境 2：來源檔包含目標檔的所有行
echo "測試情境 2：來源檔包含目標檔的所有行"
echo "設定A=開啟" >$targetFile
echo "設定B=關閉" >>$targetFile
echo "設定C=允許" >>$targetFile

echo "設定A=開啟" >$sourceFile
echo "設定B=關閉" >>$sourceFile
echo "設定C=允許" >>$sourceFile
echo "設定E=額外設定" >>$sourceFile

source ../cfsyn.zsh $sourceFile $targetFile
echo

# 準備測試情境 3：來源檔不包含目標檔的所有行
echo "測試情境 3：來源檔不包含目標檔的所有行"
echo "設定X=禁用" >$sourceFile
echo "設定Y=啟動" >>$sourceFile
echo "設定Z=重置" >>$sourceFile

echo "設定A=開啟" >$targetFile
echo "設定B=關閉" >>$targetFile
echo "設定C=允許" >>$targetFile

source ../cfsyn.zsh $sourceFile $targetFile
echo

# 清理臨時檔案
rm $sourceFile $targetFile
