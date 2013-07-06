#!/bin/bash
# File: update.sh
# Date: Sat Jul 06 20:45:32 2013 +0800
# Author: Yuxin Wu <ppwwyyxxc@gmail.com>
rm vim vimrc -rf
cp ~/.vimrc ./vimrc -Hv
cp ~/.vim ./vim -Hvr
rm vim/bundle -rf

