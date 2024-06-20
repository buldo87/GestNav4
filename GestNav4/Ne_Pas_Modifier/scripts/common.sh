#!/bin/bash
# fichier commun
dir2=`tail -n 1 /etc/mtab`
dir=${dir2:10:20}
clem=$dir
cle="$dir/GestNav4/Ne_Pas_Modifier"
dure="/navi/utility/GestNav4/Ne_Pas_Modifier"


function EnvoiSon
{
 # echo "son=$1  type=$2 dure=$3s "> /dev/kmsg
  if [ $2 = "radio" ]; then
 #   echo "type = radio" > /dev/kmsg
#	echo -en '\xAA\x51\x00\x02\x03\x01\xFB' > /dev/ttymxc1  #radio 2 usb
	/navi_rw/utility/GestNav4/volume.sh
	/usr/bin/aplay $dir/GestNav4/Ne_Pas_Modifier/son/$1
	sleep $3
#	echo -en '\xAA\x51\x00\x02\x00\x01\xF8' > /dev/ttymxc1  #usb 2 radio
	/navi_rw/utility/GestNav4/volume.sh
  elif [ $2 = "dab" ]; then
#    echo "type = dab" > /dev/kmsg
#	echo -en '\xAA\x51\x00\x02\x03\x0c\xF6' > /dev/ttymxc1  #dab 2 usb
	/navi_rw/utility/GestNav4/volume.sh
	/usr/bin/aplay $dir/GestNav4/Ne_Pas_Modifier/son/$1
	sleep $3
#	echo -en '\xAA\x51\x00\x02\x01\x0c\xF4' > /dev/ttymxc1  #dab 2 radio
	/navi_rw/utility/GestNav4/volume.sh
  else
#	echo "type = autre" > /dev/kmsg
	/usr/bin/aplay $dir/GestNav4/Ne_Pas_Modifier/son/$1
  fi
}

if [ -d "$dure" ]
then
#	echo "installation MN" > /dev/kmsg
	dir="/navi/utility"
	if [ -d "$cle" ]
	then
#		echo "installation sur clé" > /dev/kmsg
		dir=$clem
	fi
fi