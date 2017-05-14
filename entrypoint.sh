#!/bin/sh
set -e
set -x

if [ $(grep -ci $USER /etc/shadow) -eq 0 ]; then
    useradd -r -G lpadmin -M $USER
fi

echo $USER:$PASSWORD | chpasswd

mkdir -p /config/ppd
mkdir -p /services
rm -rf /etc/cups/ppd
ln -s /config/ppd /etc/cups
if [ ! -f /config/printers.conf ]; then
    touch /config/printers.conf
fi
cp /config/printers.conf /etc/cups/printers.conf

/printer-update.sh &
exec /usr/sbin/cupsd -f