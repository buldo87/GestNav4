#!/bin/bash
#  GestNav4 installation ux Acces Map
echo "********** ux Acces Map $1 avec $2 *************" > /dev/kmsg
source /navi_rw/utility/GestNav4/SuiviLog.sh
source /navi_rw/utility/GestNav4/common.sh
source /navi_rw/utility/GestNav4/Traduction.sh
suivi_log "Installation ux Acces Map $1 avec $2 "

if [ -d "$dir/GestNav4" ];then
	mount -o remount,rw /navi
	mount -o remount,rw $clem
	/bin/sync
    case $1 in
        "installation")
			/navi_rw/utility/GestNav4/LancementPopup.sh "$Acces_Map_ON" &
			#lancement son début
			EnvoiSon startup.wav $2 1		#son, type media, durée en seconde
			cp -Rva $dir/GestNav4/Ne_Pas_Modifier/ux/__ZMapEco.zip /navi/ux/ > /dev/kmsg
            ;;
        "desinstallation")
			/navi_rw/utility/GestNav4/LancementPopup.sh "$Acces_Map_OFF" &
			#lancement son début
			EnvoiSon startup.wav $2 1		#son, type media, durée en seconde
			rm -rfv /navi/ux/__ZMapEco.zip > /dev/kmsg
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
fi