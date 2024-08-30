#!/bin/zsh


# cfsyn 腳本
# 將新的檔案覆蓋到就的檔案時，驗證新內容是否包含舊內容，若沒有則輸出警告並確認是否覆蓋
# 可以用來調和同步更新「當前設定檔」與「備份設定檔」

newFile=$1
oldFile=$2


match_count=$(grep -Fcxf "$oldFile" "$newFile")
line_count=$(wc -l < "$oldFile")

cmp -s "$oldFile" "$newFile" && {
  echo "狀態早已同步，不作覆蓋"
  return 0
}

if (( $match_count == $line_count )) {
    echo "備份檔案包含當前設定檔案內容，直接覆蓋"
    cp "$newFile" "$oldFile"
} else {
    echo "備份檔案不完全包含當前設定檔案內容，顯示差異："
    icdiff "$oldFile" "$newFile"
    read -q "REPLY?是否要覆蓋當前設定檔？ [y/N]: "
    echo
    if [[ $REPLY =~ ^[Yy]$ ]] {
        cp "$newFile" "$oldFile"
        echo "已覆蓋當前設定檔"
    } else {
        echo "未覆蓋當前設定檔"
    }
}
