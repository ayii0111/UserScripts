#! /bin/zsh

if (( ! $+1 )) {
  echo "錯誤：沒有輸入提交訊息" >&2
  return 1
}

lastDir=$(pwd)
_lastDir=${lastDir:t}
cd  ~/UserScripts

gc9 $1
if [[ $_lastDir != UserScripts ]] {
  cd  $lastDir
}
