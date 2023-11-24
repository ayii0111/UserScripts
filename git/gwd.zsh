#! /bin/zsh

# gwd 腳本：刪除分支目錄
# gwd <本地分支>： 原始參數應使用「分支目錄路徑」，這裡經過優化只要使用分支名稱即可

currentDir=${$(pwd):t}
git worktree remove ../$currentDir\($1\)