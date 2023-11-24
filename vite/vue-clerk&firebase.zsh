#! /bin/zsh

# 未測試
# vcf 腳本
# 快速安裝配置 clerk 與 firebase
# 並整合兩者的第三方登入後，生成一個 <LoginBtn/ >元件以供使用

# 直接安裝整合道鑒(無須安裝原始 clerk 依賴)
npm i vue-clerk

echo 'VITE_CLERK_PUBLISHABLE_KEY=your_publishable_key' > .env

local importSnippet="import { clerkPlugin } from 'vue-clerk/plugin'"
local injectSnippet="app.use(clerkPlugin, {
  publishableKey: import.meta.env.VITE_CLERK_PUBLISHABLE_KEY
})"

snippetInsertMainfile $importSnippet $injectSnippet


cp $HOME/UserScripts/vite/Clerk&Firebase/LoginBtn.vue src/components


# 這裡開始 firebase 配置
npm i firebase


# 寫入 vite.config
local services="
'@services': fileURLToPath(new URL('./src/services', import.meta.url))
"

# 可避免字串變數中的換行，造成 gsed 無法寫入
services=$(echo "$services" | gsed ':a;N;$!ba;s/\n/\\n/g')
gsed -i "0,/alias/{// s|$|$services|}" vite.config.ts

local servicesTsConfig="\"@services/*\": [
        \"./src/services/*\"
      ]
"

# 可避免字串變數中的換行，造成 gsed 無法寫入
servicesTsConfig=$(echo "$servicesTsConfig" | gsed ':a;N;$!ba;s/\n/\\n/g')
gsed -i "/\"paths\":/,$ { 0,/\}$/{// s|^|      $servicesTsConfig\n|}}" tsconfig.app.json




mkdir src/services
cp $HOME/UserScripts/vite/Clerk&Firebase/firebase.ts src/services/firebase.ts




echo '
.env 檔
裡面的 publishable_key 需到 clerk 儀表板中複製
儀表板連結：https://dashboard.clerk.com/
點擊專案 > 左側欄位 API KEY > 頁面搜尋 Publishable key

src/services/firebase.ts 檔
裡面的
  const firebaseConfig = {
    ...
  }
需到 firebase 控制台中複製
控制台連結：https://console.firebase.google.com/
點擊專案 > 左上角齒輪 > 專案設定 > 頁面搜尋 firebaseConfig


<LoginBtn> 路徑：src/components
'

unset services servicesTsConfig importSnippet injectSnippet