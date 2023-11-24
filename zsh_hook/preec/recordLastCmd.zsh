#! /bin/zsh

typeset -g currentCmd
typeset -g lastCmd
typeset -g lastExistCmd

recordLastCmdPre() {

  # 監聽儲存發送時的指令
  currentCmd=$1
}

recordLastCmdPost() {

  if [[ $currentCmd ]] {
    lastExistCmd=$lastCmd
  }
  lastCmd=$currentCmd
  currentCmd=""
}

# 註冊 hooks
autoload -U add-zsh-hook
add-zsh-hook preexec recordLastCmdPre
add-zsh-hook precmd recordLastCmdPost