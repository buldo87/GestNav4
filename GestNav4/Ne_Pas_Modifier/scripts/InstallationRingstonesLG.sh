#!/bin/bash
# changer la sonnerie des appels téléphoniques bell.wav
echo "********** Installation sonnerie appels téléphoniques $1 avec $2 *************" > /dev/kmsg
source /navi_rw/utility/GestNav4/SuiviLog.sh
source /navi_rw/utility/GestNav4/common.sh
source /navi_rw/utility/GestNav4/Traduction.sh
suivi_log "Installation sonnerie appels téléphoniques $1 avec $2"

if [ -d "$dir/GestNav4" ];then
	color=$(/sbin/misc_getprop colouring | cut -c11-)
	if [ $color = "1" ]; then
		mount -o remount,rw $clem
		mount -o remount,rw /app
		/bin/sync
	
		case $1 in
			"Favori1")
				/navi_rw/utility/GestNav4/LancementPopup.sh "$Installation_RingtonesLG" &
			#lancement son début
				EnvoiSon startup.wav $2 1		#son, type media, durée en seconde
            cp -Rva $clem/GestNav4/Installation_utilisateur/RingtonesLG/Favori1/* /app/share/vbtd/ > /dev/kmsg
            ;;
			"Favori2")
					/navi_rw/utility/GestNav4/LancementPopup.sh "$Installation_RingtonesLG" &
			#lancement son début
				EnvoiSon startup.wav $2 1		#son, type media, durée en seconde
            cp -Rva $clem/GestNav4/Installation_utilisateur/RingtonesLG/Favori2/* /app/share/vbtd/ > /dev/kmsg
            ;;
			"Favori3")
					/navi_rw/utility/GestNav4/LancementPopup.sh "$Installation_RingtonesLG" &
			#lancement son début
				EnvoiSon startup.wav $2 1		#son, type media, durée en seconde
            cp -Rva $clem/GestNav4/Installation_utilisateur/RingtonesLG/Favori3/* /app/share/vbtd/ > /dev/kmsg
            ;;
			"Original")
				/navi_rw/utility/GestNav4/LancementPopup.sh "$Installation_RingtonesLG_original" &
			#lancement son début
				EnvoiSon startup.wav $2 1		#son, type media, durée en seconde
            cp -Rva $clem/GestNav4/Installation_utilisateur/RingtonesLG/Original/* /app/share/vbtd/ > /dev/kmsg
            ;;

			*)
            echo "Oups argument 1 $1" > /dev/kmsg
            ;;
		esac
		mount -o remount,ro $clem
		mount -o remount,ro /app
		suivi_log "		= > OK"
		# lancement son fin et fin popup
		EnvoiSon installation.wav $2 2  
		/navi_rw/utility/GestNav4/PopupFin.sh &
		/bin/sync
	fi
fi
