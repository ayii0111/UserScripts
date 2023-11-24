#! /bin/zsh

# 別名 chscr
# 用來確定已經建立的腳本，是否已經配置 alias


# 變數說明
# 要個別忽略的檔案 - exclFiles
# 要忽略的整個目錄 - exclDir (未設定，暫時保留)
# 腳本目錄跟目錄路徑 - scriptRootDirPath
# 腳本alias檔案的路徑 - scriptFilePaths
# 經檢驗後沒有配置 alias 的檔案路徑 - noAliasPath

# 要忽略的個別檔案
local exclFiles=("README.md" ".DS_Store" ".gitignore"/ ".history" ".vscode" "undecided")

# 腳本根目錄路徑
local scriptRootDirPath="$HOME/UserScripts"


# 使用 find 指令，回傳所有腳本目錄路徑的陣列
# 並同時排除指定目錄
local scriptFilePaths=($(find "$scriptRootDirPath" -type f \
-a ! -path "$scriptRootDirPath/.history/*" \
-a ! -path "$scriptRootDirPath/.git/*" \
-a ! -path "$scriptRootDirPath/vite/Clerk&Firebase/*" \
-a ! -path "$scriptRootDirPath/vite/viteConfig/*" \
-a ! -path "$scriptRootDirPath/vite/vComponents/*" \
-a ! -path "$scriptRootDirPath/zsh_hook/preec/*" \
))



# 迭代刪除 exclFiles要忽略的檔案
for i ({1..$#scriptFilePaths}) {
  for j ({1..$#exclFiles}) {
    if [[ $scriptFilePaths[$i] == *$exclFiles[$j]* ]] {
      scriptFilePaths[$i]=()
    }
  }
}

# 使用 ~ 取代絕對路徑的前段
for i ({1..$#scriptFilePaths}) {
    scriptFilePaths[$i]=${scriptFilePaths[$i]//"$HOME"/'~'}
}




# 讀取文檔內容到一個變數中
local aliasFileContent=$(<$HOME/UserConfig/zshrc/alias_script.zsh)
local noAliasPath=()

# 迭代檢驗，使否檔案沒有寫入 alias_script.zsh檔案中
for i ({1..$#scriptFilePaths}){
  if [[ ! $aliasFileContent == *$scriptFilePaths[$i]* ]] {
    noAliasPath+=$scriptFilePaths[$i]
  }
}

if (( $#noAliasPath == 0 )) {
  echo "  所有腳本都已配置 alias $okMark"
} else {
  echo "  未配置 alias 的腳本有：${#noAliasPath} 個  $failMark"
  echo "腳本路徑如下："
  print -l $noAliasPath
  echo "\nP.S  請於 ~/UserConfig/zshrc_dir/alias_script 中配置腳本路徑的 alias"
}


unset scriptFilePaths exclFiles scriptRootDirPath aliasFileContent noAliasPath
