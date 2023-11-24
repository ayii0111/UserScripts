#!/bin/zsh

# 別名 hali
# 對齊 #字元
# 找時間研究他 awk 的語法

local file=$1
local positions=$(cat $file | awk '/#/ { if(substr($0, 1, 1) != "#") { for(i=1; i<=length($0); ++i) if(substr($0, i, 1) == "#") print "Found # at position " i " on line " NR; }}')

positions=$(echo "$positions" | sed -E 's/Found # at position //g' | sed -E 's/ on line [0-9]+//g')


# 字串變數轉成陣列變數
local positions_array=(${=positions})

# 取出陣列中最大數字
# 初始化一個變數來儲存最大數字，設為陣列的第一個元素
local max_number=$positions_array[1]

# 遍歷陣列來找出最大數字
for num ($positions_array) {
  if (( num > max_number )) {
    max_number=$num
  }
}

# 莫名其妙每次執行後推一格，直接在這便修正 bug
# 因為 awk 內的代碼太難修改
((max_number--))

# 將檔案中 #字元之後的部分，都與最大字元序號的 #，對齊
echo "$(awk -v pos=$max_number '{
  if ($0 == "") {
      print "";
  } else if (substr($0, 1, 1) == "#") {
      print $0;  # 如果行首是 #，則直接輸出該行
  } else {
      split($0, a, "#");
      if (length(a) > 1) {
          format = sprintf("%%-%ds#%s\n", pos, a[2]);
          printf format, a[1];
      } else {
          printf "%s\n", $0;
      }
  }
}' $file )" > $file

unset file positions positions_array max_number