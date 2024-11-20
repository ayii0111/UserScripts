#! /bin/zsh

(
  checkNoInst @andypf/json-viewer || return 1
  npm install @andypf/json-viewer

  local import="import '@andypf/json-viewer'"
  insertMainfile $import
)
