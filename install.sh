#!/bin/bash -e
# File: install.sh
# Date: Sun Oct 15 00:15:02 2017 -0700
echo "Backup original vimfiles to ~/backup_vim* ..."
[[ -f ~/.vimrc ]] && mv -v ~/.vimrc ~/backup_vimrc
[[ -d ~/.vim ]] && mv ~/.vim ~/backup_vim

echo "Copying files..."
cp vimrc ~/.vimrc
rm ~/.vim -rvf && cp vim ~/.vim -rvf

echo "Generating dict..."
cd ~/.vim/static/
python dict_to_cases.py

mkdir -p ~/.vimtmp/undo
mkdir -p ~/.vimtmp/vim-fuf-data
mkdir -p ~/.config/
rm -rf ~/.config/nvim

cd ~/.config
ln -sfv ~/.vim ./nvim
cd -

cd ~/.vim
ln -svf ~/.vimrc ./init.vim
cd -

vim +PlugInstall +qall

#echo "Patching..."
#for i in ~/.vim/patch/*; do
   #filename=`basename $i`
   #bundle="${filename%.*}"
   #echo "Patching $bundle ..."
   #cd ~/.vim/bundle/$bundle
   #patch -p0 < $i
#done

echo "Finish installing ppwwyyxx/dotvim"
