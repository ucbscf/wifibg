#!/bin/bash

IMAGE="Sierra"
LDDIR='/Library/LaunchDaemons'
LADIR='/Library/LaunchAgents'
PROGDIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

install -d -m 0755 /var/log/wifibg

for i in update-shared-network-pass.sh cleanaccount.sh
    do echo "copying ${i} to /usr/local/sbin/" ;
    if [ ! -f "/usr/local/sbin/${i}" ] ; then
         install -m 0755 $PROGDIR/${i} /usr/local/sbin/${i}
    fi
done

echo "Initiating _Anno graphics file"
if [ -f "/Library/Desktop Pictures/${IMAGE}.jpg" ] ; then
    if [ ! -f "/Library/Desktop Pictures/${IMAGE}_Anno.jpg" ] ; then
         cp -pR "/Library/Desktop Pictures/${IMAGE}.jpg" "/Library/Desktop Pictures/${IMAGE}_Anno.jpg" 
    fi
fi

#if [ ! -f "$LADIR/edu.berkeley.stat.updatesnpbackground.plist" ] ; then
#     cp $PROGDIR/LaunchAgents/edu.berkeley.stat.updatesnpbackground.plist $LADIR/edu.berkeley.stat.updatesnpbackground.plist
#     launchctl load -w $LADIR/edu.berkeley.stat.updatesnpbackground.plist
#fi

for i in edu.berkeley.stat.cleanaccount.plist edu.berkeley.stat.updatesharedwifi.plist
    do echo "copying ${i} to $LDDIR/"
        if [ ! -f "$LDDIR/${i}" ] ; then
             cp $PROGDIR/LaunchDaemons/${i} $LDDIR/${i}
             launchctl load -w $LDDIR/${i}
        fi
done

cp $PROGDIR/etc/pf.anchors/* /etc/pf.anchors/ 

pfctl -d 
pfctl -e -f /etc/pf.conf

osascript -e "tell application \"System Events\" to set picture of every desktop to (\"/Library/Desktop Pictures/${IMAGE}_Anno.jpg\" as POSIX file as alias)"
