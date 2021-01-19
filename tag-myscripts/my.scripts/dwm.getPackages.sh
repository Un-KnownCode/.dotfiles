#!/bin/sh

# Displays number of upgradeable packages.
# For this to work, have a `pacman -Sy` command run in the background as a
# cronjob every so often as root. This script will then read those packages.
# When clicked, it will run an upgrade via pacman.
#
# Add the following text as a file in /usr/share/libalpm/hooks/statusbar.hook:
#
# [Trigger]
# Operation = Upgrade
# Type = Package
# Target = *
#
# [Action]
# Description = Updating statusbar...
# When = PostTransaction
# Exec = /usr/bin/pkill -RTMIN+8 dwmblocks # Or i3blocks if using i3.

case $BLOCK_BUTTON in
	1) alacritty -e sudo /usr/bin/pacman -Syu ;;
	2) sudo /usr/bin/pacman -Sy
		 if pacman -Qu | grep -v "\[ignored\]"
		 then
			sudo /usr/bin/pacman -Suw --noconfirm
			notify-send "$(/usr/bin/pacman -Qu)"
			notify-send "🎁 提示"  "有可用更新. 点击状态栏图标(📦)开始更新"
		 else
			notify-send "🎁 提示"  "同步完毕. 暂无可更新的软件包."
		 fi ;;
	3) notify-send "🎁 更新模块" "📦: 可升级的软件包数量
- 左键点击同步仓库更新软件包
- 中键点击查看可更新的软件包
- Shift + 中键更新软件包仓库"  ;;
	6) alacritty -e nvim "$0" ;;
  7) setsid -f alacritty -e sudo /usr/bin/pacman -Syy ;;
esac

pacman -Qu | grep -Fcv "[ignored]" | sed "s/^/📦/;s/^📦0$/已是最新/g"
