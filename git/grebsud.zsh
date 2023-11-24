#!/bin/zsh


# 別名 grebsud
# 可取消 grebs 腳本的效果
# 意即可退回到 rebase (squash) 變基之前的提交狀態

# 確認最新提交是剛剛合併
local latest_merge_commit=$(git reflog | awk '/\(finish\)/ && NR==1 {print $1}')
if [[ -z "$latest_merge_commit" ]] {
  echo "合併操作不存在，無法退回" >&2

  unset latest_merge_commit
  return 1
}


# 尋找最近的合併操作，關鍵字為 (start) 找到他的上一個提交ID就是合併前的狀態
local pre_merge_commits=$(git reflog | awk '/\(start\)/ && !first {getline; print $1; first=1}')

# 如果找到目標提交
if [[ -n "$pre_merge_commits" ]] {
    echo "從 $latest_merge_commit 退回到合併前的提交狀態..."

    git reset "$pre_merge_commits" --hard && git clean -fd

    echo "已成功回退。"
}

unset latest_merge_commit pre_merge_commits