#! /bin/zsh

local server_open="

  server: {
    open: true //vite项目启动时自动打开浏览器
  },"

server_open=$(echo "$server_open" | gsed ':a;N;$!ba;s/\n/\\n/g')

local file=$(getMatchedFile "./vite.config")
if [[ ! $file ]] return 1

gsed -i "/export default defineConfig({/ s|$|$server_open|" $file

unset server_open file