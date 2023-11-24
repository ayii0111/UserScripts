#! /bin/zsh

# 函式別名 getMatchedFile
# getMatchedFile <主檔名路徑>
# 用來取得副檔名不確定的完整檔案路徑
# 若匹配不到則報錯

filePath=$1
# 先排除匹配2個以上檔案的錯誤
filePathArr=($(echo $filePath.*))
if (( $#filePathArr > 1 )) {
  echo "  $failMark 匹配到 2 個以上的檔案:" >&2
  for elem ($filePathArr) {
    echo "    $elem" >&2
  }
  echo "" >&2
  unset filePath
  return 1
}

# 再排除沒有匹配到檔案
filePath=$filePathArr
# 若沒有匹配到存在的檔案，就不會路徑展開，而僅會有字串串連的效果，此時結尾字串為 *
if [[ $filePath == *'*' ]] {
  echo "  $failMark 找不到 $filePath 匹配的檔案\n" >&2
  unset filePath
  return 1
}

echo $filePath
unset filePath
