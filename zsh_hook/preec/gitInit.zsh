#! /bin/zsh


# 本函式的依賴：currentCmd
gitInit() {
  if [[ $currentCmd == git\ init ]] {
    echo "" > README.md

    filecontent="$(<.gitignore)"
    if [[ $filecontent != *node_modules* ]] {
      echo "node_modules" >> .gitignore
    }
    if [[ $filecontent != *.DS_Store* ]] {
      echo ".DS_Store" >> .gitignore
    }
    if [[ $filecontent != *.vscode* ]] {
      echo ".vscode" >> .gitignore
    }

    git add .; git commit -m "init"
    echo 已經完成 init 提交！
  }
}

add-zsh-hook precmd gitInit