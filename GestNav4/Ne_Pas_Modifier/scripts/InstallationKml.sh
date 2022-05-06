#!/bin/bash
# GestNav4 Installation kml /navi

		echo "**********************" > /dev/kmsg
		echo "Installation kml" > /dev/kmsg
source /navi_rw/utility/GestNav4/common.sh
source /navi_rw/utility/GestNav4/SuiviLog.sh
source /navi_rw/utility/GestNav4/Traduction.sh
suivi_log "Installation KML"		
# on vérifie que le chemin est valide
if [ -d "$cle" ]
then
	/navi_rw/utility/GestNav4/LancementPopup.sh "$Installation_kml_perso" &
#lancement son début
	EnvoiSon startup.wav $1 1         #son, type media, durée en seconde
	sleep 2
	mount -o remount,rw /navi
	mount -o remount,rw $clem
	/bin/sync
# efface les fichier de type .* généré par les mac
	find "$dir/" -name ".*" -exec rm "{}" \;
	find "/navi/" -name ".*" -exec rm "{}" \;
#on copie les fichiers des kml pour toutes installs
	cp -Rva $dir/GestNav4/Installation_utilisateur/kml_personnels/userdata/* /navi/content/userdata > /dev/kmsg
	chown 1004:1004 /navi/content/userdata/*
	chmod -R 644 /navi/content/*
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