#! /bin/zsh

# 別名 v-
# 刪除所有初始樣式，該腳本跟 bootstrap 擇一執行，不然會出錯

# 刪除 App.vue style標籤，並清除 <template> 不要的元件、標籤、圖片
gsed -i '/<style scoped>/,/<\/style>/ {/<style scoped>/! {/<\/style>/! d}}' ./src/App.vue
gsed -i '/import HelloWorld/d; /<header>/,/HelloWorld/d; /<\/div>/,/<\/header>/d' ./src/App.vue

# 刪除 TheWelcome 元件
gsed -i '/TheWelcome/d' ./src/views/HomeView.vue

# 刪除 main.css檔以及刪除其匯入
gsed -i "/.\/assets\/main.css/d" ./src/main.{t,j}s
rm ./src/assets/main.css

# 刪除 logo.svg檔
rm ./src/assets/{base.css,logo.svg}



echo "刪除 App.vue 中的 <style> 內容，以及 <header> 標籤、<HelloWorld>元件
刪除 HomeView.vue 中的 <TheWelcome>元件
刪除 assets 中的 base.css、logo.svg、main.css 檔"
