#/bin/sh

if [ -f /usr/local/bin/convert ] ; then
    CONVERT=/usr/local/bin/convert
elif [ -f /opt/local/bin/convert ] ; then
    CONVERT=/opt/local/bin/convert
else
    exit 1
fi

PASS=$(/usr/bin/openssl rand -base64 6)
HOST=$(hostname -s)
USER=$(id -n -u)
IMAGE="Zoom backdrops-spring-sunrise"

echo "USER: ${USER} ${HOST} Airport Password: ${PASS}" 
echo "USER: ${USER} ${HOST} Airport Password: ${PASS}" >> /var/log/wifibg/wifibg-manual-run.log

security add-generic-password -a AirPort -l en1 -j "Internet-sharing password" -s com.apple.network.wlan.swap.ssid.en1 -w "${PASS}" -U

$CONVERT "/Library/Desktop Pictures/$IMAGE.jpg" -font Arial -weight 80 -pointsize 36 -gravity North -draw "fill black text 520,60 \"Neyman WiFi Password: ${PASS}\"" "/Library/Desktop Pictures/$IMAGE"_Anno.jpg

networksetup -setairportpower en1 off
sleep 2
networksetup -setairportpower en1 on

DOCK=$(ps augwx | grep MacOS/Dock | grep -v grep | awk '{print $2}')
if [ -z "$DOCK" ] ; then
    echo 'Nothing to do'
else
    kill ${DOCK}
fi
