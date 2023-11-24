#! /bin/zsh
# 別名 every: 檢查陣列中的每一個元素是否都滿足回調
(
  local args=($*)
  local rsl=()
  local callback=""

  # 檢查參數
  (($# < 2)) && echo "Error: 至少 2 個參數" >&2 && return 1

  # 拆分回調
  callback=${args[-1]}
  # 拆分陣列
  args=(${args[1, -2]})

  # 原格式   eval "function cbFn() { $callback || return 1 }" 會報錯
  # 他會在 $callback 儲存 $1 帶入時產生   function cbFn() { $1 || return 1 } 的函式
  # 此時，直接帶入 [[ ... ]] 作為參數，會產生一個奇怪的路徑展開錯誤
  # 而原來之前可以正常，都是使用這樣 $callback 儲存 （（ $1 > 3 ))
  # 而會產生 function cbFn() { （（ $1 > 3 )) || return 1 } 的函式
  # 所以可以正常
  # 改成下面格式，就能兼容兩種方式

  eval "function cbFn() { eval \"$callback\" || return 1 }"
  for e in $args; do
    if ! (cbFn $e); then
      return 1
    fi
  done
  return 0
)
