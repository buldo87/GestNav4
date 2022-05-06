#!/bin/bash
# changer l'image du radar de collision ada_car.png
echo "********** Installation image du radar de collision $1 avec $2 *************" > /dev/kmsg
source /navi_rw/utility/GestNav4/SuiviLog.sh
source /navi_rw/utility/GestNav4/common.sh
source /navi_rw/utility/GestNav4/Traduction.sh
suivi_log "Installation image du radar de collision $1 avec $2"

if [ -d "$dir/GestNav4" ];then
	color=$(/sbin/misc_getprop colouring | cut -c11-)
	if [ $color = "1" ]; then

		mount -o remount,rw $clem
		mount -o remount,rw /app
		/bin/sync

		killall AppCamera
	
		case $1 in
			"Favori1")
				/navi_rw/utility/GestNav4/LancementPopup.sh "$Installation_AdacLG" &
			#lancement son début
				EnvoiSon startup.wav $2 1		#son, type media, durée en seconde
				find "$dir/" -name ".*" -exec rm "{}" \;
				find "/navi/" -name ".*" -exec rm "{}" \;
				cp -Rva $clem/GestNav4/Installation_utilisateur/AdacLG/Favori1/* /app/share/com.lge.bavn.appcamera/img/M1/ > /dev/kmsg
            ;;
			"Favori2")
				/navi_rw/utility/GestNav4/LancementPopup.sh "$Installation_AdacLG" &
			#lancement son début
				EnvoiSon startup.wav $2 1		#son, type media, durée en seconde
				find "$dir/" -name ".*" -exec rm "{}" \;
				find "/navi/" -name ".*" -exec rm "{}" \;	
				cp -Rva $clem/GestNav4/Installation_utilisateur/AdacLG/Favori2/* /app/share/com.lge.bavn.appcamera/img/M1/ > /dev/kmsg
            ;;
			"Favori3")
				/navi_rw/utility/GestNav4/LancementPopup.sh "$Installation_AdacLG" &
			#lancement son début
				EnvoiSon startup.wav $2 1		#son, type media, durée en seconde
				find "$dir/" -name ".*" -exec rm "{}" \;
				find "/navi/" -name ".*" -exec rm "{}" \;
				cp -Rva $clem/GestNav4/Installation_utilisateur/AdacLG/Favori3/* /app/share/com.lge.bavn.appcamera/img/M1/ > /dev/kmsg
            ;;
			"Favori4")
				/navi_rw/utility/GestNav4/LancementPopup.sh "$Installation_AdacLG" &
			#lancement son début
				EnvoiSon startup.wav $2 1		#son, type media, durée en seconde
				find "$dir/" -name ".*" -exec rm "{}" \;
				find "/navi/" -name ".*" -exec rm "{}" \;
				cp -Rva $clem/GestNav4/Installation_utilisateur/AdacLG/Favori4/* /app/share/com.lge.bavn.appcamera/img/M1/ > /dev/kmsg
            ;;

			*)
            echo "Oups argument 1 $1" > /dev/kmsg
            ;;
		esac
		suivi_log "		= > OK"
		mount -o remount,ro $clem	
		mount -o remount,ro /app
		# lancement son fin et fin popup
		EnvoiSon installation.wav $2 2  
		/navi_rw/utility/GestNav4/PopupFin.sh &
		/bin/sync
	fi
fi
