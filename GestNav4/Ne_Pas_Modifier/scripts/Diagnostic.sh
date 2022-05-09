#!/bin/bash 
# GestNav4 Diagnostic sur clé
source /navi_rw/utility/GestNav4/Traduction.sh
source /navi_rw/utility/GestNav4/SuiviLog.sh
dure="/navi/utility/GestNav4/Ne_Pas_Modifier"

dir2=`tail -n 1 /etc/mtab`
dir=${dir2:10:20}
		echo "**********************" > /dev/kmsg
		echo " Diagnostic sur clé " > /dev/kmsg
		
file="$dir/Diagnostic_navigation.txt"
function ecrit_log
{
  echo -e "[`date +%d-%m-%Y_%H:%M:%S`] $1" >> "$file"
  echo -e "$2" >> "$file"
#  echo " " >> "$file"
  /bin/sync
}

function ecrit_log_nl
{
  echo "" >> "$file"
  ecrit_log "$1" "$2"
}

/navi_rw/utility/GestNav4/LancementPopup.sh "$Diagnostic" &
suivi_log "GestNav4 Diagnostic sur clé"

#lancement son début
if [ -d "$dure" ];then
	if [ $1 = "radio" ]; then
			echo "type = radio en dure" > /dev/kmsg
			echo -en '\xAA\x51\x00\x02\x03\x01\xFB' > /dev/ttymxc1  #radio 2 usb
			/navi_rw/utility/GestNav4/volume.sh
			echo "son = $dure/GestNav4/Ne_Pas_Modifier/son/startup.wav" 
			sleep 2
			/usr/bin/aplay $dure/son/startup.wav
			sleep 4
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
			/usr/bin/aplay $dure/son/startup.wav
	fi

else
	if [ $1 = "radio" ]; then
			echo "type = radio sur clé" > /dev/kmsg
			echo -en '\xAA\x51\x00\x02\x03\x01\xFB' > /dev/ttymxc1  #radio 2 usb
			/navi_rw/utility/GestNav4/volume.sh
			echo "son = $dure/GestNav4/Ne_Pas_Modifier/son/startup.wav" 
			sleep 2
			/usr/bin/aplay $dir/GestNav4/Ne_Pas_Modifier/son/startup.wav
			sleep 4
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
			/usr/bin/aplay $dir/GestNav4/Ne_Pas_Modifier/son/startup.wav
	fi
fi
#	sleep 4
mount -o remount,rw $dir
/bin/sync

ecrit_log "********** Diagnostic depuis GestNav **********" ""
cp -Rva /rw_data/log_Gestnav.txt $dir/Diagnostic_navigation.txt
ecrit_log "***********************************************" ""
	Erreur="0"	
	result=$(find /navi -type f -size 0 -exec echo -n "\t=> \"{}\"\n" \;)
#	result=$(find /navi -maxdepth 5 -type f -size 0)
	if [ -n "$result" ]; then
		echo "fichier vide trouvé" > /dev/kmsg
		suivi_log "***** fichier vide trouvé :\n`echo -en $result` ***** "
		ecrit_log "***** fichier vide trouvé :\n`echo -en $result` ***** "
		Erreur="1"
	#	echo $result | xargs -n1 rm -vf
	else
		echo "fichier vide non trouvé dans navi" > /dev/kmsg
		suivi_log "***** fichier vide non trouvé dans /navi ***** "
		ecrit_log "***** fichier vide non trouvé dans /navi ***** "		
	fi

color=$(/sbin/misc_getprop colouring | cut -c11-)

case $color in
        "0")
            echo " Couleurs Dacia M0 " > /dev/kmsg
			ecrit_log "***** Couleurs Dacia M0 ****" ""
            ;;
        "1")
            echo " Couleurs Renault MI " > /dev/kmsg
			ecrit_log "***** Couleurs Renault MI ****" ""
	    ;;
        *)
			echo "Oups pas la bonne version de couleurs LG" > /dev/kmsg
			ecrit_log "***** Oups pas la bonne version de couleurs LG $color****"
            ;;
esac 

test=$(sha256sum /usr/lib/libQt5Core.so.5.6.3 | cut -c1-64)
case $test in
		"392d03acc56205fe5bd7788db06a7f80f59fcfd584996296c03eaaffe41e0c7f")
			echo " libQt5Core.so.5.6.3 Original " > /dev/kmsg
			ecrit_log "***** libQt5Core.so.5.6.3 Original Pré_install non faite ****" ""
            ;;
			
        *)
			echo "Oups pas la bonne version de libQt5Core.so.5.6.3" > /dev/kmsg
			ecrit_log "		Oups pas la bonne version"
			ecrit_log "***** libQt5Core.so.5.6.3 Version différente $test****" "`cat /app/share/version-bavn_X52.txt`"
            ;;
esac

# Version
version_system=$(cat /app/share/version-bavn_X52.txt )
ecrit_log "***** Version system : $version_system ****" ""
echo " ***** Version system : : $version_system **** " > /dev/kmsg

FVersion=$(liste=($(ls -t /navi_rw/save/IGO_VERSION_*));echo "$liste")
version_primo=$(cat $FVersion )
echo "***** Version de Primo $version_primo" > /dev/kmsg
#suivi_log "***** Version de Primo $version_primo ***** "
ecrit_log "***** Version de Primo : $version_primo ***** "
case $version_primo in
        "9.12.179.778780")
            echo " version x.0.9.6 " > /dev/kmsg
            ecrit_log "***** pour version x.0.9.6 ****" ""
            ;;

        *)
            echo "Oups pas la bonne version de primo" > /dev/kmsg
            ;;
esac
version_gestnav=$(cat /navi_rw/utility/GestNav4/ZGestNav4_version.txt )
ecrit_log "***** Version gestnav : $version_gestnav ****" ""
echo " ***** Version gestnav : $version_gestnav **** " > /dev/kmsg

ecrit_log_nl "********** occupation disc **********" "`df /navi`"
ecrit_log_nl "********** occupation disc **********" "`df /navi`"
ecrit_log_nl "********** /navi **********" "`ls -la /navi`"
ecrit_log_nl "********** /license **********" "`ls -laR /navi/license`"
#ecrit_log_nl "********** /utility en dur ******" "`ls -laR /navi/utility`"
testdure="/navi/utility/"
	if [ -d "$testdure" ]; then
		echo "installation en dur" > /dev/kmsg

	fi
ecrit_log_nl "********** /ux **********" "`ls -laR /navi/ux`"
ecrit_log_nl "********** /content **********" "`ls -laR /navi/content`"
#ecrit_log_nl "********** /Save **********" "`ls -la /navi_rw`"
ecrit_log_nl "********** /navi_rw **********" "`ls -laR /navi_rw`"
echo "**********************" > /dev/kmsg



ecrit_log_nl "********** dmesg **********" "`dmesg -T | sed s/\xffffff/\x/gI`"

#lancement son fin
if [ $Erreur = "1" ]; then
	sleep 4
	
	if [ -d "$dure" ];then
		if [ $1 = "radio" ]; then
			echo "type = radio en dure" > /dev/kmsg
			echo -en '\xAA\x51\x00\x02\x03\x01\xFB' > /dev/ttymxc1  #radio 2 usb
			/navi_rw/utility/GestNav4/volume.sh
			echo "son = $dure/GestNav4/Ne_Pas_Modifier/son/alerte.wav" 
			/usr/bin/aplay $dure/son/alerte.wav
			sleep 4
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
			ecrit_log "		= > Mémoire pleine ou échec écriture" ""
			/usr/bin/aplay $dure/son/alerte.wav
		fi

	else
		if [ $1 = "radio" ]; then
			echo "type = radio sur clé" > /dev/kmsg
			echo -en '\xAA\x51\x00\x02\x03\x01\xFB' > /dev/ttymxc1  #radio 2 usb
			/navi_rw/utility/GestNav4/volume.sh
			echo "son = $dure/GestNav4/Ne_Pas_Modifier/son/alerte.wav" 
			ecrit_log "		= > Mémoire pleine ou échec écriture" ""
			/usr/bin/aplay $dir/GestNav4/Ne_Pas_Modifier/son/alerte.wav
			sleep 4
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
			
else			
	# lancement du son peuchere.wav
	if [ -d "$dure" ];then
		if [ $1 = "radio" ]; then
			
				echo -en '\xAA\x51\x00\x02\x03\x01\xFB' > /dev/ttymxc1  #radio 2 usb
				/navi_rw/utility/GestNav4/volume.sh
				/usr/bin/aplay $dure/son/peuchere.wav
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
				/usr/bin/aplay $dure/son/peuchere.wav
		fi

	else
			ecrit_log "		= > OK" ""
		if [ $1 = "radio" ]; then
			
				echo -en '\xAA\x51\x00\x02\x03\x01\xFB' > /dev/ttymxc1  #radio 2 usb
				/navi_rw/utility/GestNav4/volume.sh
				/usr/bin/aplay $dir/GestNav4/Ne_Pas_Modifier/son/peuchere.wav
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
				/usr/bin/aplay $dir/GestNav4/Ne_Pas_Modifier/son/peuchere.wav
		fi
	fi
	
fi
mount -o remount,ro $dir
/navi_rw/utility/GestNav4/PopupFin.sh &
/bin/sync
		echo "**********************" > /dev/kmsg


exit 0