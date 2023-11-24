#! /bin/zsh
_recordLastCmdPre() {

  # 監聽儲存發送時的指令
  currentCmd=$1
}

_recordLastCmdPost() {
  lastCmd=$currentCmd

  if (($lastStatus == 0)) && [[ $currentCmd ]]; then
    lastSuccessCmd=$currentCmd
  fi
  if (($lastStatus != 0)) && [[ $currentCmd ]]; then
    lastFailCmd=$currentCmd
  fi
  return $lastStatus
}

# 註冊 hooks
add-zsh-hook preexec _recordLastCmdPre
add-zsh-hook precmd _recordLastCmdPost
