function _onGitClone() {
  # 檢查是否為 git clone 指令
  if [[ $1 == git\ clone\ * ]]; then
    # 提取要克隆的目錄名稱
    local repoUrl repoDir
    repoUrl=${1##* }
    repoDir=$(basename $repoUrl .git)

    # 執行原始指令
    eval $1

    # 檢查克隆是否成功
    if [[ -d $repoDir ]]; then
      echo " clone 成功，進入目錄 $repoDir"
      cd $repoDir
    else
      echo "Error: clone 失敗" >&2
    fi
  fi
}

# 添加 preexec 鉤子
# add-zsh-hook preexec _onGitClone