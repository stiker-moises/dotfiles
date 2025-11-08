#!/run/current-system/sw/bin/zsh
RET=$(echo -e "Shutdown\nReboot\nSleep\nHibernate" | walker -d)
case $RET in
	Shutdown) systemctl poweroff ;;
	Reboot) systemctl reboot ;;
	Sleep) sleep 0.1 && powerprofilesctl set power-saver ; ( systemctl sleep & powerprofilesctl set power-saver & pidof hyprlock || ( hyprlock -c ~/.config/hypr/hyprlock/hyprlock-screenshot.conf > /dev/null || while ! hyprlock -c ~/.config/hypr/hyprlock/hyprlock-startup.conf > /dev/null; do sleep 0.01 > /dev/null; done > /dev/null )) ; ( rg -qq 0 /sys/class/power_supply/*/online && powerprofilesctl set power-saver || powerprofilesctl set performance ) ;;
	Hibernate) sleep 0.1 && systemctl hibernate & powerprofilesctl set power-saver & pidof hyprlock || ( hyprlock -c ~/.config/hypr/hyprlock/hyprlock-screenshot.conf > /dev/null || while ! hyprlock -c ~/.config/hypr/hyprlock/hyprlock-startup.conf > /dev/null; do sleep 0.01 > /dev/null; done > /dev/null ) ; ( rg -qq 0 /sys/class/power_supply/*/online && powerprofilesctl set power-saver || powerprofilesctl set performance ) ;;
#	Logout) loginctl terminate-user $USER ;;
esac
