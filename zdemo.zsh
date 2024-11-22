#! /bin/zsh

# 別名 checkFieldVal: 確認某檔案中是否存在欄位值


function checkFieldVal() {
  local -a fields=($*)         # 捕獲所有參數
  local target=$fields[-2]     # 倒數第二個參數為實際確認目標
  local configFile=$fields[-1] # 倒數第一個參數為設定檔路徑
  fields=${fields[1, -3]}      # 刪除倒數第二個和倒數第一個參數

  # Debug 訊息：輸出接收到的參數
  # echo "DEBUG: 接收到的欄位層級: ${fields[*]}"
  # echo "DEBUG: 目標值: $target"
  # echo "DEBUG: 設定檔路徑: $configFile"

  # 定義 gawk 匹配邏輯
  local gawkScript='
    BEGIN {
      split(fieldsString, fields, " ")
      fieldCount = length(fields)
      level = 0
      foundField = 0
      foundTarget = 0
      braceCount = 0
      bracketCount = 0
      notFound = 0
    }
    {
      # 匹配欄位層級（逐層匹配）
      if (level < fieldCount && $0 ~ fields[level + 1]) {
        level++
      }

      # 當達到目標欄位時，進入該欄位的範圍
      if (level == fieldCount && foundField == 0 && notFound == 0) {
        foundField = 1
      }

      # 追踪大括號和方括號範圍
      if (foundField) {
        if ($0 ~ /{/) braceCount++
        if ($0 ~ /}/) braceCount--
        if ($0 ~ /\[/) bracketCount++
        if ($0 ~ /\]/) bracketCount--

        # 在範圍內搜索目標值
        if ((braceCount > 0 || bracketCount > 0) && $0 ~ target) {
          foundTarget = 1
          exit
        }

        # 離開範圍後結束搜索
        if (braceCount == 0 && bracketCount == 0) {
          foundField = 0
          notFound = 1
        }
      }
    }
    END {
      if (foundTarget) {
        print "FOUND"
      } else if (level < fieldCount) {
        print "MISSING_FIELD"
      } else {
        print "MISSING_TARGET"
      }
    }
  '

  # 將欄位層級和目標值傳遞給 gawk 腳本
  local result=$(gawk -v fieldsString="${fields[*]}" -v target="$target" "$gawkScript" "$configFile")

  # 判斷結果輸出
  if [[ $result == FOUND ]]; then
    echo "✔ 找到目標值 $target"
  elif [[ $result == MISSING_FIELD ]]; then
    echo "✗ 未找到完整欄位結構"
  elif [[ $result == MISSING_TARGET ]]; then
    echo "✗ 欄位存在，但目標值 $target 缺失"
  else
    echo "✗ 無法解析檔案 $configFile"
  fi
}
