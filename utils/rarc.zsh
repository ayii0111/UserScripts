#!/bin/zsh

# 設定 Arc 配置目錄和備份目錄
ARC_CONFIG_DIR="$HOME/Library/Application Support/Arc"
BACKUP_DIR="$HOME/UserConfig/config/arc_config"

# 檢查備份目錄是否存在
if [[ ! -d "$BACKUP_DIR" ]]; then
  echo "備份目錄 $BACKUP_DIR 不存在，無法恢復配置。"
  exit 1
fi

# 將備份目錄中的檔案複製回原始配置路徑
/bin/cp -R "$BACKUP_DIR/"* "$ARC_CONFIG_DIR/"

echo "已成功恢復 Arc 配置檔案到 $ARC_CONFIG_DIR"
