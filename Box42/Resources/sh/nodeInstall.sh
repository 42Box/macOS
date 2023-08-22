#!/bin/sh

#42Box: https://github.com/42Box
#Author: chanheki
#Date: 2023/08/10

# BOXY FOX
echo  ""
echo  "\033[38;5;208m Boxy Fox Node install"
echo  ""
echo  "                      ████████"
echo  "                  ▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒"
echo  "              ████                    ██████"
echo  "            ██                              ████"
echo  "          ██                                    ██"
echo  "        ██                          ░░░░░░░░░░░░░░██                                              ██"
echo  "      ██                      ░░░░░░░░░░░░░░░░░░░░██                                            ██████"
echo  "      ██                  ░░░░░░░░░░░░░░░░░░░░░░░░░░██                    ██████                ██████"
echo  "    ██                  ░░░░░░░░░░░░░░░░░░░░░░░░░░░░██                ████░░░░░░████          ██████████"
echo  "    ██                ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░██            ████░░░░░░░░░░░░░░████      ████████████"
echo  "    ██              ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░██      ████░░░░░░░░░░░░░░░░░░░░░░████  ████████████"
echo  "░░██              ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░██  ████░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░████████████████"
echo  "░░██            ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░████░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░██████████████"
echo  "░░██            ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░████░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░██████████"
echo  "░░██          ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░████░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░████████"
echo  "░░██          ░░░░░░░░░░░░░░░░░░░░░░░░░░░░████░░░░░░░░░░░░░░░░████░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░████"
echo  "░░██        ░░░░░░░░░░░░░░░░░░░░░░░░░░████▒▒▒▒░░░░░░░░░░░░░░░░████████░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░▒▒██▓▓▓▓"
echo  "    ██      ░░░░░░░░░░░░░░░░░░░░░░░░░░██▒▒████░░░░░░░░░░░░░░░░████████████░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░████▒▒██"
echo  "    ██      ░░░░░░░░░░░░░░░░░░░░░░░░░░██░░░░░░████░░░░░░░░░░░░░░████████████░░░░░░░░░░░░░░░░░░░░░░░░░░░░████░░░░░░██"
echo  "    ██    ░░░░░░░░░░░░░░░░░░░░░░░░░░░░██░░░░░░░░░░████░░░░░░░░░░██████████████░░░░░░░░░░░░░░░░░░░░░░████░░░░░░░░░░██"
echo  "      ██  ░░░░░░░░░░░░░░░░░░░░░░░░░░░░██░░░░░░░░░░▒▒▒▒████░░░░░░██████▒▒▒▒████████░░░░░░░░░░░░░░████▒▒▒▒░░░░░░░░░░██"
echo  "      ██  ░░░░░░░░░░░░░░░░░░░░░░░░░░░░██░░░░░░░░░░░░░░░░░░████░░░░████░░░░░░██████████░░░░░░████░░░░░░░░░░    ░░░░██"
echo  "      ░░▓▓░░░░░░░░░░░░░░░░░░░░░░░░░░░░██░░░░░░░░░░░░░░░░░░▓▓▓▓▓▓▓▓████▓▓░░░░▒▒████████▓▓▓▓▓▓▓▓▒▒░░░░░░░░░░    ░░░░██"
echo  "        ░░██░░░░░░░░░░░░░░░░░░░░░░░░░░██░░░░░░░░░░░░░░░░░░░░░░▒▒▒▒██████░░░░░░▒▒▒▒██████▒▒▒▒░░░░░░░░      ░░░░░░░░██"
echo  "            ██░░░░░░░░░░░░░░░░░░░░░░░░██░░░░░░░░░░░░░░░░░░░░░░░░░░▒▒▒▒████░░░░░░████▒▒        ░░░░░░  ░░░░    ░░░░██"
echo  "            ░░▓▓▓▓░░░░░░░░░░░░░░░░░░░░██░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░▒▒▓▓▓▓▓▓▓▓▒▒▒▒░░        ░░░░░░░░░░░░    ░░░░██"
echo  "              ░░░░▓▓▓▓░░░░░░░░░░░░░░░░██░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░▓▓██▒▒░░░░░░░░░░░░░░  ░░░░            ░░██"
echo  "                      ████░░░░░░░░░░░░██░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░██░░░░░░░░░░░░    ░░░░░░      ██    ░░██"
echo  "                          ████░░░░░░░░██░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░██░░░░░░░░          ░░░░    ████    ░░██"
echo  "                          ░░░░▓▓▓▓▓▓▓▓██░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░██░░░░░░░░          ░░░░    ████    ░░██"
echo  "                                      ██░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░██░░░░░░      ██    ░░░░    ███▒    ░░██"
echo  "                                      ██░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░██░░░░░░    ▒▒██    ░░░░    ▒▒▒▒    ░░██"
echo  "                                      ██░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░██░░░░░░    ████    ░░░░              ██"
echo  "                                      ██  ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░██░░░░░░    ████  ██                  ██"
echo  "                                      ██      ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░██░░░░░░        ██  ████              ██"
echo  "                                  ██████          ░░░░░░░░░░░░░░░░░░░░░░░░░░██░░░░░░                              ██"
echo  "                                ████░░████            ░░░░░░░░░░░░░░░░░░░░░░██░░░░            ░░░░░░            ████"
echo  "                              ████░░██░░██████            ░░░░░░░░░░░░░░░░░░██░░░░            ░░░░          ████"
echo  "                              ██░░██░░░░██████████            ░░░░░░░░░░░░░░██░░░░                      ██████████"
echo  "                                ██████████████████████            ░░░░░░░░░░██░░░░                  ████████████████"
echo  "                                    ██████████        ████            ░░░░░░██░░░░              ██████████████████████"
echo  "                                                          ████            ░░██░░            ████      ████████████████"
echo  "                                                              ████          ██          ██████████        ██████████"
echo  "                                                                  ████      ██      ████████████████        ██████"
echo  "                                                                      ████  ██  ██████████████████████"
echo  "                                                                          ██████      ████████████████"
echo  "                                                                                          ██████████"
echo  "                                                                                          ░░██████░░"
echo  ""


export N_PREFIX=/goinfre
curl -fsSL https://raw.githubusercontent.com/tj/n/master/bin/n | bash -s lts
echo "# bin folder for node.js">>~/.zshrc
echo 'export PATH="$PATH:$HOME/bin"' >> ~/.zshrc
export PATH=/goinfre/bin:$PATH
ln -s /goinfre/bin ~/bin

echo  "Download Complete"
