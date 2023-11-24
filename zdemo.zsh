# 檢視 cp 的效果

mkdir ./testDir
touch ./testDir/test.txt
# 檔案直接複製，會複製成目標路徑
mkdir ./testDir2

/bin/cp -r testDir ./testDir2/testDir
