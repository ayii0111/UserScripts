#! /bin/zsh

# 載入待測試的函式

# 建立測試目錄
testDir=$(mktemp -d)
cd $testDir

# 建立測試檔案
touch test.txt
touch demo.json
touch demo.yml

echo "測試案例 1: 當檔案存在且只有一個匹配時"
if file=$(matchFile "test") && [[ $file == *test.txt ]]; then
  echo " \e[32m✔\e[0m 案例 1 通過：成功匹配到唯一的檔案 test.txt"
else
  echo " \e[31m✗\e[0m 案例 1 失敗：應該要匹配到 test.txt"
fi

echo "\n測試案例 2: 當有多個匹配檔案時"
if ! file=$(matchFile "demo"); then
  echo " \e[32m✔\e[0m 案例 2 通過：正確檢測到多個匹配檔案的情況"
else
  echo " \e[31m✗\e[0m 案例 2 失敗：應該要偵測到多個匹配檔案而失敗"
fi

echo "\n測試案例 3: 當檔案不存在時"
if ! file=$(matchFile "nonexistent"); then
  echo " \e[32m✔\e[0m 案例 3 通過：正確檢測到檔案不存在的情況"
else
  echo " \e[31m✗\e[0m 案例 3 失敗：應該要偵測到檔案不存在而失敗"
fi

echo "\n測試案例 4: 當路徑包含目錄時"
mkdir -p subdir
touch subdir/test.conf
if file=$(matchFile "subdir/test") && [[ $file == *subdir/test.conf ]]; then
  echo " \e[32m✔\e[0m 案例 4 通過：成功匹配到子目錄中的檔案"
else
  echo " \e[31m✗\e[0m 案例 4 失敗：應該要匹配到 subdir/test.conf"
fi

# 清理測試環境
cd - >/dev/null
rm -rf $testDir
