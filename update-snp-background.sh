#!/bin/sh

##USER="${1:-scflocal}"
USER=$(id -n -u)
IMAGE="Sierra"

if [ ! -f "/Library/Desktop Pictures/${IMAGE}_Anno.jpg" ] ; then
    echo "${IMAGE}_Anno.jpg not found"
    exit 1
fi

if [ -f "/Users/${USER}/wifibgi.log" ] ; then
    DIFF="$(diff -q /var/log/wifibg/wifibg.log)"
    if [ "${DIFF}" != "" ] ; then 
        killall Dock
    fi
else
    cp /var/log/wifibg/wifibg.log /Users/${USER}/wifibgi.log
fi

