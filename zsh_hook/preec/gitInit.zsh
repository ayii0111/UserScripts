#! /bin/zsh


# 本函式的依賴：currentCmd
gitInit() {
  if [[ $currentCmd == git\ init ]] {
    echo "" > README.md
    git add .; git commit -m "init"
  }
}

add-zsh-hook precmd gitInit