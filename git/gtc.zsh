#!/bin/zsh

# gtc 腳本
# 測試時使用，可以快速建立多次提交、快速新建檔案、累計提交次數
# gtc [提交次數]：會直接快速建立提交至指定次數
# gtc：無參數時，默認會新建檔案，第二次無參數使用時，會建立一個新的提交，並計數

# 僅允許在 ～/git-test 目錄下操作
if [[ ! $(pwd) == $HOME/git-test ]]; then
  echo "error: 當前目錄非 git-test 目錄" >&2
  return 1
fi

# 定義一個函數來檢查參數是否為數字
is_number() {
  [[ $1 =~ '^[0-9]+$' ]] && echo 1 || echo 0
}

# 取得當前分支名稱，並建立動態變數
local current_branch=$(git branch --show-current)
local dynVar=$current_branch
# 檢驗動態變數中的分支名稱的變數是否存在
# 若不存在則使用分支名稱建立一個變數，並儲存初始次數為 0
eval "if ((! $+$dynVar)) {
      $dynVar=0
      }
    "
eval "local count=\$$dynVar"

case $# in
  0)
    ((count++))
    echo $dynVar" : commit "$count >$dynVar"_file-"$count
    git add . && git commit -m $dynVar": commit "$count
    eval "$dynVar=$count"

    ;;
  1)
    if [[ $1 == --reset ]]; then
      # 重置當前分支的提交次數
      # 每次初次在某一分支上提交時，先重置，因為可能之前提交過，分支次數的狀態還保存著
      eval "unset current_branch $dynVar dynVar count"
      return 0
    fi
    if ((!$(is_number $1))); then
      # 若非 --reset 時，驗證參數是否為數字
      echo "錯誤：參數必須是一個數字" >&2
      return 1
    fi

    local _count=$1
    # 若動態變數的值，小於第二參數的數字 > 符合條件，會開始建立檔案以及進行 commit行為
    # 反之不小於第二參數的數字 > 不符合條件，會顯示當前分支與已經提交的次數
    if (($count >= $_count)); then
      eval "echo 當前 \$dynVar 已經提交到 commit:\$$dynVar"
      return 1
    fi
    ((count++))
    for i in {$count..$_count}; do
      echo $dynVar" : commit "$i >$dynVar"_file-"$i
      git add . && git commit -m $dynVar": commit "$i

    done
    # 將當前的提交次數，回存到動態變數中
    eval "$dynVar=$_count"
    ;;
  *)
    # 直接報錯顯示，提示要輸入前面的兩種格式
    echo "錯誤：
    gtc --reset # 當前分支次數狀態重置
    gtc 無參數 # 僅單次提交
    gtc 提交次數 # 連續提交多次
    "
    ;;
esac

eval "unset current_branch dynVar count _count"
