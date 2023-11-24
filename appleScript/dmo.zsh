#! /bin/zsh

# 別名 dmo: 切換 Mac系統為深色模式
# 切換到夜晚

echo -e "  切換到深色模式 🌙" # 月亮
sleep 1
osascript -e 'tell app "System Events" to tell appearance preferences to set dark mode to true'
export BAT_THEME="1337"
