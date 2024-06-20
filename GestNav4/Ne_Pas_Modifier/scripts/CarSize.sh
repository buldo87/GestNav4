#!/bin/bash
#  GestNav4 installation/desinstallation ux CarSize
echo "********** ux CarSize $1 avec $2 *************" > /dev/kmsg
source /navi_rw/utility/GestNav4/SuiviLog.sh
source /navi_rw/utility/GestNav4/common.sh
source /navi_rw/utility/GestNav4/Traduction.sh
dure="/navi/utility/GestNav4/Ne_Pas_Modifier"
suivi_log "installation/desinstallation ux CarSize $1 avec $2 "

if [ -d "$dir/GestNav4" ] || [ -d "$dure" ];then
	mount -o remount,rw /navi
	mount -o remount,rw $clem
	/bin/sync
    case $1 in
        "installation")
			/navi_rw/utility/GestNav4/LancementPopup.sh "$Installation_CarSize" &
		#lancement son début
			EnvoiSon startup.wav $2 1		#son, type media, durée en seconde
			cp -Rva $dir/GestNav4/Ne_Pas_Modifier/ux/ux_carsize_cacou.zip /navi/ux/ > /dev/kmsg
			suivi_log "		= > Installation OK"	
            ;;
        "desinstallation")
			/navi_rw/utility/GestNav4/LancementPopup.sh "$Desinstallation_CarSize" &
		#lancement son début				#son, type media, durée en seconde
			EnvoiSon startup.wav $2 1
			rm -rfv /navi/ux/ux_carsize_cacou.zip > /dev/kmsg
			suivi_log "		= > desinstallation OK"
            ;;
        *)
            echo "Oups argument 1 $1" > /dev/kmsg
            ;;
    esac
    mount -o remount,ro $clem
    mount -o remount,ro /app
#lancement son fin et fin popup
    EnvoiSon installation.wav $2 2  
	/navi_rw/utility/GestNav4/PopupFin.sh &	
fi

else
		/navi_rw/utility/GestNav4/LancementPopup.sh "$Absence_cle" &
		sleep 6
		/navi_rw/utility/GestNav4/PopupFin.sh & 
fi 
/bin/sync

