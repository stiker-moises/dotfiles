#!/run/current-system/sw/bin/zsh
RET=$(echo -e "Bedroom\nBathroom\nIcecream" | walker -d )
case $RET in
	Bedroom) python ~/.config/scripts/bedroom-on.py ;;
	Bathroom) python ~/.config/scripts/bathroom-on.py ;;
	Icecream) python ~/.config/scripts/icecream-on.py ;;
esac
