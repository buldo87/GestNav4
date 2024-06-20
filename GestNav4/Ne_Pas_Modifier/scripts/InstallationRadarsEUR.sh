#!/bin/bash
# GestNav4 installation Radars EUR+
source /navi_rw/utility/GestNav4/common.sh
		echo "**********************" > /dev/kmsg
		echo "installation Radars EUR+" > /dev/kmsg
source /navi_rw/utility/GestNav4/SuiviLog.sh
source /navi_rw/utility/GestNav4/Traduction.sh
suivi_log "installation Radars EUR+"
# on vérifie que le chemin est valide
if [ -d "$cle" ]
then
/navi_rw/utility/GestNav4/LancementPopup.sh "$Installation_RadarsEur" &
#lancement son début
	EnvoiSon startup.wav $1 1         #son, type media, durée en seconde
	mount -o remount,rw /navi
	mount -o remount,rw $clem
	/bin/sync
	ecrit_log "GestNav4 installation radars EUR+" " "
# efface les fichier de type .* généré par les mac
	find "$dir/" -name ".*" -exec rm "{}" \;
	find "/navi/" -name ".*" -exec rm "{}" \;
#radar
	mv -v /navi_rw/speedcam/*.spc /navi_rw/spc
	mv -v /navi_rw/speedcam/*.md5 /navi_rw/spc
	rm -rfv /navi_rw/speedcam/*.txt > /dev/kmsg
	rm -rfv /navi_rw/speedcam/*.spdb > /dev/kmsg
	cp -Rva $dir/GestNav4/Installation_utilisateur/radars/radars_eur/*.txt /navi_rw/speedcam/ > /dev/kmsg
#
	chown -Rv 1004:1004 /navi/*
	chown -Rv 1004:1004 /navi_rw/*
	chmod -R 644 /navi/content/*
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