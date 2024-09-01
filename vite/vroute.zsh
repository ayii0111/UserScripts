#! /bin/zsh

# 別名 vroute
# modifyRoute
# 可用來確認指定檔案是存在 index.ts 還是 index.js
file=$(getMatchedFile "src/router/index")
if [[ ! $file ]] return 1



# createWebHistory 改為 createWebHashHistory
gsed -i 's/createWebHistory/createWebHashHistory/' $file

# 格式化 Home的路由
gsed -i '/import HomeView/d' $file
gsed -i "s|component: HomeView|component: () => import('../views/HomeView.vue')|" $file

# //註解都刪除
gsed -i '/\/\//d' $file

unset file