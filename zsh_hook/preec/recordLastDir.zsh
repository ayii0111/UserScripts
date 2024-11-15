#! /bin/zsh

typeset -g currentDir

_recordLastDirPre() {
  # 執行指令時，當前的工作目錄
  currentDir=$(pwd)
}

_recordLastDirPost() {
  # 只要使用了切換目錄的指令，都會符合條件
  if [[ ! $currentDir == $(pwd) ]] {
    echo $(pwd) > $HOME/.lastDir
  }
  unset currentDir
}

# 註冊 hooks
add-zsh-hook preexec _recordLastDirPre
add-zsh-hook precmd _recordLastDirPost