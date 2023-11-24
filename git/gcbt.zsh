#! /bin/zsh

# gcbt 腳本：回溯提交
# bt 為 Back in time 的簡稱 (時光倒流)
# gcbt [提交]：回溯到指定的提交
# 無參數時，默認會回溯上一個提交

if (( $# == 0 )) {
  git reset --hard HEAD^ && git clean -fd
} else {
  git reset --hard $1 && git clean -fd
}


