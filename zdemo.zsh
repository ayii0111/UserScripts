echo "1,2,3,4,5" | awk '{
    num = split($0, array, ","); # 使用逗號作為分隔符將字符串拆分
    for (i = 1; i <= num; i++) {
        print "array[" i "] = " array[i]; # 按照順序輸出拆分後的每個元素
    }
    print "總共數量 length(array) : " length(array);
    print "總共數量 num : " num;
}'

# array[1] = 1
# array[2] = 2
# array[3] = 3
# array[4] = 4
# array[5] = 5
# 總共數量 length(array) : 5
# 總共數量 num : 5

# 若改為 for (i in array) 迭代會無序，要小心
# array[2] = 2
# array[3] = 3
# array[4] = 4
# array[5] = 5
# array[1] = 1
# 總共數量 length(array) : 5
# 總共數量 num : 5
