#!/bin/sh

##USER="${1:-scflocal}"
USER=$(id -n -u)
IMAGE="Sierra"

if [ ! -f "/Library/Desktop Pictures/${IMAGE}_Anno.jpg" ] ; then
    echo "${IMAGE}_Anno.jpg not found"
    exit 1
fi

killall Dock
