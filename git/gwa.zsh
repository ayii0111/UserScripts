#! /bin/zsh



# gwa 腳本：建立分支目錄
# gwa <指定分支>：若本地分支存在優先以其建立，若不存在則將遠端分支儲存成本分支後再建立
# 優先指定本地區塊中的分支，將其建立在同一父層目錄下
# 若指定分支不存在於本地分支區塊，則更新遠端分支到追蹤分支，在將追蹤分支儲存在一個本地分支中，再建立分支目錄


# git worktree add 新目錄路徑 [本地分支]
# 可以將一個本地分支，建立在一個新目錄路徑上
# 若無本地分支參數時，則默認會使用當前分支 (等於開了一個與當前分支相同的新目錄)




local localBranchs=($(git branch | gsed -E "s|..([a-zA-Z0-9_-]*)$|\1|"))
if (( $localBranchs[(I)$1] )) {
  currentDir=${$(pwd):t}
  git worktree add ../$currentDir\($1\) $1
  return 0
}

# 先更新遠端分支到追蹤分支
git fetch
trackBranchs=$(git branch -r)
# print -l $trackBranchs # 檢視追蹤分支
if [[ $1 == *$trackBranchs* ]] {
  trackBranch=$(echo -e "$trackBranchs" | grep "$1")
  # 從追蹤分支中撿出到本地分支
  git checkout -b $1 $trackBranch
  currentDir=${$(pwd):t}
  git worktree add ../$currentDir\($1\) $1
  return 0
}

