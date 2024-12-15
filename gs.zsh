#! /bin/zsh

# 別名 gs: 可以收藏兩區狀態
# gs [註記]  收藏當前狀態，可以添加註記，無參數時無註記

(($# > 1)) && echo "Error: 超過 1 個以上參數" >&2 && retrun 1
(($# == 0)) && git stash -u && git stash apply && return 0
git stash -m "$1" -u && git stash apply
