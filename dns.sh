#!/bin/bash

clear

echo "Crear DNS automaticament"
echo "Fet per Anas Chatt"

read -p "Introdueix la teva IP:" IP
read -p "Introdueix el teu ns:" ns
read -p "Introdueix el teu domini:" domini

echo "zone \"domini\" {" > /etc/bind/named.conf.local
echo "	type master; " >> /etc/bind/named.conf.local
echo "	file \"/etc/bind/db.domini\";" >> /etc/bind/named.conf.local
echo "};" >> /etc/bind/named.conf.local

sed -i 's/domini/'$domini'/' /etc/bind/named.conf.local
cp /etc/bind/db.empty /etc/bind/db.$domini
sed -i 's/localhost/'$ns.$domini'/' /etc/bind/db.$domini

echo "@	IN	A	"$IP >> /etc/bind/db.$domini
echo $ns"	IN	A	"$IP >> /etc/bind/db.$domini
echo "www	IN	A	"$IP >> /etc/bind/db.$domini
echo "ftp	IN	A	"$IP >> /etc/bind/db.$domini
echo "@	IN	MX	10	correu."$domini >> /etc/bind/db.$domini
echo "correu	IN	A	"$IP >> /etc/bind/db.$domini
echo "dhcp	IN	A	"$IP >> /etc/bind/db.$domini

echo "search" $domini > /etc/resolv.conf
echo "nameserver" $IP >> /etc/resolv.conf
echo "nameserver 192.168.0.100" >> /etc/resolv.conf

echo "El teu DNS ha sigut configurat !"

