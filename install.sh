#!/bin/bash -e
# File: install.sh
# Date: Sat Jun 27 22:46:46 2015 +0800
# Author: Yuxin Wu <ppwwyyxxc@gmail.com>
echo "Backup original vimfiles to ~/backup_vim* ..."
[[ -f ~/.vimrc ]] && mv ~/.vimrc ~/backup_vimrc -v
[[ -d ~/.vim ]] && mv ~/.vim ~/backup_vim

LINE="---------------------------------------------------------------------"

echo "Copying files..."
cp vimrc ~/.vimrc
rm ~/.vim -rvf && cp vim ~/.vim -rvf

echo "Generating dict..."
cd ~/.vim/static/
python dict_to_cases.py

mkdir -p ~/.vimtmp/undo
mkdir -p ~/.vimtmp/vim-fuf-data

echo "Installing Bundles ..."
mkdir -p ~/.vim/bundle/vundle
git clone https://github.com/gmarik/vundle.git ~/.vim/bundle/vundle
vim +BundleInstall +qall

for i in ~/.vim/patch/*; do
   filename=`basename $i`
   bundle="${filename%.*}"
   echo "Patching $bundle ..."
   cd ~/.vim/bundle/$bundle
   patch -p0 < $i
done

YCM_PYTHON_DIR="bundle/YouCompleteMe/python"
if [[ -f ~/backup_vim/$YCM_PYTHON_DIR/ycm_core.so ]]; then
	cp ~/backup_vim/$YCM_PYTHON_DIR/*.so ~/.vim/$YCM_PYTHON_DIR
else
	echo "Compiling ycm_core ..."
	cd  ~/.vim/bundle/YouCompleteMe
	./install.py --clang-completer
fi

# install eclim
pacaur -S eclim

echo "Finish installing ppwwyyxx/dotvim"
