#!/run/current-system/sw/bin/zsh
RET=$(echo -e "Bedroom\nBathroom\nIcecream" | walker -d )
case $RET in
	Bedroom) python ~/.config/scripts/bedroom-off.py ;;
	Bathroom) python ~/.config/scripts/bathroom-off.py ;;
	Icecream) python ~/.config/scripts/icecream-off.py ;;
esac
