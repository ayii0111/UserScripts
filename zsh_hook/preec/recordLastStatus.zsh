#! /bin/zsh

# 需優前於所有的 precmd 處例方法
# 取得最後一次命令的執行狀態，並存入變數 lastStatus
_recordLastStatusPost() {
  lastStatus=$?
  # echo "✞✞✞✞ $(date '+%H:%M:%S %Y-%m-%d')\n"

}

add-zsh-hook precmd _recordLastStatusPost
