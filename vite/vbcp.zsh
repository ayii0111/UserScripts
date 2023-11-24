#! /bin/zsh

# 別名 vbcp
# vbcp <檔名>
# 快速將 node_modules 中的 bootstrap 的個別檔案複製過來

local mainScssFile="./src/assets/scss/main.scss"
local scssDir="./src/assets/scss/"
local moduleScssDir="./node_modules/bootstrap/scss/"


if [[ ! -e $scssDir ]] {
  mkdir -p "$scssDir"
}

cp -r $moduleScssDir\_$1\.scss $scssDir
gsed -i "/\/$1\"/ s|.*|@import \"./$1\";|" $mainScssFile
# /reboot'
unset mainScssFile scssDir moduleScssDir