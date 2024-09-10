#! /bin/zsh

# 別名 lmo: 切換 Mac系統為淺色模式
# 切換到白天

echo -e "  切換為淺色模式 ✨"
sleep 1
osascript -e 'tell app "System Events" to tell appearance preferences to set dark mode to false'
export BAT_THEME="GitHub"
