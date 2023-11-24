#! /bin/zsh
# 別名 includes: 檢查陣列內的元素是否至少有一個滿足回調的條件
# includes $arr $e

(
  local arr=($*)
  local matchStr=""
  local index=0

  # 檢查參數
  (($# < 2)) && echo "Error: 至少 2 個參數" >&2 && return 1

  # 拆分回調
  matchStr=${arr[-1]}
  # 拆分陣列
  arr=(${arr[1, -2]})
  index=$arr[(I)$matchStr]

  if (($index == 0)); then
    return 1
  else
    return 0
  fi
)
