#!/bin/bash
# GestNav4 installation ux Day_Night STD
source /navi_rw/utility/GestNav4/common.sh
source /navi_rw/utility/GestNav4/SuiviLog.sh
source /navi_rw/utility/GestNav4/Traduction.sh
		echo "**********************" > /dev/kmsg
		echo "installation ux Day_Night STD" > /dev/kmsg
		
suivi_log "installation ux Day_Night STD"
file="$dir/GestNav4.txt"
# on vérifie que le chemin est valide
if [ -d "$dir/GestNav4" ];then
	sleep 1
	/navi_rw/utility/GestNav4/LancementPopup.sh "$Installation_Day_NightStd" &
#lancement son début
	EnvoiSon startup.wav $1 1         #son, type media, durée en seconde
	sleep 2
	mount -o remount,rw /navi
	mount -o remount,rw $clem
	/bin/sync

	ecrit_log "GestNav4 installation ux Day_Night STD" " "
# efface les fichier de type .* généré par les mac
#	find "$dir/" -name ".*" -exec rm "{}" \;
#	find "/navi/" -name ".*" -exec rm "{}" \;

#ux Day_Night
	cp -Rva $dir/GestNav4/Ne_Pas_Modifier/ux/original_options/__Day_Night.zip /navi/ux/ > /dev/kmsg

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