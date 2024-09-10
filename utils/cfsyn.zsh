#!/bin/zsh

# 別名 cfsyn: 用來源檔去覆蓋一個目標檔案，並驗證來源檔內容是否包含目標檔內容
# 將來源檔案覆蓋到目標檔案時，驗證來源檔內容是否包含目標檔內容，若沒有則輸出警告並確認是否覆蓋
# 可以用來同步設定檔

sourceFile=$1
targetFile=$2

match_count=$(grep -Fcxf "$targetFile" "$sourceFile")
line_count=$(wc -l <"$targetFile")

cmp -s "$targetFile" "$sourceFile" && {
  echo "檔案狀態已同步，無需進行覆蓋操作"
  return 0
}

if (($match_count == $line_count)); then
  cp "$sourceFile" "$targetFile"
  echo "來源檔包含目標檔，直接覆蓋"
else
  echo "來源檔「不包含」目標檔，顯示對比差異"
  icdiff "$targetFile" "$sourceFile"
  read -q "REPLY?決定使否覆蓋目標檔？ [y/N]: "
  echo
  if [[ $REPLY =~ ^[Yy]$ ]]; then
    cp "$sourceFile" "$targetFile"
    echo "成功覆蓋目標檔"
  else
    echo "取消覆蓋目標檔"
  fi
fi
