#! /bin/zsh

# 別名 bcon
# 全稱 backup config
# 設定檔的備份，包含 vscode、snippets、.zshrc骨幹

# 透過自製的 mp指令，將設定檔備份管理
cp $HOME/.zshrc $HOME/UserConfig/
cp "$HOME/Library/Application Support/Code/User/settings.json" $HOME/UserConfig/vsCode/
cp "$HOME/Library/Application Support/Code/User/keybindings.json" $HOME/UserConfig/vsCode/
cp $HOME/Library/Application\ Support/Code/User/snippets  $HOME/UserConfig/vsCode/snippets
cp $HOME/.tmux.conf $HOME/UserConfig
cp $HOME/.config/yazi $HOME/UserConfig/config/yazi
cp $HOME/.config/starship.toml $HOME/UserConfig/config
cp $HOME/.config/zellij/config.kdl $HOME/UserConfig/config
cp $HOME/Library/Containers/org.atelierInmu.inputmethod.vChewing/Data/Library/Application\ Support/vChewing $HOME/UserConfig/config/vChewing

