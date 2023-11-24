#! /bin/zsh

# 別名 vconf
# 1. npm run dev自動打開瀏覽器
# 2. eslint 的 rules 設定
# 3. 修改 .prettierrc.json 讓 scss 禁用轉換單引號
# 4. 解決 import App from './App.vue' ts檢查報錯

source $HOME/UserScripts/vite/viteConfig/autoOpenBrowser.zsh
source $HOME/UserScripts/vite/viteConfig/configESLintRules.zsh
source $HOME/UserScripts/vite/viteConfig/configPrettierRules.zsh
source $HOME/UserScripts/vite/viteConfig/fixAppvueTsError.zsh