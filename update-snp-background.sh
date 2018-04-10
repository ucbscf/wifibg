#!/bin/sh

##USER="${1:-scflocal}"
USER=$(id -n -u)
IMAGE="Sierra"

if [ ! -f "/Library/Desktop Pictures/${IMAGE}_Anno.jpg" ] ; then
    echo "${IMAGE}_Anno.jpg not found"
    exit 1
fi

if [ -f "/Users/${USER}/wifibg.log" ] ; then
    
    if [ "$(cmp --silent /Users/${USER}/wifibg.log) /var/log/wifibg/wifibg.log)" == "1" ] ; then 
        killall Dock
    	cp /var/log/wifibg/wifibg.log /Users/${USER}/wifibg.log
    fi
else
    cp /var/log/wifibg/wifibg.log /Users/${USER}/wifibg.log
fi

