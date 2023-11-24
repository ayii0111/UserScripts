#! /bin/zsh

# 別名 bcon: 將設定檔備份到 UserConfig 資料夾
# 全稱 backup config
# 設定檔的備份，包含 vscode、snippets、.zshrc骨幹

# 透過自製的 mp指令，將設定檔備份管理

local basePath=$HOME/UserConfig

# zshrc
cp $HOME/.zshrc $basePath/zsh_config/.zshrc

# vsCode(Cursor)
cp "$HOME/Library/Application Support/Cursor/User/settings.json" $basePath/vsCode/
cp "$HOME/Library/Application Support/Cursor/User/keybindings.json" $basePath/vsCode/
cp "$HOME/Library/Application Support/Cursor/User/snippets" $basePath/vsCode/snippets

# vscode 擴展
code --list-extensions >$basePath/vsCode/extensionsList

# 輸入法初始配置
cp "$HOME/Library/Rime/bopomo_onion.schema.yaml" $basePath/config/Rime/
cp "$HOME/Library/Rime/default.custom.yaml" $basePath/config/Rime/
cp "$HOME/Library/Rime/cangjie5.userdb" $basePath/config/Rime/

# warp 終端的快捷建配置 (主要配置無法匯出)
cp $HOME/.warp $basePath/config/.warp

# homebrew 已安裝的主要套件
brew leaves >"$basePath/config/brew/brew-leaves"

# config
# cp $HOME/.tmux.conf $basePath/config
# cp $HOME/.config/yazi $basePath/config/yazi
# cp $HOME/.config/starship.toml $basePath/config
# cp $HOME/.config/zellij/config.kdl $basePath/config/zellij/config.kdl
# cp $HOME/Library/Containers/org.atelierInmu.inputmethod.vChewing/Data/Library/Application\ Support/vChewing $basePath/config/vChewing

unset basePath
