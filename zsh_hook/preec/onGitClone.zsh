function _onGitClone() {
  (($lastStatus != 0)) && return $lastStatus
  [[ $currentCmd != *git\ clone\ * && $currentCmd != *gh\ clone\ * ]] && return 0

  local repoName=""
  repoName=${currentCmd##*/}
  repoName=${repoName%.*}
  cd $repoName
}

add-zsh-hook precmd _onGitClone
