#! /bin/zsh
local arr=($(< $HOME/.brew_packages))

brew install $arr

unset arr