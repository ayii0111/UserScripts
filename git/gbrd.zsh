#! /bin/zsh

# gbrd腳本：刪除遠端分支
# gbrd [遠端倉庫名稱] [遠端分支]
# 這個腳本的上游分支，不能被刪除，否則參數都不能省略

case $# in
  0)
    local remote_repo=$(git branch -vv | awk '/^\* /' | gsed -E 's|.+\[([a-zA-Z0-9_-]+)/.+|\1|')
    local current_branch=$(git rev-parse --abbrev-ref HEAD)
    git push -d $remote_repo $current_branch
    ;;
  1)
    local remote_repos=($(git remote))
    # 這裡的邏輯判斷是：如果傳入的參數是一個遠端庫，那就應該會在遠端庫的檢視結果中
    # 若沒有代表這是一個分支名稱
    if (( ${remote_repos[(Ie)$1]} )) {
      local current_branch=$(git rev-parse --abbrev-ref HEAD)
      git push -d $1 $current_branch
    } else {
      local remote_repo=$(git branch -vv | awk '/^\* /' | gsed -E 's|.+\[([a-zA-Z0-9_-]+)/.+|\1|')
      git push -d remote_repo $1
    }
    ;;
  2)
    git push -d $1 $2
    ;;
  *)
    echo "參數格式錯誤" >&2
    return 1
    ;;
esac


