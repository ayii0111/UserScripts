# #!/bin/zsh

# # 目標目錄
# local scrDir=~/UserScripts

# # 聲明一個關聯數組來存儲父目錄和文件列表
# local -A dirFiles

# # 使用 fd 查找符合條件的文件
# /opt/homebrew/bin/fd --type file --hidden --exclude '.*' . "$scrDir" | while read -r file; do
#   # 檢查文件內容中是否有匹配行
#   if ! gawk '/^# 別名: / { found=1; exit } END { exit !found }' "$file"; then
#     # 獲取相對於 scrDir 的父目錄，並去除引號
#     local parentDir=${file:${#scrDir}+1:h}
#     # 將文件名加入到該父目錄的列表中
#     dirFiles[$parentDir]+="    ${file:t}\n"
#   fi
# done

# # 輸出結果，按父目錄分組顯示
# for parentDir in ${(k)dirFiles}; do
#   # 粗體顯示父目錄並添加 `/`
#   echo "\033[1m${parentDir}/\033[0m"
#   # 顯示該目錄下的所有文件，並添加縮排
#   printf "%b" "${dirFiles[$parentDir]}"
#   # 添加空行
#   echo
# done

# # 回收變數
# unset scrDir dirFiles parentDir file


#!/bin/zsh

# 目標目錄
local scrDir=~/UserScripts

# 聲明一個關聯數組來存儲父目錄和文件列表
local -A dirFiles

# 使用 fd 查找符合條件的文件
/opt/homebrew/bin/fd --type file --hidden --exclude '.*' . "$scrDir" | while read -r file; do
  # 檢查文件內容中是否有匹配行
  if ! gawk '/^# 別名: / { found=1; exit } END { exit !found }' "$file"; then
    # 獲取相對於 scrDir 的父目錄，並去除引號
    local parentDir=${file:${#scrDir}+1:h}
    # 將文件名加入到該父目錄的列表中
    dirFiles[$parentDir]+="${file:t} "
  fi
done

# 輸出結果，按父目錄分組顯示
for parentDir in ${(k)dirFiles}; do
  # 粗體顯示父目錄並添加 `/`
  echo "\033[1m${parentDir}/\033[0m"

  # 將當前目錄下的所有文件名分成一個數組
  local files=("${(z)dirFiles[$parentDir]}")
  local fileCount=${#files}
  local colWidth=27  # 增加每列的寬度

  # 顯示該目錄下的所有文件，橫向排列成四列
  for ((i = 1; i <= fileCount; i++)); do
    printf "%-*s" $colWidth "${files[$i]}"
    if (( i % 4 == 0 )); then
      echo # 換行
    fi
  done

  # 如果最後一行的文件不足四個，添加換行
  if (( fileCount % 4 != 0 )); then
    echo
  fi

  # 添加空行
  echo
done

# 回收變數
unset scrDir dirFiles parentDir file files fileCount colWidth
