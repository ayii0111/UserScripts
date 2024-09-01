#! /bin/zsh

# 別名 getMatchedFile: 可以匹配並驗證路徑檔案
# 函式別名 getMatchedFile
# getMatchedFile <主檔名路徑>
# 用來取得副檔名不確定的完整檔案路徑
# 若匹配不到則報錯

filePath=$1
# 先排除匹配2個以上檔案的錯誤
filePathArr=($(echo $filePath.*))
if [[ $#filePathArr -gt 1 ]]; then
  echo "  $failMark 匹配到 2 個以上的檔案:" >&2
  for elem in $filePathArr; do
    echo "    $elem" >&2
  done
  echo "" >&2
  unset filePath
  return 1
fi

# 再排除沒有匹配到檔案
filePath=$filePathArr
# 若沒有匹配到存在的檔案，就不會路徑展開，而僅會有字串串連的效果，此時結尾字串為 *
if [[ $filePath == *'*' ]]; then
  echo "  $failMark 找不到 $filePath 匹配的檔案\n" >&2
  unset filePath
  return 1
fi

echo $filePath
unset filePath
