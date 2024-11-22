# 別名 checkConfOptExist: 用來確認設定檔，是否已經修改過
# checkConfOptExist [欄位定位]...<最終目標> <目標檔案>

# result=$(checkConfOptExist "選項目標" $file) || return 1  # 若基本參數格式錯誤，會回報錯誤 (對外報錯)
# [[ $result == 'exist' ]] && echo "設定選項已存在!" && return 0  # 若是設定選項已經存在，則會直接中斷退出 (對外不報錯)

# 檢視的格式包含 json、.zshrc

# 唯一選項:
# checkConfOptExist <選項>
# 若參數唯一時，做唯一選項檢查
# 先驗證唯一性，若不符合報錯
(
  local args=($*)
  local file=$args[$#*]
  local fields=($args)
  local target=""

  # 檢查參數數量
  (($#args < 2)) && echo "Error: 至少兩個關鍵字 <關鍵字> <檔案> " >&2 && return 1
  [[ ! -f $file ]] && echo "Error: 檔案不存在" >&2 && return 1

  target=${fields[$#fields - 2]} # 倒數第二個參數為實際確認目標
  # 唯一選項檢查
  if (($#args == 2)); then
    # 檢查是否已修改過
    (grep -q "$target" "$file") && echo 'exist' && return 0
    echo 設定選項不存在!
    return 0
  fi

  # checkConfOptExist [欄位定位]...<最終目標> <目標檔案>
  fields=${fields[1, -3]} # 刪除倒數第二個和倒數第一個參數

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
  local result=$(gawk -v fieldsString="${fields[*]}" -v target="$target" "$gawkScript" "$file")

  # 判斷結果輸出
  if [[ $result == FOUND ]]; then
    echo 'exist'
    return 0
  elif [[ $result == MISSING_FIELD ]]; then
    echo "✗ 未找到完整欄位結構"
    return 0
  elif [[ $result == MISSING_TARGET ]]; then
    echo "✗ 欄位存在，但目標值 $target 缺失"
    return 0
  else
    echo "✗ 無法解析檔案 $file"
    return 0
  fi
)
# 最後要確認

# 最終檢查:
# 下面的要能檢查的出來
# /.[tj]sx?$/,
# /.vue$/,
# /.vue?vue/,
# /.md$/,
