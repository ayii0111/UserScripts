#! /bin/zsh
brew_pack() {
  # 因此若要取得剛執行的結果，首行代碼就要存起來了
	local cmd=$lastCmd
	local package_file="$HOME/.brew_packages" # 你想要保存的文件路径

	# 添加到列表
	if [[  $lastStatus == 0 && $cmd == brew\ install\ * ]] {
	  local package_into="${cmd//brew install /}"
	  package_into="${package_into//$'\n'/ }"
	  local arr_into=(${=package_into})
	  local arr_exist=($(cat $package_file))

	  # 利用 sort -u 把兩個陣列去除重複項目
	  local union=($(for elem in "${arr_into[@]}" "${arr_exist[@]}"; do
	    echo $elem
	  done | sort -u))

    printf "%s\n" "${union[@]}" > $package_file
	}

	# 移除出列表
	if [[ $cmd == brew\ uninstall\ * ]] {
	  local package_name="${cmd/brew uninstall /}" # 去掉 "brew uninstall " 得到軟件名
	  # 刪除匹配到的行
	  sed -i "" "/^${package_name}$/d" $package_}le
	}

  unset cmd package_file package_into arr_into arr_exist union
}

add-zsh-hook precmd brew_pack