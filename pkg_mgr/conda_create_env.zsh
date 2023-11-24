#! /bin/zsh

# 別名 concr 版本號
# 可在專案目錄中建立 python 版本與環境，讓所有的套件都儲存在該目錄下
# 可以自動將該專案目錄納管，讓每次切換到該目錄時，可以自動啟用環境
# 設定命令提示符顯示當前環境時，可以簡潔

# 在專案目錄內，指定 python版本，來建立 conda環境
conda create --prefix . python=$1
local env=$(pwd)

# 僅保留專案目錄名稱
env="${env/$HOME\/}"

# 寫入環境管理的清單
echo $env >> ~/UserConfig/conda_env


# 套用該環境以前，先修改設定，讓命令提示符變為簡潔
conda config --set env_prompt '({name}) '

# 立即登入專案環境
conda activate ./


unset env