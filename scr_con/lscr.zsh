#!/bin/zsh

# 別名 lscr 可以檢視腳本的「功能簡述」
# 功能簡述的格式為 「# 別名 ooo: 功能簡述...」

# 設定要搜尋的目錄
scrDir=~/UserScripts

# 使用 ag 搜尋指定模式，並將結果按檔案名分組
agRslt=$(/opt/homebrew/bin/ag '^# 別名 .+' "$scrDir")

# 將結果按目錄分組
echo "$agRslt" | gawk --posix -F':' '
{
    # ANSI 控制碼，設置藍色粗體
    colorStartPosition = "\033[1;34m"
    colorEndPosition = "\033[0m"

    # 取得完整路徑與行內容
    fullPath = $1
    lineContent = $3 $4


    # 從完整路徑中取得目錄名稱 (倒數第二層目錄)
    n = split(fullPath, pathParts, "/")
    dirName = pathParts[n-1] "/"

    # 去除 # 別名
    sub(/^# 別名 /, "", lineContent)


    # 使用 match 找到“別名”後面的單詞
    if (match(lineContent, /([a-zA-Z_][a-zA-Z0-9_]*)/)) {
        # 提取 “別名” 後的單詞
        aliasText = substr(lineContent, RSTART, RLENGTH)
        # 使用 gsub 將找到的單詞設為藍色粗體
        gsub(aliasText, colorStartPosition aliasText colorEndPosition " ", lineContent)
    }

    # 檢查該目錄是否已有內容
    if (aliasLines[dirName] == "") {
        aliasLines[dirName] = "  " lineContent
    } else {
        aliasLines[dirName] = aliasLines[dirName] "\n  " lineContent
    }
}
END {
    # 輸出分組結果
    for (dirName in aliasLines) {
        # 使用 ANSI 控制碼將目錄名稱設為粗體字
        print "\033[1m" dirName "\033[0m"
        print aliasLines[dirName]
        print ""
    }
}'
