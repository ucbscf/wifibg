#/bin/sh

WIFIBGDIR='/var/log/wifibg'

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
IMAGE="Sierra"

if [ -f "$WIFIBGDIR/wifibg.log" ] ; then
    echo "USER: ${USER} ${HOST} Airport Password: ${PASS}"
else
    echo "USER: ${USER} ${HOST} Airport Password: ${PASS}" > $WIFIBGDIR/wifibg.log
fi

security add-generic-password -a AirPort -l en1 -j "Internet-sharing password" -s com.apple.network.wlan.swap.ssid.en1 -w "${PASS}" -U

$CONVERT "/Library/Desktop Pictures/$IMAGE.jpg" -font Arial -weight 100 -pointsize 75 -gravity North -draw "fill black text 15,120 \"${HOST} Airport Password: ${PASS}\"" "/Library/Desktop Pictures/$IMAGE"_Anno.jpg

networksetup -setairportpower en1 off
sleep 2
networksetup -setairportpower en1 on
