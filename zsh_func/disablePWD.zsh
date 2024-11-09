#! /bin/zsh
# 別名 disablePWD: 確認當前目錄是否為指令目錄
# 用來限制當前目錄，是否禁用當前腳本
# 用法  disablePWD 關鍵字 || return 1

# 指令禁用目錄： disablePWD <關鍵字1> [關鍵字2] ...
# 指令允許目錄： disablePWD <關鍵字1> [關鍵字2] -a <關鍵字1> [關鍵字2]

# 尚未添加的功能 !!!!!!!!!!!!!!!!
# 當前目錄中包含指第檔案者，禁用指令: disablePWD <關鍵字1> [關鍵字2] ... -ic <檔名>
# 當前目錄中包含指第檔案者，允許指令: disablePWD <關鍵字1> [關鍵字2] ...-a <關鍵字> -ic <檔名>
# 當前目錄中包含指第檔案者，允許指令: disablePWD <關鍵字1> [關鍵字2] ...-aic <檔名>
(
  (($# == 0)) && echo "Error: disablePWD 請輸入至少一個參數" >&2 && return 1
  local allowDirs=()
  local disableDirs=()
  local allowOption=false
  # 解析參數
  while [[ $1 ]]; do
    if [[ $1 == "-a" ]]; then
      allowOption=true
      shift
      [[ ! $1 ]] && echo "Error: disablePWD 選項 -a 請輸入至少一個參數" >&2 && return 1
      continue
    fi
    if [[ $allowOption == true ]]; then
      allowDirs+=($1)
    else
      disableDirs+=($1)
    fi
    shift
  done
  # 判斷是否在允許目錄中
  for dir in "$allowDirs"; do
    [[ ! $dir ]] && continue
    [[ $PWD == *$dir* ]] && return 0
  done
  # 判斷是否在禁用目錄中
  for dir in $disableDirs; do
    # 先檢查完整路徑，再檢查關鍵字
    if [[ -d "$dir" ]]; then
      [[ $PWD == $dir ]] && echo "Error: 當前指令禁用於「當前目錄」...(禁用匹配為: $dir)" >&2 && return 1
    else
      [[ $PWD == *$dir* ]] && echo "Error: 當前指令禁用於「當前目錄」...(禁用匹配為: $dir)" >&2 && return 1
    fi
  done
  return 0
)
