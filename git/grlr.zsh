#!/bin/zsh

# lockAndRollback 鎖定指定檔案，其他檔案都退版（且不回影響所有歷史提交）
# 保留指定檔案，其他檔案都退版（且不回影響所有歷史提交）

source $HOME/UserScripts/git/safeSave.zsh

git checkout $1 -- .

# 可以依序排除參數
# shift 3 可以一次排除前三個參數
shift

git restore --staged $* && git restore $*