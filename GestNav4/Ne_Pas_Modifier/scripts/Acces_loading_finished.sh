#!/bin/bash
#  GestNav4 choix du démarrage du medianav par défaut
echo "********** Start on the Map $1 avec $2 *************" > /dev/kmsg
source /navi_rw/utility/GestNav4/SuiviLog.sh
source /navi_rw/utility/GestNav4/common.sh
source /navi_rw/utility/GestNav4/Traduction.sh
dure="/navi/utility/GestNav4/Ne_Pas_Modifier"
suivi_log "Choix demarrage Medianav $1 avec $2 "

if [ -d "$dir/GestNav4" ] || [ -d "$dure" ];then
	mount -o remount,rw /navi
	mount -o remount,rw $clem
	/bin/sync
    case $1 in
        "map")
			/navi_rw/utility/GestNav4/LancementPopup.sh "$Start_on_the_Map_ON" &
			#lancement son début
			EnvoiSon startup.wav $2 1		#son, type media, durée en seconde
			cp -Rva $dir/GestNav4/Ne_Pas_Modifier/loading_finished/loading_finished.sh /navi_rw/utility/GestNav4/ > /dev/kmsg
            ;;
		
		"media")
			/navi_rw/utility/GestNav4/LancementPopup.sh "$Start_on_Media_ON" &
			#lancement son début
			EnvoiSon startup.wav $2 1		#son, type media, durée en seconde
			cp -Rva $dir/GestNav4/Ne_Pas_Modifier/loading_finished/loading_finished_media.sh /navi_rw/utility/GestNav4/loading_finished.sh > /dev/kmsg
            ;;		
			
		"radio")
			/navi_rw/utility/GestNav4/LancementPopup.sh "$Start_on_Radio_ON" &
			#lancement son début
			EnvoiSon startup.wav $2 1		#son, type media, durée en seconde
			cp -Rva $dir/GestNav4/Ne_Pas_Modifier/loading_finished/loading_finished_radio.sh /navi_rw/utility/GestNav4/loading_finished.sh > /dev/kmsg
            ;;	
			
        "defaut")
			/navi_rw/utility/GestNav4/LancementPopup.sh "$Start_on_defaut" &
			#lancement son début
			EnvoiSon startup.wav $2 1		#son, type media, durée en seconde
			rm -fv /navi_rw/utility/GestNav4/loading_finished.sh > /dev/kmsg
            ;;

        *)
            echo "Oups argument 1 $1" > /dev/kmsg
            ;;
    esac
    suivi_log "		= > OK"		
	mount -o remount,ro /navi
	mount -o remount,ro $clem
	# lancement son fin et fin popup
	EnvoiSon installation.wav $2 2
	/navi_rw/utility/GestNav4/PopupFin.sh &
	
/bin/sync
/sbin/reboot -f

else
		/navi_rw/utility/GestNav4/LancementPopup.sh "$Absence_cle" &
		sleep 6
		/navi_rw/utility/GestNav4/PopupFin.sh & 
fi
