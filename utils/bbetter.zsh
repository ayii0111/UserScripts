#!/bin/zsh

# 設定備份目標目錄，預設為 ~/Backup/BetterAndBetter
BACKUP_DIR="$HOME/UserConfig/config/better_config"

# 源文件和目錄列表
declare -a SOURCE_PATHS=(
  "$HOME/Library/Preferences/cn.better365.BetterAndBetter.plist"
  "$HOME/Library/Application Support/BetterAndBetter/"
  "$HOME/Library/Application Support/cn.better365.BetterAndBetter/"
)

# 建立備份目錄（若不存在）
mkdir -p "$BACKUP_DIR"

# 備份每個文件和目錄
for SOURCE_PATH in "${SOURCE_PATHS[@]}"; do
  if [[ -e "$SOURCE_PATH" ]]; then
    echo "正在備份 $SOURCE_PATH 到 $BACKUP_DIR"
    cp "$SOURCE_PATH" "$BACKUP_DIR"
  else
    echo "警告: 找不到 $SOURCE_PATH，跳過此項目"
  fi
done

echo "備份完成！檔案已備份至 $BACKUP_DIR"
