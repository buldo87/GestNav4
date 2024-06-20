#!/bin/bash
# GestNav4 Désinstallation ux Day_Night STD
		echo "**********************" > /dev/kmsg
		echo "Supprimer ux Day_Night STD" > /dev/kmsg
source /navi_rw/utility/GestNav4/SuiviLog.sh
source /navi_rw/utility/GestNav4/common.sh
source /navi_rw/utility/GestNav4/Traduction.sh
dure="/navi/utility/GestNav4/Ne_Pas_Modifier"
suivi_log "Supprimer ux Day_Night STD"
# on vérifie que le chemin est valide
f="$dir/GestNav4"

if [ -d "$dir/GestNav4" ] || [ -d "$dure" ];then
/navi_rw/utility/GestNav4/LancementPopup.sh "$Desinstallation_Day_NightStd" &
#lancement son début
	EnvoiSon startup.wav $1 1         #son, type media, durée en seconde
#	sleep 2
	mount -o remount,rw /navi
	mount -o remount,rw $clem
	/bin/sync

		rm -rfv /navi/ux/__Day_Night.zip > /dev/kmsg
		chown 1004:1004 /navi/ux/*
		chmod -R 644 /navi/ux/*
	suivi_log "		= > OK"
	mount -o remount,ro /navi
	mount -o remount,ro $clem

# lancement son fin et fin popup
	EnvoiSon desinstallation.wav $1 2
	/navi_rw/utility/GestNav4/PopupFin.sh &

else
		/navi_rw/utility/GestNav4/LancementPopup.sh "$Absence_cle" &
		sleep 6
		/navi_rw/utility/GestNav4/PopupFin.sh & 
fi
/bin/sync
		echo "**********************" > /dev/kmsg

exit 0