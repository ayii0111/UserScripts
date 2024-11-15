#! /bin/zsh

# 別名 npt: 檢視 npm 套件版本 (npt 套件 -顯示數量)

pkgName=$1
showCount=$2

if [[ -z $showCount ]]; then
  showCount=9
fi

((showCount++))
npm view $pkgName time --json | tail -n $showCount | gsed "$ s|.*||" | gsed "s|T.*||g"
