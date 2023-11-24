#!/bin/zsh

# gtc 腳本
# 測試時使用，可以快速建立多次提交、快速新建檔案、累計提交次數
# goo [提交次數]：會直接快速建立提交至指定次數
# goo：無參數時，默認會新建檔案，第二次無參數使用時，會建立一個新的提交，並計數


if [[ ! $(pwd) == $HOME/git-test ]] {
  echo "error: 當前目錄非 git-test 目錄" >&2
  return 1
}

# 定義一個函數來檢查參數是否為數字
is_number() {
  [[ $1 =~ '^[0-9]+$' ]] && echo  1  || echo 0
}




case $# in
  0)
    local current_branch=$(git branch --show-current)
    # 建立一個動態變數
    # 用來儲存分支名稱以及提交次數
    local dynVar=$current_branch

    # 檢驗動態變數中的分支名稱的變數是否存在
    # 若不存在則使用分支名稱建立一個變數，並儲存初始次數為 0
    eval "if ((! $+$dynVar)) {
      $dynVar=0
      }
    "

    # 將分支提交次數從動態變數中取出以方便操作
    eval "_count=\$$dynVar"
    local count=$(( _count +1 ))

    # 檢視是否已經建立了變動檔案，若沒有則建立變動檔後，跳出函式
    # 若已經建立了變動檔案，則往下繼續執行，以建立提交
    local file=$dynVar"_file-"$count
    if [[ ! -f $file ]]; then
      echo $dynVar" : commit "$count > $file
      # 跳出函式
      return 0
    fi
    git add . && git commit -m "commit $count"
    # 將當前的提交次數，回存到動態變數中
    eval "$dynVar=$count"
    # 跳出函式
    return 0
    ;;
  1)
    if [[ $1 == --reset ]] {
      local current_branch=$(git branch --show-current)
      local dynVar=$current_branch
      eval "$dynVar=0"
      return 0
    } elif (( ! $(is_number $1) )) {
      echo "錯誤：參數必須是一個數字" >&2
      return 1
    }

    # 取得當前分支名稱
    local current_branch=$(git branch --show-current)
    # 建立一個動態變數
    local dynVar=$current_branch
    local count=$1

    # 檢驗動態變數中的分支名稱的變數是否存在
    # 若不存在則使用分支名稱建立一個變數，並儲存初始次數為 0
    eval "if ((! $+$dynVar)) {
      $dynVar=0
      }
    "

    # 將分支提交次數從動態變數中取出以方便操作
    eval "_count=\$$dynVar"

    # 若動態變數的值，小於第二參數的數字 > 符合條件，會開始建立檔案以及進行 commit行為
    # 反之不小於第二參數的數字 > 不符合條件，會顯示當前分支與已經提交的次數
    if (( $_count < $count )) {
      for i ( {$_count..$count} ) {
        if ! (( i == 0 )) {
          echo $dynVar" : commit "$i > $dynVar"_file-"$i
          git add . && git commit -m $dynVar": commit "$i
        }
      }
      # 將當前的提交次數，回存到動態變數中
      eval "$dynVar=$count"
    } else {
      eval "echo 當前 \$dynVar 已經提交到 commit:\$$dynVar"
    }
    ;;
  *)
    # 直接報錯顯示，提示要輸入前面的兩種格式
    echo "錯誤：
    goo 無參數
    goo 提交次數"
    return 1
    ;;
esac