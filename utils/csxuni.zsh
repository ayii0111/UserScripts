#! /bin/zsh

# 別名 csxuni: 一鍵移除所有 VSCode 擴展

# 列出所有已安裝的擴展並逐個移除
cursor --list-extensions | while read extension; do
  echo "正在移除擴展: $extension"
  # cursor --uninstall-extension "$extension"
  code --uninstall-extension "$extension"
done

echo "code 所有擴展已成功移除！"


# 執行 Developer: Reload Window with Extensions Disabled 指令來刪除所有擴展的緩存
osascript <<EOF
tell application "Visual Studio Code"
  activate
  delay 0.5
  tell application "System Events"
    keystroke "p" using {command down, shift down} -- 打開命令面板
    delay 0.5
    keystroke "Developer: Reload Window with Extensions Disabled" -- 鍵入指令
    delay 0.5
    key code 36 -- 按下 Enter 鍵
  end tell
end tell
EOF

