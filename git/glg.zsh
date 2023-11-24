#! /bin/zsh

# glg 腳本：圖形化分支提交歷史
# glg [分支1 分支2]  可僅檢視指定分支提交歷史 (追蹤分支格式： 遠端倉庫/追蹤分支)
# glg [分支]  若僅使用一個分支參數時，同時檢視本地分支與追蹤分支 (可用於比較兩個分支的歷史)
# glg  無參數時，顯示所有分支提交歷史


if (( ! $+1 )) {
  # local trackingBranch=$(git rev-parse --abbrev-ref --symbolic-full-name @{u})
  local currentBranch=$(git rev-parse --abbrev-ref HEAD)
  local trackingBranch=$(git branch -r | gsed -n "/$currentBranch/ p")
  local trackingBranch="${trackingBranch##*( )}" # 去除左邊空白
  git log --oneline --graph $currentBranch $trackingBranch
} elif [[ $1 == -a ]] {
  # 直接顯示與 git graph 相同的圖形化歷史
  git log --oneline --graph --all
} elif (( ! $+2 )) {
  local trackingBranch=$(git rev-parse --abbrev-ref --symbolic-full-name $1"@{u}")
  git log --oneline --graph $1 $trackingBranch
} elif (( ! $+3 )) {
  git log --oneline --graph $1 $2
} else {
  echo "錯誤：請最多指定兩個分支" >&2
  return 1
}
