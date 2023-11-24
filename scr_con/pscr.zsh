#! /bin/zsh

lastDir=$(pwd)
_lastDir=${lastDir:t}
cd  ~/UserScripts

gpf
if [[ $_lastDir != UserScripts ]] {
  cd  $lastDir
}
