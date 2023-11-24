#! /bin/zsh

# 別名 vaxios
npm i axios vue-axios
npm i @types/axios -D

local importSnippet="import axios from 'axios'
import VueAxios from 'vue-axios'"

local injectSnippet="app.use(VueAxios, axios)
app.provide('axios', app.config.globalProperties.axios)"

importSnippet=$(echo "$importSnippet" | gsed ':a;N;$!ba;s/\n/\\n/g')
injectSnippet=$(echo "$injectSnippet" | gsed ':a;N;$!ba;s/\n/\\n/g')


local file=$(getMatchedFile "./src/main")
if [[ ! $file ]] return 1

gsed -i "/createApp(App)/,\$! {/^$/d}
0,/createApp(App)/{// s|^|$importSnippet\n\n\n|}
/createApp(App)/,/app.mount('#app')/ {/^$/d}
0,/app.mount('#app')/{// s|^|$injectSnippet\n\n\n|}" $file

unset importSnippet injectSnippet file