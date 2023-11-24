#! /bin/zsh

# 本函式的依賴：currentCmd
gitInitPlus() {
  if [[ $currentCmd == *git\ init* ]]; then
    echo "" >README.md

    filecontent="$(<.gitignore)"
    if [[ $filecontent != *node_modules* ]]; then
      echo "node_modules" >>.gitignore
    fi
    if [[ $filecontent != *.DS_Store* ]]; then
      echo ".DS_Store" >>.gitignore
    fi
    if [[ $filecontent != *.vscode* ]]; then
      echo ".vscode" >>.gitignore
    fi

    git add .
    git commit -m "init"
    echo 已經完成 init 提交！
  fi
}

add-zsh-hook precmd gitInitPlus
