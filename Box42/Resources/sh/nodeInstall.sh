#!/bin/sh

#42Box: https://github.com/42Box
#Author: chanheki
#Date: 2023/08/10

export N_PREFIX=/goinfre
curl -fsSL https://raw.githubusercontent.com/tj/n/master/bin/n | bash -s lts
echo "# bin folder for node.js">>/USER/$USER/.zshrc
echo 'export PATH="$PATH:$HOME/bin"' >> /USER/$USER/.zshrc
export PATH=/goinfre/bin:$PATH
ln -s /goinfre/bin /USER/$USER/bin

echo  "Download Complete"
