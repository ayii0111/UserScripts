#!/bin/zsh
# 別名 telp: 移動當前目錄，到指定目錄中，並跳轉過去到移動後的目錄中
# telp 即 teleport
# telp <目標目錄>
# 參數路徑，會依情況轉為絕對路徑
# 使用 undo 函式可以恢復上一步的移動動作

# 該指令的限制條件：
# 需有參數
# 參數路徑的沿途路徑需存在
# 參數路徑下面，不能有相同檔案或目錄
# 參數路徑，不可以經過當前路徑（這樣要將當前路徑帶過去時，會拉扯到目的地目錄的路徑）

# 儲存上一次的目錄狀態
[[ ! $1 ]] && echo "Error: 請提供一個目標路徑。" >&2 && return 1

local oldPath
local newPath
local targetPath="$1"

# 如果路徑是相對路徑（不以 / 或 ~ 開頭），將其轉換為絕對路徑
if [[ $targetPath != /* && $targetPath != ~* ]]; then
  targetPath="$(pwd)/$targetPath"
fi

# 展開 ~ 為用戶主目錄的絕對路徑
targetPath=${targetPath/#\~/$HOME}

# 儲存當前目錄作為舊路徑
oldPath=$(pwd)

# 檢查目標路徑是否是當前目錄的子目錄
if [[ $targetPath == $oldPath* ]]; then
  echo "Error: 目標路徑 '$targetPath' 是當前目錄的子目錄，無法移動。" >&2
  return 1
fi

# 檢查沿途的目錄是否存在
local parentPath=${targetPath%/*} # 取得父目錄路徑
if [[ ! -d $parentPath ]]; then
  echo "Error: 沿途的目錄 '$parentPath' 不存在。" >&2
  return 1
fi

# 檢查目標目錄下是否已存在相同名稱的文件或目錄
local currentDirName=${oldPath##*/} # 取得當前目錄名稱
if [[ -e $parentPath/$currentDirName ]]; then
  echo "Error: 目標路徑 '$parentPath' 已存在相同名稱的文件或目錄 '$currentDirName'。" >&2
  return 1
fi

# 設定新路徑為目標路徑
newPath=$targetPath

echo "原路徑: $oldPath"
echo "新路徑: $newPath"

# 移動目錄並跳轉
mv "$oldPath" "$newPath"
if [[ $? == 0 ]]; then
  echo "Error: 移動目錄失敗。" >&2
  return 1
fi

# 確保移動到目標目錄中的相同名稱子目錄
cd "$newPath/$currentDirName" || return 1
echo "成功移動並跳轉到 '$newPath/$currentDirName'"

# 定義撤銷函式
function undo() {
  # 執行後銷毀函式 (在各別環境中僅一次性調用)
  unset -f undo
  if [[ ! $oldPath || ! $newPath ]]; then
    echo "Error: 沒有可以撤銷的移動操作" >&2
    return 1
  fi

  # 撤銷目錄移動
  mv "$(pwd)" "${oldPath%/*}"
  ! (($? == 0)) && echo "Error: 撤銷操作失敗。" >&2 && return 1
  cd "$oldPath"
  echo "已撤銷移動，返回到原目錄 '$oldPath'。"
  unset oldPath newPath
}
