# 自定義一個新的 ZLE 小工具，來處理 Shift + Enter 鍵
function save_last_oput() {
  # 取得當前的命令
  local cmd="$BUFFER"

  # 為命令追加我們的處理邏輯
  BUFFER="$cmd SaveOput"

  # 執行並清除當前輸入
  zle accept-line
}

# 將自定義工具綁定到 Shift + Enter，通常 Shift + Enter 是 ^M
zle -N save_last_oput
bindkey "\033[13;2u" save_last_oput
