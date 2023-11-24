#! /bin/zsh

# 別名 cs: cursor 的 CLI
# 無參數時，默認打開當前目錄 (若當前目錄為特殊目錄，還會額外打開指定檔案)

# 若有參數，按照原始方式帶入參數
[[ $1 ]] && cursor $* && return 0

# basename "$PWD" 可取得當前目錄名稱
currentDir=$(basename "$PWD")
case $currentDir in
  "UserScripts")
    # 2> /dev/null 避免輸出--no-restore的 bug報錯
    cursor --no-restore . ~/UserConfig/zsh_config/alias_script.zsh ~/UserConfig/zsh_config/alias_cmd.zsh ~/UserConfig/zsh_config/alias_git.zsh 2>/dev/null
    ;;
  "UserConfig")
    cursor --no-restore . ~/UserConfig/zsh_config/alias_script.zsh ~/UserConfig/zsh_config/alias_cmd.zsh ~/UserConfig/zsh_config/alias_git.zsh 2>/dev/null
    ;;
  *)
    cursor .
    if [[ -f "vite.config.js" || -f "vite.config.ts" ]]; then

      # 背景執行 相當於 npm run dev 的指令效果
      npx vite --no-open >/dev/null &

      # 等待兩秒來啟動相關配置後，在將背景執行的 npr dev 結束
      sleep 2
      kill -9 %+
    fi
    ;;
esac
