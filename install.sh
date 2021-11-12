#!/bin/sh
#  12/11/2021
#  Edited by Vincenzo Favara
#  ---------------------------------------------------------------------------

git clone https://github.com/vivi7/dotfiles.git
mv ./dotfile/bashrc.sh ~/bashrc
rm -f dotfiles
source ~/bashrc -i
rm ~/bashrc

