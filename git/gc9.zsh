#!/bin/zsh

# 別名 gc9
# 可一併暫存與提交，並維持最新的9個提交

# 取得當前分支的提交數量
local total_commits=$(git rev-list --count HEAD)


# 當前提交等於9時，
if (( $total_commits == 9 )) {

  git add --all && git commit -m "$1"

  # 移除最舊的提交
  GIT_EDITOR="gsed -i '2s/pick/fixup -c/'" git rebase -i --root
  echo "...已保留最新的 9 次提交"
} elif (( $total_commits > 9 )) {
  echo "請確認提交尚未超過 9 次" >&2
  return 1
} else {

  git add --all && git commit -m "$1"

}


unset total_commits