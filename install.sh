#!/bin/bash
# File: install.sh
# Date: Sat Jul 06 20:51:16 2013 +0800
# Author: Yuxin Wu <ppwwyyxxc@gmail.com>
echo "Backup original vimfiles to ~/backup_vim* ..."
cp ~/.vimrc ~/backup_vimrc -v
cp ~/.vim ~/backup_vim -rf

echo "Copying files..."
cp vimrc ~/.vimrc
rm ~/.vim -rvf && cp vim ~/.vim -rvf

echo "Installing Bundles ..."
mkdir -p ~/.vim/bundle/vundle
git clone https://github.com/gmarik/vundle.git ~/.vim/bundle/vundle
vim +BundleInstall +qall

mkdir -p ~/.vimtmp/undo
mkdir -p ~/.vimtmp/vim-fuf-data
mkdir -p ~/.vimtmp/neocomplcache

for i in ~/.vim/patch/*; do
	filename=`basename $i`
	bundle="${filename%.*}"
	echo "Patching $bundle ..."
	cd ~/.vim/bundle/$bundle
	patch -p0 < $i
done

echo "Compiling ycm_core ... (please make sure you have libclang.so in your system)"
BUILD_DIR=/tmp/ycm_build
mkdir -p BUILD_DIR
cd BUILD_DIR
cmake -G "Unix Makefiles" -DUSE_SYSTEM_LIBCLANG=ON . ~/.vim/bundle/YouCompleteMe/cpp
make ycm_core
cd && rm BUILD_DIR -rf

echo "Finish installing ppwwyyxx/dotvim"
