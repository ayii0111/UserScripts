#! /bin/zsh

# 本函式的依賴：currentCmd
_onGitInit() {
  (($lastStatus != 0)) && return $lastStatus
  [[ $currentCmd != *git\ init* ]] && return 0

  echo "" >README.md

  local fileContent="$(<.gitignore)"
  if [[ $fileContent != *node_modules* ]]; then
    echo "node_modules" >>.gitignore
  fi
  if [[ $fileContent != *.DS_Store* ]]; then
    echo ".DS_Store" >>.gitignore
  fi
  if [[ $fileContent != *.vscode* ]]; then
    echo ".vscode" >>.gitignore
  fi

  git add .
  git commit -m "init"
  echo 已經完成 init 提交！

}

add-zsh-hook precmd _onGitInit
