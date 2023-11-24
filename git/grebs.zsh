#! /bin/zsh

# grebs 腳本：(並非純 rebase 而是有 squash 的腳本) 在同分支中變基（合併提交）
# 單存多個分支合併，並保留美化，他們的提交訊息
# grebs [新提交] 舊提交
# grebs 舊提交
# 底層使用 rebase (squash) 來變基合併


# 將提交ID縮減為頭7個字元
get7char() {
  str=$1
  str_length=$#str

  if (( $str_length >= 7 )) {
    str=${str[1,7]}
    echo $str

  } else {
    echo "提交ID小於 7個字元" >&2
    return 1
  }
}

if [[ -z "$1" ]] {
  echo 沒有輸入提交ID >&2
  return 1
} elif [[ -z "$2" ]] {

  local oldest_commit=$(get7char $1 )
  if [[ -z "$oldest_commit" ]] return 1

  # 取得最新提交ID
  local newest_commit=$(git rev-parse --short=7 HEAD)

  echo $oldest_commit
  # 每次最多合併 6個提交，多的提交不會有美化的向下箭頭
  GIT_EDITOR="gsed -i '/$oldest_commit/{:a;N; /$newest_commit/!ba; s|pick|squash|g; s|squash|pick|; b;}; / #2:/{N;s|$|\n↓|}; / #3:/{N;s|$|\n↓|}; / #4:/{N;s|$|\n↓|}; / #5:/{N;s|$|\n↓|}; / #6:/{N;s|$|\n↓|};'" git rebase -i --root
} else {
  local oldest_commit=$(get7char $2)
  if [[ -z "$oldest_commit" ]] return 1

  local newest_commit=$(get7char $1)
  if [[ -z "$newest_commit" ]] return 1

  GIT_EDITOR="gsed -i '/$oldest_commit/{:a;N; /$newest_commit/!ba; s|pick|squash|g; s|squash|pick|; b;}; / #2:/{N;s|$|\n↓|}; / #3:/{N;s|$|\n↓|}; / #4:/{N;s|$|\n↓|}; / #5:/{N;s|$|\n↓|}; / #6:/{N;s|$|\n↓|};'" git rebase -i --root
}

unset oldest_commit newest_commit

