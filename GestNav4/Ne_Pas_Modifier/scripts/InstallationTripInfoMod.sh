#!/bin/bash
# GestNav4 installation ux trip_info Mod
source /navi_rw/utility/GestNav4/common.sh
source /navi_rw/utility/GestNav4/SuiviLog.sh
source /navi_rw/utility/GestNav4/Traduction.sh
		echo "**********************" > /dev/kmsg
		echo "installation ux trip_info Mod" > /dev/kmsg
		
suivi_log "Installation ux trip_info Mod"
file="$dir/GestNav4.txt"
# on vérifie que le chemin est valide
if [ -d "$dir/GestNav4" ];then
	sleep 1
	/navi_rw/utility/GestNav4/LancementPopup.sh "$Installation_TripInfoMod" &
#lancement son début
	EnvoiSon startup.wav $1 1         #son, type media, durée en seconde
	sleep 2
	mount -o remount,rw /navi
	mount -o remount,rw $clem
	/bin/sync
	ecrit_log "GestNav4 installation ux trip_info Mod" " "
# efface les fichier de type .* généré par les mac
#	find "$dir/" -name ".*" -exec rm "{}" \;
#	find "/navi/" -name ".*" -exec rm "{}" \;

#ux trip_info
	cp -Rva $dir/GestNav4/Ne_Pas_Modifier/ux/mod_options/__tripinfo.zip /navi/ux/ > /dev/kmsg
	chown -Rv 1004:1004 /navi/*
	suivi_log "		= > OK"
	mount -o remount,ro /navi
	mount -o remount,ro $clem
#lancement son fin et fin popup
	EnvoiSon installation.wav $1 2
	/navi_rw/utility/GestNav4/PopupFin.sh &

fi
/bin/sync
		echo "**********************" > /dev/kmsg
exit 0