# 定義 ncuf 別名

local isDevEnv=false
local pkgName

# 解析選項
while getopts "D" opt; do
  case "$opt" in
    D) isDevEnv=true ;;
    *) echo "Usage: ncuf [-D] <package>" && return 1 ;;
  esac
done

shift $((OPTIND - 1))
pkgName=$1

if [[ -z $pkgName ]]; then
  echo "請提供要安裝的套件名稱"
  return 1
fi

# 根據選項決定命令參數
if $isDevEnv; then
  echo "正在開發環境安裝..."
  npm install --save-dev --force "$pkgName"
else
  echo "正在開發與產品環境安裝..."
  npm install --force "$pkgName"
fi

# 升級與降版處理
ncu -d "$pkgName"
ncu -u "$pkgName"
npm install
