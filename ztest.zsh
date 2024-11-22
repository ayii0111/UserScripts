arr=(1 2 3 4 5)

arr=${arr[1, -3]}

print -l $arr
# echo $#arr

target=$arr[$#arr - 2]
echo $target
