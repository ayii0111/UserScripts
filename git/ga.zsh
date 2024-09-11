#! /bin/zsh

# 別名 ga
# 讓沒有參數的指令，自動暫存整個專案

# 檢驗參數存是否存在
if [[ $1 ]]; then

  git add $1
fi

git add --all
