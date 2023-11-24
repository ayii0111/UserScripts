#! /bin/zsh

# 別名 cp: 改良版
# cp file1 [file2 ...] dir  超過 2 個參數，帶表示拷貝到最後一個參數目錄中
# cp <dir1> <dir2> 兩個參數都是目錄，若名稱相同，則直接複製過去，若名稱不同，將第一個參數目錄，複製到第二個參數目錄下
# cp <file1> <file2/dir> 兩個參數都是目錄，若名稱相同，則直接複製過去
# ************************
# 加強覆蓋邏輯，解偶改名效果
# 當參數數量小於兩個參數，報錯
# 當參數數量為三個以上參數，則建立目標路徑目錄，若已存在則報錯
# 當參數數量為兩個的情況
# 1.來源為檔案時，目標路徑末端同名時，若目標路徑存在檔案，則覆蓋之，若不存在檔案不存在目錄，則直接複製過去，若存在「目錄」時，則報錯，因「目標路徑已存在同名目錄，無法覆蓋檔案」
# 若不同名，則作為目標目錄，將來源複製到其下，若目標目錄不存在則建立，若目標目錄存在為一檔案，則報錯，因「目標目錄已存在同名檔案，無法建立目錄」
# 2. 當來源為目錄時，目標路徑末端同名時，若目標路徑存在目錄，則刪除後，再複製過去，若不存在目錄，則直接複製過去，若存在「檔案」時，則報錯，因「目標路徑已存在同名檔案，無法覆蓋目錄」
# 若不同名，則作為目標目錄，將來源複製到其下，若目標目錄不存在則建立，若目標目錄存在為一檔案，則報錯，因「目標目錄已存在同名檔案，無法建立目錄」

(
  (($# < 2)) && echo "Erroe: 至少要有兩個參數" >&2 && return 1

  # 下面添加 2>/dev/null 是為了避免產生警告訊息
  if (($# > 2)); then
    # 先篩選參數數量大於 2的情況
    # 會將最後參數，當作「目錄路徑」，故會自動建立該目錄
    local args=($*)
    local argFinal=$args[$#*]
    [[ -f $argFinal ]] && echo "Error: 目標路徑已存在檔案，無法建立目錄" >&2 && return 1
    mkdir -p "$argFinal" 2>/dev/null
    /bin/cp -r $*
    # unset args argFinal
    return 0
  fi

  # 以下結為參數數量為 2 的情況
  if [[ -f $1 ]]; then
    if [[ ${1:t} == ${2:t} ]]; then
      [[ -f $2 ]] && {
        /bin/cp -f $1 $2 && return 0
      }
      [[ -d $2 ]] && {
        echo "Error: 目標路徑已存在目錄，無法以檔案覆蓋" >&2 && return 1
      }
      local dir=${2:h}
      mkdir -p "$dir" 2>/dev/null
      /bin/cp -f $1 $2 && return 0
      # unset dir
    else
      [[ -f $2 ]] && {
        echo "Error: 目標路徑已存在檔案，無法建立目錄" >&2 && return 1
      }
      mkdir -p $2 2>/dev/null
      /bin/cp -f $1 $2 && return 0
    fi
  fi

  if [[ -d $1 ]]; then
    if [[ ${1:t} == ${2:t} ]]; then
      [[ -d $2 ]] && {
        rm -rf $2
        /bin/cp -r $1 $2 && return 0
      }
      [[ -f $2 ]] && {
        echo "Error: 目標路徑已存在檔案，無法以目錄覆蓋" >&2 && return 1
      }
      local dir=${2:h}
      mkdir -p "$dir" 2>/dev/null
      /bin/cp -r $1 $2 && return 0
      # unset dir
    else
      [[ -f $2 ]] && {
        echo "Error: 目標路徑已存在檔案，無法建立目錄" >&2 && return 1
      }
      mkdir -p $2 2>/dev/null
      /bin/cp -r $1 $2 && return 0
    fi
  fi
  return 0

  echo "Error: 來源路徑 $1 不存在" >&2 && return 1
)
