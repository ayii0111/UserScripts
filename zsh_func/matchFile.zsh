#! /bin/zsh

# 別名 matchFile: 可以匹配並驗證路徑檔案
# matchFile <主檔名路徑>
# 使用 file=$(matchFile <主檔名路徑>) || return 1
# 用來匹配不確定副檔名的路徑
(
  local filePaths

  filePaths=($1.*)

  # 若匹配不到檔案，則報錯
  [[ $filePaths == $1.\* ]] && echo "Error: 匹配不到檔案" >&2 && return 1

  # 若匹配到 2 個以上的檔案，則報錯
  (($#filePaths > 1)) && echo " $failMark 匹配到 2 個以上的檔案: $filePaths" >&2 && return 1

  echo "$filePaths"
)
