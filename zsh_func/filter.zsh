#! /bin/zsh
# 別名 filter: 用來篩選陣列中的元素
# filter $arg1 $arg2 $arg3... "$callback"

(
  local args=()
  local rsl=()
  local callback=""

  # 檢查參數
  (($# < 2)) && echo "Error: 至少 2 個參數" >&2 && return 1
  args=($*)
  # 拆分回調
  callback=${args[-1]}

  # 拆分陣列
  args=(${args[1, -2]})

  eval "function cbFn() { $callback || return 1 }"
  # eval "function cbFn() { eval \"$callback\" || return 1 }"

  for e in $args; do
    if ! (cbFn $e); then
      continue
    fi
    rsl+=("$e")
  done

  echo $rsl
)
