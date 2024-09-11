#! /bin/zsh

# gcld 腳本：載入歷史提交
# gcld [提交] [檔案]：可指定檔案，來載入歷史提交的檔案狀態
# 無參數時，所有檔案都會被載入當前提交狀態
# 僅有提交參數時，將所有檔案載入該提交狀態
# 僅有檔案參數時，將該檔案載入當前提交狀態

case $# in
  0)
    git checkout HEAD -- ./
    ;;
  1)
    if [[ -f $1 ]]; then
      # 僅指定一個檔案，會載入當前提交
      git checkout HEAD -- $1
    else
      # 僅指定某歷史提交，會載入所有檔案
      git checkout $1 -- ./
    fi
    ;;
  *)
    # 僅指定多個檔案，會載入當前提交
    if [[ -f $1 ]]; then
      git checkout HEAD -- $*
    else
      # 指定提交與多個檔案
      arr=($*)
      # arr[1]=() 若下面做法產生 bug 在改回來
      unset 'arr[1]'
      git checkout $1 -- $arr
    fi
    ;;
esac
