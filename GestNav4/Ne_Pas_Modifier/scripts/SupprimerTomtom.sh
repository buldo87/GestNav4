#!/bin/bash
# GestNav4 supprimer fichiers et répertoires cartographie tomtom
		echo "**********************" > /dev/kmsg
		echo "Supprimer dossiers et fichiers tomtom" > /dev/kmsg
source /navi_rw/utility/GestNav4/SuiviLog.sh		
source /navi_rw/utility/GestNav4/common.sh
source /navi_rw/utility/GestNav4/Traduction.sh
suivi_log "Supprimer Tomtom"
# on vérifie que le chemin est valide
f="$dir/GestNav4"

if [ -d "$f" ]
then
/navi_rw/utility/GestNav4/LancementPopup.sh "$Suppression_cartographie_tomtom" &
#lancement son début
EnvoiSon startup.wav $1 1         #son, type=$1, durée en seconde
	sleep 2
mount -o remount,rw /navi
mount -o remount,rw $clem
/bin/sync

ecrit_log "GestNav4 dossiers et fichiers tomtom" " "

		rm -rfv /navi/content/building_tomtom > /dev/kmsg
		rm -rfv /navi/content/map_tomtom > /dev/kmsg
		rm -rfv /navi/content/poi_tomtom > /dev/kmsg
		mkdir -p /navi/content/map_tomtom > /dev/kmsg
		mkdir -p /navi/content/building_tomtom > /dev/kmsg
		mkdir -p /navi/content/poi_tomtom > /dev/kmsg
suivi_log "		= > OK"		
mount -o remount,ro /navi
mount -o remount,ro $clem

# lancement son fin et fin popup
	EnvoiSon desinstallation.wav $1 2
	/navi_rw/utility/GestNav4/PopupFin.sh &

else
	/navi_rw/utility/GestNav4/LancementPopup.sh "$Map_changer_pas_de_cle" &
	sleep 6
	/navi_rw/utility/GestNav4/PopupFin.sh &
fi
/bin/sync
		echo "**********************" > /dev/kmsg

exit 0
