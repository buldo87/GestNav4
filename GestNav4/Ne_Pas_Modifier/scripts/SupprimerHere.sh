#!/bin/bash
# GestNav4 supprimer fichiers et répertoires cartographie Here
		echo "**********************" > /dev/kmsg
		echo "Supprimer dossiers et fichiers Here" > /dev/kmsg
source /navi_rw/utility/GestNav4/common.sh
source /navi_rw/utility/GestNav4/SuiviLog.sh
source /navi_rw/utility/GestNav4/Traduction.sh

suivi_log "Supprimer Here"
# on vérifie que le chemin est valide
f="$dir/GestNav4"

if [ -d "$f" ]
then
/navi_rw/utility/GestNav4/LancementPopup.sh "$Suppression_cartographie_here" &
#lancement son début
	EnvoiSon startup.wav $1 1         #son, type media, durée en seconde
	mount -o remount,rw /navi
	mount -o remount,rw $clem
	/bin/sync

	rm -rfv /navi/content/building > /dev/kmsg
	rm -rfv /navi/content/map > /dev/kmsg
	rm -rfv /navi/content/poi > /dev/kmsg
	mkdir -p /navi/content/map > /dev/kmsg
	mkdir -p /navi/content/building > /dev/kmsg
	mkdir -p /navi/content/poi > /dev/kmsg
	cp -Rva $dir/GestNav4/Ne_Pas_Modifier/basemap/* /navi/content/map> /dev/kmsg
	suivi_log "		= > OK"		
	mount -o remount,ro /navi
	mount -o remount,ro $clem
# lancement son fin et fin popup
	EnvoiSon installation.wav $1 2
	/navi_rw/utility/GestNav4/PopupFin.sh &
fi
/bin/sync
		echo "**********************" > /dev/kmsg

exit 0
