#!/bin/zsh

# 設定備份來源目錄，預設為 ~/Backup/BetterAndBetter
BACKUP_DIR="$HOME/UserConfig/config/better_config"

# 源文件和目錄列表（與備份腳本相同）
declare -a SOURCE_PATHS=(
  "$HOME/Library/Preferences/cn.better365.BetterAndBetter.plist"
  "$HOME/Library/Application Support/BetterAndBetter/"
  "$HOME/Library/Application Support/cn.better365.BetterAndBetter/"
)

# 還原每個文件和目錄
for SOURCE_PATH in "${SOURCE_PATHS[@]}"; do
  BASENAME=$(basename "$SOURCE_PATH")
  BACKUP_PATH="$BACKUP_DIR/$BASENAME"

  if [[ -e "$BACKUP_PATH" ]]; then
    echo "正在還原 $BACKUP_PATH 到 $SOURCE_PATH"
    cp -R "$BACKUP_PATH" "$SOURCE_PATH"
  else
    echo "警告: 找不到備份文件 $BACKUP_PATH，跳過此項目"
  fi
done

echo "還原完成！檔案已從 $BACKUP_DIR 還原"
