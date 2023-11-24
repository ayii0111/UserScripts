
# valias 腳本 ()
# valias <路徑>
# 會在該路徑建立目錄，並且一併配置 vite.config 檔

if [[ ! $+1 ]] {
  echo "錯誤：請輸入 alias 目錄路徑" >&2
  return 1
}

local file=$(getMatchedFile "./vite.config")
if [[ ! $file ]] return 1

mkdir -p $1
local dir=$1
# 取得目錄名稱
dir=${dir:t}

local aliasConfig="      '@$dir': fileURLToPath(new URL('./$1', import.meta.url))"



# 首次匹配「關鍵字」後，再對後面的「)$」匹配，最終插入「,\n$變數」
# $變數的前面，需先一併將空格計算進來
gsed -i "/alias/,$ { 0,/)$/{// s|$|,\n$aliasConfig|}}" $file


echo "目錄中是否會有 ts 檔 ? (Y/n)"

# 關閉終端回響
stty -echo

# 讀取一個輸入字符，並不顯示在終端
read -k 1 response

# 恢復終端回響
stty echo

# 輸入 y 或 enter時，條件都會成立
if [[ $response =~ ^[Yy]$ || $+response ]] {
	echo "\n在 tsconfig.app.json 中，添加 ts 別名路徑的配置"

  local tsConfig="\"@$dir/*\": [
        \"./$1/*\"
      ]
"

  # 可避免字串變數中的換行，造成 gsed 無法寫入
  tsConfig=$(echo "$tsConfig" | gsed ':a;N;$!ba;s/\n/\\n/g')

  # 改成在第一行插入設定
  gsed -i "/\"paths\":/,$ { 0,/\{/ {// s|^|      $tsConfig,\n|}}" tsconfig.app.json



} else {
	echo "\n不添加 ts 別名路徑的配置 !"
}

unset file aliasConfig dir