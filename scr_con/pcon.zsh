#! /bin/zsh

lastDir=$(pwd)
_lastDir=${lastDir:t}
cd  ~/UserConfig

gpf
if [[ $_lastDir != UserConfig ]] {
  cd  $lastDir
}
