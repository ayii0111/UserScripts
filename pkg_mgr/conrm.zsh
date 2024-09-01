#! /bin/zsh

# 別名 conrm
# conda_remove_env
# 將當前專案目錄環境，刪除並從內管名單中移除

local env_file="$HOME/UserConfig/conda_env"
local env_arr=($(< $env_file))
local env=$(pwd)
env="${env/$HOME\/}"

# I 是最大匹配，若元素不存在，會回傳 0
# e 是精確匹配，會對大小寫敏感
if (( $env_arr[(Ie)$env] )) {

  # 登出專案環境
  conda deactivate

  # 刪除該轉專案環境
  rm -fr ./{man,share,ssl,include,lib,bin,conda-meta}

  # 從環境管理清單中移除
  gsed -i "/^$env$/d" $env_file
}

unset env_file env_arr env
