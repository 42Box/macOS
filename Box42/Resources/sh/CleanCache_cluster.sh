#!/bin/bash

#42Box: https://github.com/42Box
#Author: chanheki
#Date: 2023/08/10

# BOXY FOX
echo  ""
echo  "\033[38;5;208m Boxy Fox Cleaning Cache 🧹🦊"
echo  ""

# Currently Size
Size=$(df -h /Users/$USER | grep /Users/$USER | awk '{print($2)}' | tr 'i' 'B')

# Currently used capacity
Used=$(df -h /Users/$USER | grep /Users/$USER | awk '{print($3)}' | tr 'i' 'B')

# Currently available capacity
Avail=$(df -h /Users/$USER | grep /Users/$USER | awk '{print($4)}' | tr 'i' 'B')
if [ "$Avail" == "0BB" ];
then
	Avail="0B"
fi

echo "$CYAN Currently used capacity $Used/$Size $RESET\n"

echo "$MAGENTA Clearing 🧹 cache ... $DELINE $RESET $CURSUP "

# Trash
echo "$RED Clearing 🧹 trash can ...$DELINE $RESET $CURSUP "
rm -rf /Users/$USER/.Trash/* &>/dev/null

# 42 Caches
echo "$RED Clearing 🧹 42Cache ...$DELINE $RESET $CURSUP"
rm -rf /Users/$USER/Library/*.42* &>/dev/null
rm -rf /Users/$USER/*.42* &>/dev/null
rm -rf /Users/$USER/.zcompdump* &>/dev/null
rm -rf /Users/$USER/.cocoapods.42_cache_bak* &>/dev/null

# General Caches
echo "$RED Clearing 🧹 Library ...$DELINE $RESET $CURSUP"
chmod -R 644 /Users/$USER/Library/Caches/Homebrew &>/dev/null
rm -rf /Users/$USER/Library/Caches/* &>/dev/null
rm -rf /Users/$USER/Library/Application\ Support/Caches/* &>/dev/null

echo "$RED Clearing 🧹 Slack ...$DELINE $RESET $CURSUP"
rm -rf /Users/$USER/Library/Application\ Support/Slack/Service\ Worker/CacheAvail/* &>/dev/null
rm -rf /Users/$USER/Library/Application\ Support/Slack/Cache/* &>/dev/null

echo "$RED Clearing 🧹 Discord ...$DELINE $RESET $CURSUP"
rm -rf /Users/$USER/Library/Application\ Support/discord/Cache/* &>/dev/null
rm -rf /Users/$USER/Library/Application\ Support/discord/Code\ Cache/js* &>/dev/null
rm -rf /Users/$USER/Library/Application\ Support/discord/Crashpad/completed/*  &>/dev/null

echo "$RED Clearing 🧹 VS Code ...$DELINE $RESET $CURSUP"
rm -rf /Users/$USER/Library/Application\ Support/Code/Cache/* &>/dev/null
rm -rf /Users/$USER/Library/Application\ Support/Code/CachedData/* &>/dev/null
rm -rf /Users/$USER/Library/Application\ Support/Code/CachedExtensionVSIXs/* &>/dev/null
rm -rf /Users/$USER/Library/Application\ Support/Code/Crashpad/completed/* &>/dev/null
rm -rf /Users/$USER/Library/Application\ Support/Code/User/workspaceAvail/* &>/dev/null

echo "$RED Clearing 🧹 Chrome ...$DELINE $RESET $CURSUP"
rm -rf /Users/$USER/Library/Application\ Support/Google/Chrome/Profile\ [0-9]/Service\ Worker/CacheAvail/* &>/dev/null
rm -rf /Users/$USER/Library/Application\ Support/Google/Chrome/Default/Service\ Worker/CacheAvail/* &>/dev/null
rm -rf /Users/$USER/Library/Application\ Support/Google/Chrome/Profile\ [0-9]/Application\ Cache/* &>/dev/null
rm -rf /Users/$USER/Library/Application\ Support/Google/Chrome/Default/Application\ Cache/* &>/dev/null
rm -rf /Users/$USER/Library/Application\ Support/Google/Chrome/Crashpad/completed/* &>/dev/null
# tmp downloaded files with browsers
rm -rf /Users/$USER/Library/Application\ Support/Chromium/Default/File\ System &>/dev/null
rm -rf /Users/$USER/Library/Application\ Support/Chromium/Profile\ [0-9]/File\ System &>/dev/null
rm -rf /Users/$USER/Library/Application\ Support/Google/Chrome/Default/File\ System &>/dev/null
rm -rf /Users/$USER/Library/Application\ Support/Google/Chrome/Profile\ [0-9]/File\ System &>/dev/null

# .DS_Store files
#echo "$RED Clearing 🧹 All .DS_Store ...$DELINE $RESET $CURSUP"
#find /Users/$USER -name .DS_Store -depth -exec rm {} \; &>/dev/null

# Delete desktop
rm -rf /Users/$USER/Desktop/Relocated Items &>/dev/null

# Calculate usage after cleaning
Used=$(df -h /Users/$USER | grep /Users/$USER | awk '{print($3)}' | tr 'i' 'B')

# Calculate usage after cleaning
Avail2=$(df -h /Users/$USER | grep /Users/$USER | awk '{print($4)}' | tr 'i' 'B')
if [ "$Avail2" == "0BB" ];
then
	Avail2="0B"
fi

# Output the result
echo "\n$MAGENTA ✨ Complete Clearing cache ✨ $RESET \n"
echo "$GREEN Available/Used/Size $Avail2/$Used/$Size $RESET\n"
echo "📦: https://github.com/42Box"
echo "🦊: chanheki in 42Box"
echo ""
