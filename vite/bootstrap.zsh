#! /bin/zsh

# 別名 vboot

npm i bootstrap @popperjs/core

# 添加 bootstrap中 js部分的型別
npm i -D @types/bootstrap

# 安裝 sass編譯套件
# 若直接透過 App.vue 檔的 <style lang="scss"> ，就可不用 sass，但無法直接檢視 css 檔案
# 若要流暢編寫代碼，還是透過 sass 將 css 檔案編譯出來檢視會好很多
npm i sass -D

# 多指令同時運行的套件
npm i concurrently -D

# scss 的目錄結構
local scss_path="src/assets/scss"

if [[ ! -e $scss_path ]] {
  mkdir -p "$scss_path"
}

# 把 bootstrap.scss 拷貝出來，改為 main.scss
cp -r ./node_modules/bootstrap/scss/bootstrap.scss $scss_path/main.scss
cp -r ./node_modules/bootstrap/scss/_variables.scss $scss_path
cp -r ./node_modules/bootstrap/scss/_variables-dark.scss $scss_path
cp -r ./node_modules/bootstrap/scss/_maps.scss $scss_path
cp -r ./node_modules/bootstrap/scss/_utilities.scss $scss_path
cp -r ./node_modules/bootstrap/scss/_reboot.scss $scss_path


local node_path='../../../node_modules/bootstrap/scss'
# 用 sed指令，去操作拷貝後的 main.scss檔，將其中各個檔案匯入的路徑，修改成正確的路徑
gsed -i "s| \"| \"$node_path/|" $scss_path/main.scss
gsed -i "/variables\"/ s|$node_path|.|" $scss_path/main.scss
gsed -i "/variables-dark\"/ s|$node_path|.|" $scss_path/main.scss
gsed -i "/maps\"/ s|$node_path|.|" $scss_path/main.scss
gsed -i "/utilities\"/ s|$node_path|.|" $scss_path/main.scss
gsed -i "/reboot\"/ s|$node_path|.|" $scss_path/main.scss



# 匯入 bootstrap 的 js 物件
local file=$(getMatchedFile "./src/main")
if [[ ! $file ]] return 1

gsed -i "1 s|^|import 'bootstrap'\nimport './assets/scss/main.css'\n|" $file



# 先編譯一次
npx sass src/assets/scss/main.scss src/assets/scss/main.css

# 修改 "dev": "vite"
# 改為這樣"dev": "concurrently -n \"vite,bootstrap\" --prefix-colors \"cyan,magenta\" \"vite\" \"sass --watch ./src/assets/main.scss ./src/assets/main.css\"",
local origStr='"dev": "vite"'
local modStr='"dev": "concurrently -n \"bootstrap,vite\" --prefix-colors \"cyan,magenta\" \"sass --watch src/assets/scss/main.scss src/assets/scss/main.css\" \"vite\""'
modStr=${modStr//\\/\\\\}
gsed -i "s|$origStr|$modStr|" ./package.json
echo "修改了 package.json 中的 dev 指令內容"

# 寫入一個按鈕適用
local button='
<button type="button" class="btn btn-primary">Primary</button>'

button=$(echo "$button" | gsed ':a;N;$!ba;s/\n/\\n/g')
gsed -i "/<template>/ s|$|$button|" src/views/HomeView.vue





# 啟用 _variables 檔中的 Options 的 $enable-shadows $enable-gradients  $enable-cssgrid
gsed -i "/Options/,$ {
  /\$enable-shadows/ s|false|true|
  /\$enable-gradients/ s|false|true|
  /\$enable-cssgrid/ s|false|true|
  }" src/assets/scss/_variables.scss


# 在 _reboot 檔中添加 resetCSS 的補充
local reboot="
li {
  // 可消除項目符號
  list-style: none;
}

a {
  // 避免 <a> 高度小於子元素
  display: inline-block;
  // 去除下劃線
  text-decoration: none;
}

img {
  // 可以消除圖像下面白色小區塊
  vertical-align: middle;
  // 寬高等比一邊填滿
  object-fit: contain;
  // 可以隨著寬度壓縮圖像大小
  max-width: 100%;
}

p,
h1,
h2,
h3,
h4,
h5,
ul,
ol,
dl {
  // 設定外距為0
  margin: 0;
}

ol,
ul {
  padding: 0;
}"

# 可避免字串變數中的換行，造成 gsed 無法寫入
reboot=$(echo "$reboot" | gsed ':a;N;$!ba;s/\n/\\n/g')
gsed -i "$ s|$|\n$reboot|" src/assets/scss/_reboot.scss


unset scss_path origStr modStr scss_import button file