#! /bin/zsh

# 別名 fins: find 的改良版
# find_installed
# 用來尋找安裝套件的蹤跡
# 找時間研究他 awk 的語法

# 隱藏光標閃爍
echo -ne '\e[?25l'

# 使用搜尋中的特效
# 此處需使用 revolver 插件
revolver start '搜尋中...'

# 預先排除掉 /System/Volumes 路徑的搜尋結果
local F=$(fd -H -t"$3" "$1" "$2" | grep -v /System/Volumes)

# 先去掉文字最後面的 /
F=${F%/}
# 在將每一行後面的 / 去除
F=${F//\/$'\n'/'\n'}

# 恢復光標閃爍
echo -ne '\e[?25h'
# 結束搜尋中的特效
revolver stop

# awk -F/ 代表每行輸入時，以 / 作為分隔符來切分
# -v 內變數=外變數  可以將 awk 外部變數匯入內部變數中
echo "$F" | awk -F/ -v keyword=$1 '
{
  # $1 為切分的第一個片段
  # NF 則為切分的總片段數量
  path_dir = $1
  for (i = 2; i < NF; i++) {
      path_dir = path_dir "/" $i
  }

  # 如果共同父目錄發生變化，則打印新的標題
  if (path_dir != prev_dir) {

    # prev_dir變數，是用來比對當前目錄路徑與前一個的作用
    prev_dir = path_dir

    # 列印目錄路徑時，使用粗體字
    bold_start = "\033[1m"
    bold_end = "\033[0m"
    print "\n" bold_start path_dir ":" bold_end
  }

  # 取得路徑中檔案的名稱
  path_file = $NF

  # 用來取出匹配關鍵字的變數
  extracted_text = ""

  # 使用 tolower() 將字串轉換為小寫，以進行大小寫不敏感的比對
  if (index(tolower(path_file), tolower(keyword)) > 0) {
      extracted_text = substr(path_file, index(tolower(path_file), tolower(keyword)), length(keyword))
  }

  # 將取出的匹配文字，套用藍色粗體字樣式
  color_start = "\033[1;34m"
  color_end = "\033[0m"
  gsub(extracted_text, color_start extracted_text color_end, path_file)

  print "  " path_file

}'

unset F
