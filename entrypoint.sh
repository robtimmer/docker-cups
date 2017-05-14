#!/bin/sh
set -e
set -x

if [ $(grep -ci $USER /etc/shadow) -eq 0 ]; then
    useradd -r -G lpadmin -M $USER
fi

echo $USER:$PASSWORD | chpasswd

mkdir -p /data/config/ppd
mkdir -p /data/services
rm -rf /etc/cups/ppd
ln -s /data/config/ppd /etc/cups
if [ ! -f /data/config/printers.conf ]; then
    touch /data/config/printers.conf
fi
cp /data/config/printers.conf /etc/cups/printers.conf

/printer-update.sh &
exec /usr/sbin/cupsd -f