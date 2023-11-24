#! /bin/zsh

# 本函式的依賴：currentCmd、disablePWD
_preGitInit() {
  [[ $currentCmd != *git\ init* ]] && return 0
  # 由於 add-zsh-hook 內禁止直接使用別名，故應如此
  zsh -ic "disablePWD $HOME" || {
    kill -INT $$ # 撤銷當前指令
    return 1
  }
}
_postGitInit() {
  [[ $currentCmd != *git\ init* ]] && return 0 # 若不是 git init 指令，則不做任何事
  [[ -d .git ]] || return 1                    # 若沒有 .git 目錄，表示 init 失敗，故不做任何事
  (($lastStatus)) && return 1                  # 若上一個命令的 exit status 非 0，表示 init 失敗，故不做任何事

  echo "" >README.md

  [[ -f .gitignore ]] && {
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
  }
  git add .
  git commit -m "init"
  echo 已經完成 init 提交！

}

add-zsh-hook preexec _preGitInit
add-zsh-hook precmd _postGitInit
