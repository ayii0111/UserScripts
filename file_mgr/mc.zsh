#! /bin/zsh

# 別名 mc
# mkdir_cd
# mkdir -p 若目錄已經存在，也不會報錯；且可建立巢狀目錄
mkdir -p $1 && cd $1
