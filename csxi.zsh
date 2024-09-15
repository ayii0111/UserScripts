#!/bin/zsh

# 別名 csxi: cursor 擴展安裝

# 讀取插件列表文件
PLUGIN_FILE="$HOME/UserConfig/vsCode/extensionsList"

# 確保文件存在
if [[ ! -f "$PLUGIN_FILE" ]]; then
  echo "找不到文件: $PLUGIN_FILE" 2>&1
  return 1
fi

# 逐行安裝插件
while IFS= read -r extension || [[ -n "$extension" ]]; do
  echo "安裝擴展: $extension"
  cursor --install-extension "$extension"
done <"$PLUGIN_FILE"

echo "cursor 所有擴展已安裝完成！"
