#!/run/current-system/sw/bin/zsh
RET=$(echo -e "Toggle\nDaylight\nNight\nDim" | walker -d )
case $RET in
	Daylight) python ~/.config/scripts/broadcast_color.py 41134 0 65535 7000 ;;
	Night) python ~/.config/scripts/broadcast_color.py 41134 0 65535 2500 ;;
	Dim) python ~/.config/scripts/broadcast_color.py 41134 0 655 2500 ;;
	Toggle) sh ~/.config/scripts/onoff.sh ;;
esac
