#! /bin/zsh

# 別名 checkExistInFile： 確認檔案存在關鍵字串
# 似乎 ag 之類的都能取代
(
  local args=($*)
  local file=$args[$#*] # 最後一個參數是文件
  args[$#*]=()
  local keyWords=($args) # 除最後一個參數外，其他為關鍵字

  # 檢查文件是否存在
  if [[ ! -f "$file" ]]; then
    echo "Error: 文件 $file 不存在" >&2
    unset args file keyWords
    return 1
  fi

  # 檢查每個關鍵字是否存在於文件中
  for keyWord in $keyWords; do
    if ! grep -q "$keyWord" "$file"; then
      echo "Error: $file 檔中缺少 $keyWord" >&2
      unset args file keyWords
      return 1
    fi
  done

  unset args file keyWords
  return 0
)
