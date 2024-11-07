local fieldName=$1
local filePath=$2

! [[ -f $filePath ]] && echo "Error: 檔案不存在" >&2 && return 1

local result=$(gawk -v field="$fieldName" '
    $0 ~ field {
      lineNum=NR
      indent=match($0, /[^ ]/) - 1
      print lineNum, indent
    }
  ' $filePath)

[[ ! $result ]] && echo "Error: 沒有找到 $fieldName" >&2 && return 1
echo $result
