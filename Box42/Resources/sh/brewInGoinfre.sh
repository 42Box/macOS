#!/bin/bash

#42Box: https://github.com/42Box
#Author: chanheki
#Date: 2023/08/10

brew --version || echo "export PATH=/goinfre/.brew/bin:$PATH" >> /USER/$USER/.zshrc && brew --version || git clone --depth=1 https://github.com/Homebrew/brew /goinfre/.brew && export PATH=/goinfre/.brew/bin:$PATH && brew update && ln -s /goinfre/.brew /USER/$USER/.brew

echo  "Download Complete"
