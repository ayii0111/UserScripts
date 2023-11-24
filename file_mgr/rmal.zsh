#! /bin/zsh

# 別名 rmal: 刪除當前目錄所有檔案目錄
# remove_all
# 可以直接刪除當前所在目錄，並退回到父目錄中
# 支援在 conda 專案目錄的刪除時，會先移除專案環境納管


local env_file="$HOME/UserConfig/conda_env"
local env_arr=($(< $env_file))

# 取得當前目錄名稱
local dir=${$(pwd):t}

if (( $env_arr[(Ie)$dir] )) {
  conda deactivate

  # 刪除該轉專案環境
  rm -fr ./{man,share,ssl,include,lib,bin,conda-meta}

  # 從環境管理清單中移除
  gsed -i "/^$env$/d" $env_file
}

cd ..
rm -rf $dir




unset dir env_arr env_file
