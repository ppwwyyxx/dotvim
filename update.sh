#!/bin/bash
# File: update.sh
# Date: Tue Jul 09 15:57:27 2013 +0800
# Author: Yuxin Wu <ppwwyyxxc@gmail.com>

rm vim vimrc -rf
cp ~/.vimrc ./vimrc -Hv
rsync -avPL --delete --exclude=bundle ~/.vim ./
mv .vim vim
rm vim/.netrwhist
git a . -A

