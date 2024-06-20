#!/bin/bash
# GestNav4 installation skins et mods à partir de /nng sur clé

dir2=`tail -n 1 /etc/mtab`
dir=${dir2:10:20}
cle="$dir/GestNav4/Ne_Pas_Modifier"
	echo "******* script installation GestNav4 sur MN *********" > /dev/kmsg
f="$dir/GestNav4"
source /navi_rw/utility/GestNav4/Traduction.sh
source /navi_rw/utility/GestNav4/SuiviLog.sh
suivi_log "installation GestNav4SurMN"

function EnvoiSon
{
  echo "son=$1  type=$2 dure=$3s "> /dev/kmsg
  if [ $2 = "radio" ]; then
    echo "type = radio" > /dev/kmsg
	echo -en '\xAA\x51\x00\x02\x03\x01\xFB' > /dev/ttymxc1  #radio 2 usb
	/navi_rw/utility/GestNav4/volume.sh
	sleep 2
	/usr/bin/aplay $dir/GestNav4/Ne_Pas_Modifier/son/$1
	sleep $3
	echo -en '\xAA\x51\x00\x02\x00\x01\xF8' > /dev/ttymxc1  #usb 2 radio
	/navi_rw/utility/GestNav4/volume.sh
  elif [ $2 = "dab" ]; then
    echo "type = dab" > /dev/kmsg
	echo -en '\xAA\x51\x00\x02\x03\x0c\xF6' > /dev/ttymxc1  #dab 2 usb
	/navi_rw/utility/GestNav4/volume.sh
	/usr/bin/aplay $dir/GestNav4/Ne_Pas_Modifier/son/$1
	sleep $3
	echo -en '\xAA\x51\x00\x02\x01\x0c\xF4' > /dev/ttymxc1  #dab 2 radio
	/navi_rw/utility/GestNav4/volume.sh	
  else
	echo "type = autre" > /dev/kmsg
	/usr/bin/aplay $dir/GestNav4/Ne_Pas_Modifier/son/$1
  fi
}

if [ -d "$f" ]
then
	/navi_rw/utility/GestNav4/LancementPopup.sh "$GestNav4_sur_MN" &
	EnvoiSon startup.wav $1 1         #son, type=$1, durée en seconde
#	/usr/bin/aplay $cle/son/startup.wav
	killall nngnavi
	mount -o remount,rw /navi
	/bin/sync

	rm -rfv /navi/utility/GestNav4/Ne_Pas_Modifier > /dev/kmsg
	mkdir -p /navi/utility/GestNav4/Ne_Pas_Modifier
	cp -Rva $dir/GestNav4/Ne_Pas_Modifier/basemap /navi/utility/GestNav4/Ne_Pas_Modifier
	cp -Rva $dir/GestNav4/Ne_Pas_Modifier/fonts /navi/utility/GestNav4/Ne_Pas_Modifier
	cp -Rva $dir/GestNav4/Ne_Pas_Modifier/images_boot /navi/utility/GestNav4/Ne_Pas_Modifier	
	cp -Rva $dir/GestNav4/Ne_Pas_Modifier/kml_originaux /navi/utility/GestNav4/Ne_Pas_Modifier	
	cp -Rva $dir/GestNav4/Ne_Pas_Modifier/radars_std /navi/utility/GestNav4/Ne_Pas_Modifier	
	cp -Rva $dir/GestNav4/Ne_Pas_Modifier/son /navi/utility/GestNav4/Ne_Pas_Modifier
	cp -Rva $dir/GestNav4/Ne_Pas_Modifier/SonRadar /navi/utility/GestNav4/Ne_Pas_Modifier	
	cp -Rva $dir/GestNav4/Ne_Pas_Modifier/ux /navi/utility/GestNav4/Ne_Pas_Modifier
	cp -Rva $dir/GestNav4/Ne_Pas_Modifier/loading_finished /navi/utility/GestNav4/Ne_Pas_Modifier
	cp -Rva $dir/GestNav4/Ne_Pas_Modifier/voix /navi/utility/GestNav4/Ne_Pas_Modifier
	#cp -Rva $dir/GestNav4/Ne_Pas_Modifier/video /navi/utility/GestNav4/Ne_Pas_Modifier	
	
		Erreur="0"	
	result=$(find /navi -type f -size 0 -exec echo -n "\t=> \"{}\"\n" \;)
#	result=$(find /navi -maxdepth 5 -type f -size 0)
	if [ -n "$result" ]; then
		echo "fichier vide trouvé" > /dev/kmsg
		suivi_log "fichier vide trouvé :\n`echo -en $result`"
		ecrit_log "fichier vide trouvé :\n`echo -en $result`"
		Erreur="1"
	#	echo $result | xargs -n1 rm -vf
	fi
		
	chown 1004:1004 /navi/* > /dev/kmsg
	mount -o remount,ro /navi > /dev/kmsg
	/bin/sync
# lancement du son fin
	if [ $Erreur = "1" ]; then
		if [ -d "$dure" ];then
			if [ $1 = "radio" ]; then
				echo "type = radio en dure" > /dev/kmsg
				echo -en '\xAA\x51\x00\x02\x03\x01\xFB' > /dev/ttymxc1  #radio 2 usb
				/navi_rw/utility/GestNav4/volume.sh
				sleep 2
				echo "son = $dure/GestNav4/Ne_Pas_Modifier/son/alerte.wav" 
				/usr/bin/aplay $dure/son/alerte.wav
				sleep 1
				echo -en '\xAA\x51\x00\x02\x00\x01\xF8' > /dev/ttymxc1  #usb 2 radio
				/navi_rw/utility/GestNav4/volume.sh
			elif [ $2 = "dab" ]; then
				echo "type = dab" > /dev/kmsg
				echo -en '\xAA\x51\x00\x02\x03\x0c\xF6' > /dev/ttymxc1  #dab 2 usb
				/navi_rw/utility/GestNav4/volume.sh
				/usr/bin/aplay $dir/GestNav4/Ne_Pas_Modifier/son/$1
				sleep $3
				echo -en '\xAA\x51\x00\x02\x01\x0c\xF4' > /dev/ttymxc1  #dab 2 radio
				/navi_rw/utility/GestNav4/volume.sh	
			else
				echo "type = autre en dure" > /dev/kmsg
				/usr/bin/aplay $dure/son/alerte.wav
			fi
		else
			if [ $1 = "radio" ]; then
				echo "type = radio sur clé" > /dev/kmsg
				echo -en '\xAA\x51\x00\x02\x03\x01\xFB' > /dev/ttymxc1  #radio 2 usb
				/navi_rw/utility/GestNav4/volume.sh
				echo "son = $dure/GestNav4/Ne_Pas_Modifier/son/alerte.wav" 
				sleep 1
				/usr/bin/aplay $dir/GestNav4/Ne_Pas_Modifier/son/alerte.wav
				sleep 1
				echo -en '\xAA\x51\x00\x02\x00\x01\xF8' > /dev/ttymxc1  #usb 2 radio
				/navi_rw/utility/GestNav4/volume.sh
			elif [ $2 = "dab" ]; then
				echo "type = dab" > /dev/kmsg
				echo -en '\xAA\x51\x00\x02\x03\x0c\xF6' > /dev/ttymxc1  #dab 2 usb
				/navi_rw/utility/GestNav4/volume.sh
				/usr/bin/aplay $dir/GestNav4/Ne_Pas_Modifier/son/$1
				sleep $3
				echo -en '\xAA\x51\x00\x02\x01\x0c\xF4' > /dev/ttymxc1  #dab 2 radio
				/navi_rw/utility/GestNav4/volume.sh	
			else
				echo "type = autre sur cle" > /dev/kmsg
				/usr/bin/aplay $dir/GestNav4/Ne_Pas_Modifier/son/alerte.wav
			fi
		fi		
	/navi_rw/utility/GestNav4/Diagnostic.sh	$1
	else			
	# lancement du son installation.wav
		if [ -d "$dure" ];then
			if [ $1 = "radio" ]; then
			
				echo -en '\xAA\x51\x00\x02\x03\x01\xFB' > /dev/ttymxc1  #radio 2 usb
				/navi_rw/utility/GestNav4/volume.sh
				/usr/bin/aplay $dure/son/installation.wav
				sleep 3
				echo -en '\xAA\x51\x00\x02\x00\x01\xF8' > /dev/ttymxc1  #usb 2 radio
				/navi_rw/utility/GestNav4/volume.sh
			elif [ $2 = "dab" ]; then
				echo "type = dab" > /dev/kmsg
				echo -en '\xAA\x51\x00\x02\x03\x0c\xF6' > /dev/ttymxc1  #dab 2 usb
				/navi_rw/utility/GestNav4/volume.sh
				/usr/bin/aplay $dir/GestNav4/Ne_Pas_Modifier/son/$1
				sleep $3
				echo -en '\xAA\x51\x00\x02\x01\x0c\xF4' > /dev/ttymxc1  #dab 2 radio
				/navi_rw/utility/GestNav4/volume.sh	
			else
				/usr/bin/aplay $dure/son/installation.wav
			fi

		else
			ecrit_log "		= > OK" ""
			if [ $1 = "radio" ]; then
			
				echo -en '\xAA\x51\x00\x02\x03\x01\xFB' > /dev/ttymxc1  #radio 2 usb
				/navi_rw/utility/GestNav4/volume.sh
				/usr/bin/aplay $dir/GestNav4/Ne_Pas_Modifier/son/installation.wav
				sleep 3
				echo -en '\xAA\x51\x00\x02\x00\x01\xF8' > /dev/ttymxc1  #usb 2 radio
				/navi_rw/utility/GestNav4/volume.sh
			elif [ $2 = "dab" ]; then
				echo "type = dab" > /dev/kmsg
				echo -en '\xAA\x51\x00\x02\x03\x0c\xF6' > /dev/ttymxc1  #dab 2 usb
				/navi_rw/utility/GestNav4/volume.sh
				/usr/bin/aplay $dir/GestNav4/Ne_Pas_Modifier/son/$1
				sleep $3
				echo -en '\xAA\x51\x00\x02\x01\x0c\xF4' > /dev/ttymxc1  #dab 2 radio
				/navi_rw/utility/GestNav4/volume.sh	
			else
				/usr/bin/aplay $dir/GestNav4/Ne_Pas_Modifier/son/installation.wav
			fi
		fi
	fi
	/navi_rw/utility/GestNav4/PopupFin.sh &

else
	/navi_rw/utility/GestNav4/LancementPopup.sh "$Map_changer_pas_de_cle" &
	sleep 6
	/navi_rw/utility/GestNav4/PopupFin.sh &
fi
echo "***************************************" > /dev/kmsg	
exit 0