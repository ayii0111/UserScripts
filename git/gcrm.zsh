#! /bin/zsh

# gcrm 腳本：移除歷史提交
# gcrm [提交]：可以將歷史提交移除，並且保留當前工作變動
# 無參數時，默認會移除上一個提交

if (( $# == 0 )) {
  git reset --soft HEAD^
} else {
  git reset --soft $1
}
