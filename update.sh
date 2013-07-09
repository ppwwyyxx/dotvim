#!/bin/bash
# File: update.sh
# Date: Tue Jul 09 15:57:27 2013 +0800
# Author: Yuxin Wu <ppwwyyxxc@gmail.com>

rm vim vimrc -rf
cp ~/.vimrc ./vimrc -Hv
cp ~/.vim ./vim -Hvr
rm vim/bundle -rf
git a . -A

