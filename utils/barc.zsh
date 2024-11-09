#!/bin/zsh

# 設定 Arc 配置目錄和備份目錄
ARC_CONFIG_DIR="$HOME/Library/Application Support/Arc"
BACKUP_DIR="$HOME/UserConfig/config/arc_config"

# 確保備份目錄存在，若不存在則創建
mkdir -p "$BACKUP_DIR"

# 複製所有配置檔案到備份目錄
cp $ARC_CONFIG_DIR/* "$BACKUP_DIR/"

echo "已成功將 Arc 配置檔案備份到 $BACKUP_DIR"
