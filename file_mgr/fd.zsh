#! /bin/zsh

# 別名 fd: 易用版
# 添加了 -I 或 -H 的自動判斷功能


# 主要功能在搜尋 node_modules 目錄中的檔案或目錄時，會自動使用 -I 無須手動添加
# 在搜尋一個引目錄時，會自動添加 -H

# 兩種方式判別：
# 在搜尋路徑上有 node_modules 字串/ .目錄，時條件符合自動套用
# 在當前目錄有 node_modules 字串/ .目錄的字串時，條件符合自動套用


# 原始 fd 的特性
# 第二參數
# 若有隱藏檔路徑，則不會因此完全搜尋不到目標（此時無須添加 -H）
# 若為 node_modules，則會完原搜不到東西（此時需要添加 -I）
# 第一參數
# 若為隱藏檔名，也搜不到東西（此時仍需添加 -H）

args=$*
hasNodeMod() {
  if [[ $args == *node_modules* || $(pwd) == *node_modules* ]] {
    return 0
  } else {
    return 1
  }
}

hasHidden() {
  if [[ $args == .[^/]* ]] {
    return 0
  } else {
    return 1
  }
}

# 不知為何，此種格式無法使用 echo 除錯，因為都會一律執行第一個 echo 其餘不執行
if hasNodeMod && hasHidden; then
  echo "-IH"
  /opt/homebrew/bin/fd -IH $*
elif hasNodeMod; then
  echo "-I"
  eval "/opt/homebrew/bin/fd -I $*"
elif hasHidden; then
  echo "-H"
  /opt/homebrew/bin/fd -H $*
else
  echo "*"
  /opt/homebrew/bin/fd $*
fi

unset args
unset -f hasNodeMod hasHidden