#! /bin/zsh


# brew_pack_install
local arr=($(< $HOME/.brew_packages))

brew install $arr

unset arr