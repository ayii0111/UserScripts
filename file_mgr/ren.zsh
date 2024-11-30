#! /bin/zsh

# 別名 ren: 將檔案或目錄重新命名
# 別名 ren <目錄名>  當前目錄重新命名
# rename
# ren <路徑1> <路徑2> 將路徑一的名稱改為路徑二的名稱
# 若僅有一個參數，就可以用來更改當前目錄名稱

(
  disablePWD $HOME $HOME/UserScripts $HOME/UserConfig || return 1

  (($# == 0)) && echo "  $failMark 請輸入參數" >&2 && return 1

  (($# > 2)) && echo "  $failMark 參數超過兩個" >&2 && return 1

  # 確認第二個參數的存在
  if [[ $2 ]]; then
    if [[ ${1:h} == ${2:h} ]]; then
      # 取得路徑檔名
      mv -i ${1:t} ${2:t}
    else
      echo "  $failMark 所屬目錄路徑不同" >&2
      return 1
    fi

  else
    local dir=$(pwd)
    # 取出當前目錄的名稱
    dir=${dir:t}
    cd ..
    mv -i $dir $1
    cd $1
  fi

  unset dir
)
