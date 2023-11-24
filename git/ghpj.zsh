#! /bin/zsh

# ghpi 腳本：用來快速建立新repo目錄、git 本地環境、初次 commit

git init
echo "" > README.md
git add .; git commit -m "init"