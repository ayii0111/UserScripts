#! /bin/zsh
# 別名 forEach: 實現 js 的同名方法
# 使用：
# forEach $arg1 $arg2 ... $callback  (callback 裡面 $1 代表為陣列的元素)
# forEach $arr $callback  (callback 裡面 $1 代表為陣列的元素)
(
  local args=()
  local arr=()
  local callback=""

  # 檢查參數
  (($# < 2)) && echo "Error: 至少 2 個參數" >&2 && return 1

  args=($*)
  # 拆分陣列
  arr=(${args[1, -2]})
  # 拆分回調
  callback=${args[-1]}
  eval "function cbFn() { $callback }"
  for e in $arr; do
    cbFn $e
  done
)
