#! /bin/zsh

# gsmab 腳本：建立子模組(需指定分支)
# gsmab <子倉庫本地分支> <子模組相對路徑>：建立一個子模組，其遠端對應到當前遠端庫的新分支上
# gsmab <子倉庫本地分支> <用戶/遠端倉庫> <子模組相對路徑>：建立一個子模組，其遠端對應到指定遠端上的某遠端分支上


function getRemotUrl() {
  echo $(git remote -v | grep '^origin.* (push)$' | gsed -E 's/^origin\s+(\S+)\s+\(push\)$/\1/')
  return 0
}



if (( $#* == 2 )) {
  local remotUrl=$(getRemotUrl)
  git submodule add -b $1 $remotUrl $2
  unset remotUrl

  return 0
}

git submodule add $1 https://github.com/$2.git $3

