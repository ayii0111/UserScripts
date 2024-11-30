#! /bin/zsh

# 別名 gsedWrapPreproc： gsed 換行預處理
# insert...=$(gsedWrapPreproc <段落變數>)

(($# != 1)) && echo "Error: 僅需一個參數" >&2 && return 1
echo $1 | gsed ':a;N;$!ba;s/\n/\\n/g'
