#! /bin/zsh
autoload -Uz add-zsh-hook
typeset -g lastStatus
source $HOME/UserScripts/zsh_hook/preec/recordLastStatus.zsh # 存取上次執行結果
source $HOME/UserScripts/zsh_hook/preec/recordLastDir.zsh    # 存取最後使用的工作目錄
typeset -g currentCmd
typeset -g lastCmd
typeset -g lastSuccessCmd
typeset -g lastFailCmd
source $HOME/UserScripts/zsh_hook/preec/recordLastCmd.zsh # 存取上次執行的指令
source $HOME/UserScripts/zsh_hook/preec/onGitInit.zsh     # 自動初始化 git 環境
source $HOME/UserScripts/zsh_hook/preec/onGitClone.zsh    # clone 後自動進入目錄
source $HOME/UserScripts/zsh_hook/preec/loadNvmrc.zsh     # 切換目錄時，自動載入 .nvmrc 環境
