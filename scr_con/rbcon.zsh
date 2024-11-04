#! /bin/zsh

# 別名 rbcon: 備份的逆向覆蓋

local basePath=$HOME/UserConfig

# zshrc
cp $basePath/zshrc/.zshrc $HOME/.zshrc

# vsCode(Cursor)
cp $basePath/vsCode/ "$HOME/Library/Application Support/Cursor/User/settings.json"
cp $basePath/vsCode/ "$HOME/Library/Application Support/Cursor/User/keybindings.json"
cp $basePath/vsCode/snippets "$HOME/Library/Application Support/Cursor/User/snippets"

unset basePath
