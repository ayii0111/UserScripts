#! /bin/zsh


# gcdi 腳本：比對當前檔案狀態與各種提交狀態的差異

# 無參數時，默認比對當前所有檔案與當前提交狀態差異
# gcdi [檔案]：比對當前指定檔案，與當前提交狀態的差異
# gcdi [提交]：比對當前所有檔案，與指定提交的差異
# gcdi [提交] [檔案]：比對當前指定檔案，與指定提交的差異

case $# in
  0)
    git difftool --extcmd icdiff HEAD -- ./
    ;;
  1)
    if [[ -f $1 ]] {
      git difftool --extcmd icdiff HEAD -- $1
    } else {
      git difftool --extcmd icdiff $1 -- ./
    }
    ;;
  *)
    if [[ -f $1 ]] {
      git difftool --extcmd icdiff HEAD -- $*
    } else {
      arr=($*)
      arr[1]=()
      git difftool --extcmd icdiff $1 -- $arr
    }
    ;;
esac