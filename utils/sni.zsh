#! /bin/zsh

# sni 腳本
# 無參數時，檢視 vscode snippets 目錄
# 帶入檢視的 snippet 檔名時，會直接在 vscode 中開啟


if (( ! $+1 )) {

  ls "$HOME/Library/Application Support/Code/User/snippets"
  return 0
}

code $HOME/Library/Application\ Support/Code/User/snippets/$1