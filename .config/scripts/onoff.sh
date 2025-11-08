#!/run/current-system/sw/bin/zsh
RET=$(echo -e "On\nOff" | walker -d )
case $RET in
	On) sh ~/.config/scripts/on.sh ;;
	Off) sh ~/.config/scripts/off.sh ;;
esac
