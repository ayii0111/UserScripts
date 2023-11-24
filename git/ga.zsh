#! /bin/zsh

# 別名 ga
# 讓沒有參數的指令，自動暫存整個專案

# 檢驗參數存是否存在
if (( $+1 )) {
  git add $1
} else {
  git add --all
}