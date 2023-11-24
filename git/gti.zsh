#!/bin/zsh

# gti腳本
# 用來快速建立 git 測試環境目錄

# 應在家目錄中執行，避免在其他專案中，亂建立測試目錄
if [[ ! $(pwd) == $HOME ]]; then
  echo "error: 當前目錄非用戶家目錄" >&2
  return 1
fi

mkdir git-test
cd git-test
git init
echo "" >README.md
git add .
git commit -m "init"

# 建立遠端庫
gh repo create --private --source=. --remote=origin --push

# 在本地建立兩條分支
# b代表分支，l代表本地分支
bl2() {

  gtc --reset # 將先 gtc 函式所產生的動態變數歸 0
  gtc 6       # 建立 6 個 commit

  gch HEAD~3
  gcla hotfix
  gch hotfix
  gtc --reset
  gtc 4
}

# 在遠端建立兩個分支
br2() {
  # 建立遠端倉庫
  gtc --reset
  gtc 6
  gp

  gch HEAD~3
  gbla hotfix
  gch hotfix
  gtc --reset
  gtc 4
  gp
}

# 對於同一分支，遠端提交歷史>本地端提交歷史
flch() {
  gtc --reset
  gtc 6
  gp

  gcbt HEAD~3
}

# 同一檔案，遠端與本地端提交內容的衝突
flfc() {
  gtc --reset
  gtc 3
  gp

  gcbt HEAD^
  echo "衝突代碼" >main_file-3
  git add . && git commit -m "main: commit 3"
}
