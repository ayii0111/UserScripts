#! /bin/zsh
# 別名 vpriv: 快速安裝配置 primevue (還沒完成，找時間再做)
(
  checkNoInst primevue || return 1
  npm i primevue
  npm i @primevue/themes
  npm i unplugin-vue-components -D
  npm i @primevue/auto-import-resolver -D
  npm i tailwindcss-primeui

  local mainImp="import PrimeVue from 'primevue/config';
import Aura from '@primevue/themes/aura';
"
  local mainAppUse="app.use(PrimeVue, {
  // Default theme configuration
  theme: {
    preset: Aura,
    options: {
      // 設定主題所屬 css變數、class 的前綴
      // 例如 --p-primary-color
      prefix: 'p',
      // 深色模式隨瀏覽器決定
      darkModeSelector: 'system',
      // 框架 @layer 設定
      cssLayer: false
    }
  }
})
"

  insertMainfile $mainImp $mainAppUse
)
