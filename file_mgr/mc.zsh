#! /bin/zsh

# 別名 mc: 建立目錄並切換到該目錄
# mkdir_cd
# mkdir -p 若目錄已經存在，也不會報錯；且可建立巢狀目錄
mkdir -p $1 && cd $1
