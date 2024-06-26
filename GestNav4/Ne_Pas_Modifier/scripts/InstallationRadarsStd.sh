﻿#!/bin/bash
# GestNav4 installation Radars STD
source /navi_rw/utility/GestNav4/common.sh
		echo "**********************" > /dev/kmsg
		echo "installation Radars STD" > /dev/kmsg
source /navi_rw/utility/GestNav4/SuiviLog.sh
source /navi_rw/utility/GestNav4/Traduction.sh
suivi_log "installation Radars STD"
file="$dir/GestNav4.txt"
# on vérifie que le chemin est valide
if [ -d "$cle" ]
then
/navi_rw/utility/GestNav4/LancementPopup.sh "$Installation_RadarsStd" &
#lancement son début
	EnvoiSon startup.wav $1 1         #son, type media, durée en seconde
	mount -o remount,rw /navi
	mount -o remount,rw $clem
	/bin/sync
	ecrit_log "GestNav4 installation radars STD" " "
# efface les fichier de type .* généré par les mac
	find "$dir/" -name ".*" -exec rm "{}" \;
	find "/navi/" -name ".*" -exec rm "{}" \;
#radar
	rm -rfv /navi_rw/speedcam/* > /dev/kmsg
	rm -rfv /navi_rw/spc/* > /dev/kmsg
	cp -Rva $dir/GestNav4/Installation_utilisateur/radars/radars_std/*.txt /navi_rw/speedcam/ > /dev/kmsg
	cp -Rva $dir/GestNav4/Installation_utilisateur/radars/radars_std/*.spc /navi_rw/speedcam/ > /dev/kmsg
	cp -Rva $dir/GestNav4/Installation_utilisateur/radars/radars_std/*.spc /navi_rw/spc/ > /dev/kmsg
#copie le sys.txt modifié
	cp -Rva $dir/GestNav4/Ne_Pas_Modifier/radars_std/sys.txt /navi/ > /dev/kmsg
	cp -Rva $dir/GestNav4/Ne_Pas_Modifier/radars_std/radars_std.ini /navi/ > /dev/kmsg
	ls  -la /navi_rw/speedcam > /dev/kmsg
	chown -Rv 1004:1004 /navi/*
	chown -Rv 1004:1004 /navi_rw/*
	chmod -R 644 /navi/content/*
	chmod -R 644 /navi/sys.txt
	suivi_log "		= > OK"	
	mount -o remount,ro /navi
	mount -o remount,ro $clem
#lancement son fin et fin popup
	EnvoiSon installation.wav $1 2
	/navi_rw/utility/GestNav4/PopupFin.sh &

else
	/navi_rw/utility/GestNav4/LancementPopup.sh "$Map_changer_pas_de_cle" &
	sleep 6
	/navi_rw/utility/GestNav4/PopupFin.sh &
fi
/bin/sync
		echo "**********************" > /dev/kmsg
exit 0