#!/bin/sh
#edu.berkeley.stat.updatesnpbackground.plist

IMAGE="${IMAGE}"
USRSBIN='/usr/local/sbin'
LDDIR='/Library/LaunchDaemons'
LADIR='/Library/LaunchAgents'
PROGDIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

 $PROGDIR

if [ ! -d "/var/log/wifibg" ] ; then
     mkdir /var/log/wifibg
     chown 755 /var/log/wifibg
fi

for i in update-shared-network-pass.sh update-shared-network-pass.sh clean-account.sh
    do  "copying ${i} to $USRSBIN/${i}" ;
    if [ ! -f "$USRSBIN/${i}" ] ; then
         cp ${PROGDIR}/${i} $USRSBIN/${i}
         chmod 755 $USRSBIN/${i}
    fi
done

 "Initiating _Anno graphics file"
if [ -f "/Library/Desktop Pictures/${IMAGE}.jpg" ] ; then
    if [ ! -f "/Library/Desktop Pictures/${IMAGE}_Anno.jpg" ] ; then
         cp -pR "/Library/Desktop Pictures/${IMAGE}.jpg" "/Library/Desktop Pictures/${IMAGE}_Anno.jpg" 
    fi
fi

if [ ! -f "$LADIR/edu.berkeley.stat.updatesnpbackground.plist" ] ; then
     cp ${PROGDIR}/LaunchAgents/edu.berkeley.stat.updatesnpbackground.plist $LADIR/edu.berkeley.stat.updatesnpbackground.plist
     launchctl load -w $LADIR/edu.berkeley.stat.updatesnpbackground.plist
fi

for i in edu.berkeley.stat.cleanaccount.plist edu.berkeley.stat.updatesharedwifi.plist
    do  "copying LaunchDaemons"
        if [ ! -f "$LDDIR/${i}" ] ; then
             cp ${PROGDIR}/LaunchDaemons/{i} $LDDIR/${i}
             launchctl load -w $LDDIR/${i}
        fi
done

osascript -e "tell application \"System Events\" to set picture of every desktop to (\"/Library/Desktop Pictures/${IMAGE}_    Anno.jpg\" as POSIX file as alias)"
