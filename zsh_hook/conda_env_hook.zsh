#! /bin/zsh
conda_env_in() {
  local cmd=$lastCmd

  # 出去目錄時，自動退出 conda 環境
  if [[ $cmd == cd ]] {
    conda deactivate
  }

  # 進入目錄時，自動切換 conda 環境
  if [[ $cmd == cd\ * ]] {
    local env_arr=($(cat ~/UserConfig/conda_env))

    local dir=$(pwd)

    # 取出當前目錄的名稱
    dir=${dir:t}

    if (( $env_arr[(Ie)$dir] )) {
      conda activate ./
    }
  }
  unset cmd env_arr dir
}

add-zsh-hook precmd conda_env_in