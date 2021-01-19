#!/bin/bash

dwmblocks &

~/my.scripts/mailsync &
~/my.scripts/chk.packages.sh &

# picom
picom -o 0.95 -i 0.88 --detect-rounded-corners --vsync --blur-background-fixed -f -D 5 -c -b

# fcitx5
fcitx5 &

# albert
albert &
