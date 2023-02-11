#!/bin/bash -e
echo "Cleanup original vimfiles to ~/backup_vim* ..."
[[ -f ~/.vimrc ]] && mv -v ~/.vimrc ~/backup_vimrc
[[ -d ~/.vim ]] && mv ~/.vim ~/backup_vim
rm -rf ~/.config/nvim
rm -rf ~/.vim

REPO_ROOT=$(dirname "$0")

echo "Linking files..."
pushd
cd $HOME
ln -sfv $REPO_ROOT/vim ./.vim
ln -svf $REPO_ROOT/vimrc ./.vimrc

mkdir -p ~/.config/
ln -svf $REPO_ROOT/vim ./.config/nvim
ln -svf $REPO_ROOT/vimrc ./.config/nvim/init.vim
popd

echo "Generating dict..."
cd ~/.vim/static/
python3 dict_to_cases.py

mkdir -p ~/.vimtmp/undo
mkdir -p ~/.vimtmp/vim-fuf-data

#vim +PlugInstall +qall
#nvim -c "PackerInstall"

#echo "Patching..."
#for i in ~/.vim/patch/*; do
   #filename=`basename $i`
   #bundle="${filename%.*}"
   #echo "Patching $bundle ..."
   #cd ~/.vim/bundle/$bundle
   #patch -p0 < $i
#done

echo "Finish installing ppwwyyxx/dotvim"
