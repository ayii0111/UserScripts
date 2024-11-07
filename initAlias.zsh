#!/bin/zsh

# 別名 initAlias: 腳本 alias 初始化
# 腳本目錄中的所有腳本都自動生成別名
# 可以指定要忽略的檔案 or 目錄

local ignoreDirs=("zsh_hook" "zle_tools_XXX" "testDir")
local ignoreFiles=("initAlias.zsh" "env.zsh" "re.zsh")

# 定義將列表轉換為正則表達式的函式
function joinRegex() {
  local array=($*)
  local pattern=$(printf "|%s" $array)
  echo "${pattern:1}" # 去掉開頭的 '|'
}

# 使用函式生成正則表達式
local ignoreDirsPattern=$(joinRegex $ignoreDirs)
local ignoreFilesPattern=$(joinRegex $ignoreFiles)

for currFilePath in ~/UserScripts/**/*.zsh; do
  # 檢查當前路徑是否匹配忽略的目錄或文件
  if [[ $currFilePath =~ /($ignoreDirsPattern)/ || $currFilePath =~ ($ignoreFilesPattern)$ ]]; then
    continue
  fi

  # 動態生成 alias
  local alias_name=$(basename "$currFilePath" .zsh)
  alias $alias_name="source $currFilePath"
done

unset ignoreDirs ignoreFiles ignoreDirsPattern ignoreFilesPattern alias_name
