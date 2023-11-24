#! /bin/zsh

# 腳本別名 ag
# 將他跟 fd 指令稍微統一一下

# --depth <NUM>  改為 -d
# --hidden  改為 -H
# -U  統一為  -I
# -u  改為 -IH
# --silent  改為默認開啟


local opts=()
local args=($*)
local index=1

while (( $index <= $#* )) {
    case ${args[index]} in
        -d)
            # 當遇到 -d 選項，添加 --depth 並將下一個參數作為其值
            opts+=("--depth")
            ((index++))
            # if [ $index -le $# ]; then
            opts+=("${args[index]}")
            # fi
            ;;
        -H)opts+=("--hidden");;
        -I)opts+=("-U");;
        -IH)opts+=("-u");;
        -HI)opts+=("-u");;
        -*)opts+=("${args[index]}");;
        *)opts+=(\""${args[index]}"\");;
    esac
    ((index++))
}


# 添加 --silent 作為默認選項
opts="--silent "$opts
eval "/opt/homebrew/bin/ag $opts"


