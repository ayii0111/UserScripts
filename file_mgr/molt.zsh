#! /bin/zsh

# 別名 molt: 脫掉上一層目錄
# 將當前目錄內的非隱藏檔、隱藏檔，全部移動到父目錄中

# 為了取得父目錄層中的檔案與目錄數量，因此先取得陣列
local pdir=($(ls ..))
# 因為 ls並非原生因此輸出會變成兩倍，可以用下面指令檢視原因
# echo $#pdir
# print -l $pdir


molt_action() {
  # 過濾錯誤訊息
  # 在 .zshrc 檔添加 setopt nonomatch 效果為：使用*而沒有匹配時，不會報錯
  mv ./{*,.*} .. 2>/dev/null

  # 取得當前目錄的名稱
  local pp=${$(pwd):t}

  cd ..

  # 刪除原先的當前目錄
  rm -rf $pp
}

# 要確保父層目錄只有當前一個目錄，才能執行 molt
if (( $#pdir <= 2 )) {
  molt_action
} else {

  echo "父層目錄，並非乾淨目錄，是否要 molt ? (Y/n)"

  # 關閉終端回顯
  stty -echo

  # 讀取一個字符作為回應，並不顯示在終端
  read -k 1 response

  # 恢復終端回顯
  stty echo

  # 輸入 y 或 enter時，條件都會成立
  if [[ $response == "y" || $response == $'\n' ]]
  then
      echo "\nmolt 執行完畢..."
      molt_action
  else
      echo "\n已放棄 molt..."
      return 1
  fi

}

unset pp pdir