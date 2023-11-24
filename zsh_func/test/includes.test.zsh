#!/bin/zsh

# 保存当前目录
current_dir=$PWD

# 创建测试目录并切换到该目录
test_dir=$(mktemp -d)
cd $test_dir

echo "测试案例 1: 测试数组包含指定元素"
arr=("apple" "banana" "orange")
if includes $arr "banana"; then
  echo " \e[32m✔\e[0m 案例 1 通过：成功找到元素 'banana'"
else
  echo " \e[31m✗\e[0m 案例 1 失败：未能找到存在的元素 'banana'"
fi

echo "\n测试案例 2: 测试数组不包含指定元素"
arr=("apple" "banana" "orange")
if ! includes $arr "grape"; then
  echo " \e[32m✔\e[0m 案例 2 通过：正确识别不存在的元素"
else
  echo " \e[31m✗\e[0m 案例 2 失败：错误地找到了不存在的元素"
fi

echo "\n测试案例 3: 测试空数组"
arr=()
if ! includes $arr "anything"; then
  echo " \e[32m✔\e[0m 案例 3 通过：空数组正确返回未找到"
else
  echo " \e[31m✗\e[0m 案例 3 失败：空数组错误返回找到元素"
fi

echo "\n测试案例 4: 测试参数不足的情况"
if ! includes "apple"; then
  echo " \e[32m✔\e[0m 案例 4 通过：参数不足时正确返回错误"
else
  echo " \e[31m✗\e[0m 案例 4 失败：参数不足时未返回错误"
fi

# 清理测试环境
cd $current_dir
rm -rf $test_dir
