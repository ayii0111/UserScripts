#! /bin/zsh

# gcbt 腳本：回溯提交
# bt 為 Back in time 的簡稱 (時光倒流)
# gcbt [提交]：回溯到指定的提交
# 無參數時，默認會回溯 當前/上一個 提交

if (($# != 0)); then
  git reset --hard $1 && git clean -fd
  return 0
fi

local change=$(git status -s)
if [[ $change ]]; then
  git reset --hard HEAD && git clean -fd
  unset change
  return 0
fi
git reset --hard HEAD^ && git clean -fd
unset change
