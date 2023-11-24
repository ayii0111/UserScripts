#!/bin/zsh

# 重要操作前的 git提交暫存


# 檢查工作區和暫存區的狀態
status_output=$(git status --porcelain)

# 判斷是否有變動
if [[ -z "$status_output" ]]; then
  echo "目前專案，尚無任何變動"
else
  echo "發現變動，將自動暫存並提交"

  # 暫存所有變動
  git add .

  # 提交變動
  git commit -m "Auto-commit: 重要操作前的提交暫存"

  echo "重要操作前的提交暫存，已完成"
fi
