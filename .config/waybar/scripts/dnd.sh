#!/bin/sh

case $1'' in
'status') 
    printf '{\"alt\":\"%s\",\"tooltip\":\"mode: %s\",\"class\":\"%s\"}' $(makoctl mode | grep -q 'do-not-disturb' && echo dnd || echo default) $(makoctl mode | tail -1) $(makoctl mode | tail -1)
    ;;
'restore')
    makoctl restore
    ;;
'toggle')
    makoctl mode | grep 'do-not-disturb' && makoctl mode -r do-not-disturb || makoctl mode -a do-not-disturb ; pkill -RTMIN+11 waybar
    ;;
esac
