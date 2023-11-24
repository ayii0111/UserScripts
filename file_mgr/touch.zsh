#! /bin/zsh

local _path="$*"

# 此處不直接使用 touch，是為了避免與 alias 衝突而造成無限循環調用
# 因此改用原指令的路徑來執行

mkdir -p "${_path:h}" && /usr/bin/touch "$_path"

unset _path