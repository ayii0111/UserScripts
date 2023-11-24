#!/bin/zsh

# 別名 re: 快速重啟 iTerm2
# 重啟終端軟件的 mac腳本

# 重啟 iterm2 的指令
osascript -e "tell application \"iTerm\" to tell current window to close" -e "tell application \"iTerm\" to create window with default profile"
