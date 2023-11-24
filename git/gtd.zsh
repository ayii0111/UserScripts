#! /bin/zsh

# gtd 腳本：用來快速刪除 git 測試環境

if [[ ! $(pwd) == $HOME/git-test ]] {
  echo "error: 當前目錄非 git-test 目錄" >&2
  return 1
}

ghdel
cd ..
rm -rf /Users/ayii/git-test


