#! /bin/zsh

if (( ! $+1 )) {
  echo "錯誤：沒有輸入提交訊息" >&2
  return 1
}

lastDir=$(pwd)
_lastDir=${lastDir:t}
cd  ~/UserConfig

gc9 $1
if [[ $_lastDir != UserConfig ]] {
  cd  $lastDir
}
