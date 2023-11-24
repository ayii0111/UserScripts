#! /bin/zsh

# vfontA 腳本
# 快速安裝配置 Font Awesome 套件
# 有機會再回來寫自動匯入 <FontAwesomeIcon> 元件的部分

# 核心
npm i @fortawesome/fontawesome-svg-core

# 免費套件
npm i @fortawesome/free-solid-svg-icons
npm i @fortawesome/free-regular-svg-icons
npm i @fortawesome/free-brands-svg-icons

# 整合 vue
npm i @fortawesome/vue-fontawesome@latest-3


local import="
import { library } from '@fortawesome/fontawesome-svg-core'
import { fas } from '@fortawesome/free-solid-svg-icons'
import { fab } from '@fortawesome/free-brands-svg-icons'
import { far } from '@fortawesome/free-regular-svg-icons'
import { FontAwesomeIcon } from '@fortawesome/vue-fontawesome'
library.add(fas, fab, far)
"
# 可避免字串變數中的換行，造成 gsed 無法寫入
local import=$(echo "$import" | gsed ':a;N;$!ba;s/\n/\\n/g')

local underapp="
app.component('FontAwesomeIcon', FontAwesomeIcon)
"
# 可避免字串變數中的換行，造成 gsed 無法寫入
underapp=$(echo "$underapp" | gsed ':a;N;$!ba;s/\n/\\n/g')

local file=$(getMatchedFile "./src/main")
if [[ ! $file ]] return 1

# $import 變數為 createApp(App) 那一行以上要插入的
# $underapp 變數則為 app.mount('#app') 那行上面插入
gsed -i "/createApp(App)/,\$! {/^$/d}
0,/createApp(App)/{// s|^|$import\n\n\n|}
/createApp(App)/,/app.mount('#app')/ {/^$/d}
0,/app.mount('#app')/{// s|^|$underapp\n\n\n|}" $file

unset import underapp file