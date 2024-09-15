#!/bin/zsh

# 指定忽略的多個目錄（用空格分隔）
ignoreDirs=(~/UserScripts/zsh_hook)

# 指定忽略的多個檔案（並非輸入路徑）
ignoreFiles=(initAlias.zsh env.zsh)

# 動態載入目錄中的所有腳本
for currFilePath in ~/UserScripts/**/*.zsh; do
  # 忽略 alias 處理的狀態
  isIgnore=false

  # 檢查當前路徑，是否在排除目錄列表中
  for ignoreDir in $ignoreDirs; do
    if [[ $currFilePath == $ignoreDir/* ]]; then
      isIgnore=true
      break # 一旦確認忽略，直接跳出檢查循環
    fi
  done

  # 檢查當前路徑是否在排除檔案列表中
  for ignoreFile in $ignoreFiles; do
    if [[ $currFilePath == *$ignoreFile ]]; then
      isIgnore=true
      break # 一旦確認忽略，直接跳出檢查循環
    fi
  done

  # 如果需要忽略，則跳過該次 alias 處理
  if $isIgnore; then
    continue
  fi

  # 根據檔名動態生成 alias
  alias_name=$(basename "$currFilePath" .zsh)
  alias $alias_name="source $currFilePath"
done
