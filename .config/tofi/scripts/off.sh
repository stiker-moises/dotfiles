#!/run/current-system/sw/bin/zsh
RET=$(echo -e "Bedroom\nBathroom\nIcecream" | tofi --prompt-text " " --height 122 --width 125 )
case $RET in
	Bedroom) python ~/.config/tofi/scripts/bedroom-off.py ;;
	Bathroom) python ~/.config/tofi/scripts/bathroom-off.py ;;
	Icecream) python ~/.config/tofi/scripts/icecream-off.py ;;
esac
