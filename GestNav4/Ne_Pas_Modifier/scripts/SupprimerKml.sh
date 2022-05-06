#!/bin/bash
# GestNav4 Supprimer kml personnels
		echo "**********************" > /dev/kmsg
		echo "Supprimer kml personnel" > /dev/kmsg
source /navi_rw/utility/GestNav4/SuiviLog.sh
source /navi_rw/utility/GestNav4/common.sh
source /navi_rw/utility/GestNav4/Traduction.sh
suivi_log "Supprimer KML"
# on vérifie que le chemin est valide
f="$dir/GestNav4"

if [ -d "$f" ]
then
/navi_rw/utility/GestNav4/LancementPopup.sh "$Suppression_kml_perso" &
#lancement son début
	EnvoiSon startup.wav $1 1         #son, type media, durée en seconde
	mount -o remount,rw /navi
	mount -o remount,rw $clem
	/bin/sync

	rm -rfv /navi/content/userdata/POI > /dev/kmsg
	rm -rfv /navi/content/userdata/route > /dev/kmsg
	rm -rfv /navi/content/userdata/usericon > /dev/kmsg
	mkdir -p /navi/content/userdata/POI > /dev/kmsg
	cp -Rva $dir/GestNav4/Ne_Pas_Modifier/kml_originaux/POI/* /navi/content/userdata/POI > /dev/kmsg
	chown 1004:1004 /navi/content/uderdata/*
	chmod -R 644 /navi/content/*
suivi_log "		= > OK"
mount -o remount,ro /navi
mount -o remount,ro $clem
/bin/sync

# lancement son fin et fin popup
	EnvoiSon installation.wav $1 2
	/navi_rw/utility/GestNav4/PopupFin.sh &

fi
/bin/sync
		echo "**********************" > /dev/kmsg

exit 0