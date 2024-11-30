#! /bin/zsh
(
  npm install -D sass-embedded
  npm install vue-tsc@latest -D # 舊版編譯會報錯，跟不上 typescript 最新穩定版本 (故 typescript 不要也更新，不然會繼續報錯 )

  # ------------------------------ popup.ts ------------------------------
  local splitedCreateApp="const app = createApp(Popup)
app.mount(\"body\")
"
  splitedCreateApp=$(gsedWrapPreproc $splitedCreateApp)
  gsed -i "s/createApp(Popup).mount(\"body\");/$splitedCreateApp/" src/popup.ts
  # ------------------------------ .webextrc (指定瀏覽器與其環境) ------------------------------
  cat <<EOF >.webextrc
{
  "chromiumBinary": "/Applications/Google Chrome Canary.app/Contents/MacOS/Google Chrome Canary",
  "chromiumProfile": "/Users/ayii/Library/Application Support/Google/Chrome Canary"
}
EOF

  # ------------------------------ 測試取得當前所有擴展的資訊 ------------------------------

  local insertManagement=',  "permissions": [
    "management"
  ]
}'
  insertManagement=$(gsedWrapPreproc $insertManagement)
  gsed -i "s|^}|$insertManagement|" src/manifest.json

  # 取得擴展的操作，直接在下面 Home.vue 中寫入了

  # ------------------------------ Vue Router ------------------------------
  npm install vue-router@latest

  # 新增 router 目錄及檔案
  mkdir -p src/router && touch src/router/index.ts
  cat <<EOF >src/router/index.ts
import { createRouter, createWebHashHistory } from 'vue-router'

const router = createRouter({
  history: createWebHashHistory(import.meta.env.BASE_URL),
  routes: [
    {
      path: '/',
      name: 'Home',
      component: () => import('../pages/Home.vue'),
    },
    {
      path: '/allExts',
      name: 'allExts',
      component: () => import('../pages/AllExts.vue'),
    },
  ],
})

export default router
EOF

  cat <<EOF >src/pages/Home.vue
<script setup lang="ts">
import { onMounted } from 'vue'

onMounted(async () => {
  const extensions = await chrome.management.getAll()
  console.log(extensions)
})
</script>

<template>
  <div>
    <h2>Hello Vue Router</h2>
  </div>
</template>
<style scoped lang="scss"></style>
EOF

  cat <<EOF >src/pages/AllExts.vue
<script setup lang="ts">
import { onMounted, ref } from 'vue'

const extNames = ref<string[]>([])
onMounted(async () => {
  const extensions = await chrome.management.getAll()
  console.log(extensions)
  extNames.value = extensions.map(ext => ext.name)
})
</script>

<template>
  <h2>
    All extensions:
  </h2>
  <ul style="padding: 0 0 0 1rem;">
    <li v-for="extName in extNames" :key="extName">
      {{ extName }}
    </li>
  </ul>
</template>

<style scoped lang="scss"></style>
EOF

  cat <<EOF >src/pages/Popup.vue
<script lang="ts" setup>
console.log("Hello from the popup!");
</script>

<template>
  <div class="top-div">
    <nav>
      <RouterLink to="/">Home</RouterLink> |
      <RouterLink to="/allExts">allExts</RouterLink>
    </nav>
    <RouterView />
  </div>
</template>

<style scoped lang="scss">
nav {
  display: flex;
  justify-content: center;

  a {
    margin: 0 1rem;
  }
}

/* 用來將過展頁面置中 */
:global(body) {
  margin: 0;
}

/* 作為彈跳視窗頂層 */
.top-div {
  width: 350px;
  height: 600px;
  overflow: scroll;

  padding: 1rem;

  /* 檢測亮模式 */
  @media (prefers-color-scheme: light) {
    background-color: white;
    color: black;
  }

  /* 檢測暗模式 */
  @media (prefers-color-scheme: dark) {
    background-color: black;
    color: white;
  }
}
</style>
EOF

  # 插入，且需添加 route 目錄，檔案
  local routerImport="import router from './router'"
  local routerUse="app.use(router)"

  gsed -i "/createApp(Popup)/,\$! {/^$/d}
0,/createApp(Popup)/{// s|^|$routerImport\n\n\n|}" src/popup.ts
  gsed -i "/createApp(Popup)/,/app.mount/ {/^$/d}
0,/app.mount/{// s|^|$routerUse\n\n\n|}" src/popup.ts

  # ------------------------------ chrome 型別 ------------------------------
  npm i -D @types/chrome
  echo '/// <reference types="chrome"/>' >>src/vite-env.d.ts
)
