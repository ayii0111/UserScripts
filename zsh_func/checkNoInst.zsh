#! /bin/zsh
# 別名 checkNoInst: 確認某一 npm 套件尚未安裝
# 使用 checkNoInst 套件 || return 1

if (npm list $1 >/dev/null 2>&1); then
  echo "$1 已經安裝" >&2
  return 1 #
fi
