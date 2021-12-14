#!/bin/bash
# File: update.sh
# Date: Tue Jul 09 15:57:27 2013 +0800
# Author: Yuxin Wu <ppwwyyxxc@gmail.com>

if [[ -L ~/.vimrc ]]; then
  echo "~/.vimrc is a link. Skipping"
else
  rm vim vimrc -rf
  cp ~/.vimrc ./vimrc -Hv
fi
rsync -avPL --delete --exclude=bundle ~/.vim ./
mv .vim vim
rm vim/.netrwhist
rm vim/init.vim
git a . -A
