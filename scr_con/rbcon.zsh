#! /bin/zsh

# 別名 rbcon: 備份的逆向覆蓋

local basePath=$HOME/UserConfig

# zshrc
# cp $basePath/zsh_config/.zshrc $HOME/.zshrc

# Cursor
# cp $basePath/vsCode/settings.json "$HOME/Library/Application Support/Cursor/User/settings.json"
# cp $basePath/vsCode/keybindings.json "$HOME/Library/Application Support/Cursor/User/keybindings.json"
# cp $basePath/vsCode/snippets "$HOME/Library/Application Support/Cursor/User/snippets"

cp $basePath/vsCode/settings.json "$HOME/Library/Application Support/Code/User/settings.json"
cp $basePath/vsCode/keybindings.json "$HOME/Library/Application Support/Code/User/keybindings.json"
cp $basePath/vsCode/snippets "$HOME/Library/Application Support/Code/User/snippets"

cp $basePath/config/Rime/bopomo_onion.schema.yaml "$HOME/Library/Rime/bopomo_onion.schema.yaml"
cp $basePath/config/Rime/default.custom.yaml "$HOME/Library/Rime/default.custom.yaml"
cp $basePath/config/Rime/cangjie5.userdb "$HOME/Library/Rime/cangjie5.userdb"
# cp $basePath/config/.warp $HOME/.warp

unset basePath
