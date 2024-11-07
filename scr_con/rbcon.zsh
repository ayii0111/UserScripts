#! /bin/zsh

# 別名 rbcon: 備份的逆向覆蓋

local basePath=$HOME/UserConfig

# zshrc
cp $basePath/zshrc/.zshrc $HOME/.zshrc

# vsCode(Cursor)
cp $basePath/vsCode/settings.json "$HOME/Library/Application Support/Cursor/User/settings.json"
cp $basePath/vsCode/keybindings.json "$HOME/Library/Application Support/Cursor/User/keybindings.json"
cp $basePath/vsCode/snippets "$HOME/Library/Application Support/Cursor/User/snippets"

cp $basePath/Rime/bopomo_onion.schema.yaml "$HOME/Library/Rime/bopomo_onion.schema.yaml"
cp $basePath/Rime/default.custom.yaml "$HOME/Library/Rime/default.custom.yaml"

unset basePath
