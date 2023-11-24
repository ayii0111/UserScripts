#! /bin/zsh

# gsma 腳本：當前倉庫中建立子模組目錄
# gsma <遠端倉庫> <子模組相對路徑>：建立一個子模組，其遠端對應到指定遠端上
# 有加入防呆，指定的遠端倉庫與當前主倉庫的一樣，會提醒修改分支
# <遠端倉庫> 有兩種格式： <用戶/倉庫> or <倉庫位址>


function getRemotAlias() {
  echo $(git remote -v | grep '^origin.* (push)$' | gsed -E 's|.*github.com/([^/]*/[^.]*)\..*|\1|')
  return 0
}

local remotAlias=$(getRemotAlias)

if [[ $1 =~ ^.*/.*$ ]] {
  git submodule add https://github.com/$1.git $2
} else {
  git submodule add $1 $2
}


if [[ $1 == *$remotAlias* ]] {
  echo "❗️ 指定的遠端倉庫，與主倉庫為同一倉庫，切換分支，以避免推送衝突\n"
}

unset remotAlias