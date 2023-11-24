#! /bin/zsh

# 別名 sni: 可檢視 vscode snippets 目錄，或直接開啟 snippet 檔案
# 無參數時，檢視 vscode snippets 目錄
# 帶入檢視的 snippet 檔名時，會直接在 vscode 中開啟

# Cursor snip 路徑
# /Users/ayii/Library/Application Support/Cursor/User/snippets

if [[ ! $1 ]]; then

  ls "$HOME/Library/Application Support/Cursor/User/snippets"
  return 0
fi

cursor $HOME/Library/Application\ Support/Cursor/User/snippets/$1
