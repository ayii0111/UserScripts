#!/bin/zsh
# 別名 telp: 移動到指定目錄並跳轉過去
# 即 teleport
# 參數路徑，皆會自動轉為絕對路徑（沒有好好的測試過）
# 使用 undo 可以恢復上一步的移動動作

# 驗證
# 需有參數
# 參數路徑的沿途路徑需存在
# 參數路徑下面，不能有相同檔案或目錄
# 參數路徑，不可以經過當前路徑（這樣要將當前路徑帶過去時，會拉扯到目的地目錄的路徑）

# 儲存上一次的目錄狀態
local oldPath=""
local newPath=""

local tgtPath="$1"

# 檢查是否提供了路徑參數
if [[ -z "$tgtPath" ]]; then
  echo "請提供一個目標路徑。"
  return 1
fi

# 如果路徑是相對路徑（不以 / 或 ~ 開頭），將其轉換為絕對路徑
if [[ "$tgtPath" != /* && "$tgtPath" != ~* ]]; then
  tgtPath="$(pwd)/$tgtPath"
fi

# 展開 ~ 為用戶主目錄的絕對路徑
tgtPath="${tgtPath/#\~/$HOME}"

# 儲存當前目錄作為舊路徑
oldPath="$(pwd)"

# 檢查目標路徑是否是當前目錄的子目錄
if [[ "$tgtPath" == "$oldPath"* ]]; then
  echo "目標路徑 '$tgtPath' 是當前目錄的子目錄，無法移動。"
  return 1
fi

# 檢查沿途的目錄是否存在
local parentPath="${tgtPath%/*}" # 取得父目錄路徑
if [[ ! -d "$parentPath" ]]; then
  echo "沿途的目錄 '$parentPath' 不存在。"
  return 1
fi

# 檢查目標目錄下是否已存在相同名稱的文件或目錄
local currentDirName="${oldPath##*/}" # 取得當前目錄名稱
if [[ -e "$parentPath/$currentDirName" ]]; then
  echo "目標路徑 '$parentPath' 已存在相同名稱的文件或目錄 '$currentDirName'。"
  return 1
fi

# 設定新路徑為目標路徑
newPath="$tgtPath"

echo "原路徑: $oldPath"
echo "新路徑: $newPath"

# 移動目錄並跳轉
mv "$oldPath" "$newPath"
if [[ $? -ne 0 ]]; then
  echo "移動目錄失敗。"
  oldPath=""
  newPath=""
  return 1
fi

# 確保移動到目標目錄中的相同名稱子目錄
cd "$newPath/$currentDirName" || return 1
echo "成功移動並跳轉到 '$newPath/$currentDirName'。"

# 定義撤銷函式
function undo() {
  if [[ -z "$oldPath" || -z "$newPath" ]]; then
    echo "沒有可以撤銷的移動操作。"
    return 1
  fi

  # 撤銷目錄移動
  mv "$(pwd)" "${oldPath%/*}"
  if [[ $? -eq 0 ]]; then
    cd "$oldPath"
    echo "已撤銷移動，返回到原目錄 '$oldPath'。"
    oldPath=""
    newPath=""

    # 撤銷成功後註銷函式
    unset -f undo
  else
    echo "撤銷操作失敗。"
    return 1
  fi
}
