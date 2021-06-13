#!/bin/bash

mkdir ~/.vim
cd ~/.vim
mkdir colors

git clone https://github.com/tomasr/molokai

mv molokai/colors/molokai.vim ~/.vim/colors/

cp ~/.vimrc ~/.vimrc.bak

cat << 'EOF' >> ~/.vimrc
syntax on
colorscheme molokai
set t_Co=256
EOF
