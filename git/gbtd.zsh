#! /bin/zsh

# gbtd腳本：刪除追蹤分支
# gbtd [遠端倉庫/追蹤分支]：無參數時默認為當前分支的追蹤分支
if (( ! $+1 )) {
  # 與得當前本地分支的上游分支，通常就與追蹤分支相同
  local upstream=$(git rev-parse --abbrev-ref --symbolic-full-name @{u})
  git branch -dr $upstream
} else {
  git branch -dr $*
}
