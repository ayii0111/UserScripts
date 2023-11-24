#!/bin/zsh
# 別名 tz: 用來快速執行測試腳本
# 會找最後儲存的三個檔案，若有測試檔，執行最新的那個

(
  local scriptDir="$HOME/UserScripts"
  # 查找最近修改或訪問的兩個檔案（排除隱藏目錄）
  files=($(find $scriptDir -type f -not -path '*/.*/*' -print0 | xargs -0 ls -t | head -n 3))
  (($#files != 3)) && echo "Error: 無法找到 3 個有效的檔案" >&2 && return 1
  [[ $files[1] == *.test.* ]] && source $files[1] && return 0
  [[ $files[2] == *.test.* ]] && source $files[2] && return 0
  [[ $files[3] == *.test.* ]] && source $files[3] && return 0
  echo "Error: 無法找到有效的測試檔案" >&2 && return 1
)
