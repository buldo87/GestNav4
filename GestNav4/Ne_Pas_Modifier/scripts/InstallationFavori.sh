#!/bin/bash
# GestNav4 Installation Favoris /navi
source /navi_rw/utility/GestNav4/common.sh
source /navi_rw/utility/GestNav4/SuiviLog.sh
source /navi_rw/utility/GestNav4/Traduction.sh
echo "**********************" > /dev/kmsg
echo "Installation Favoris" > /dev/kmsg
source /navi_rw/utility/GestNav4/SuiviLog.sh		
suivi_log "Installation Favoris"

if [ -d "$cle" ]
then
	/navi_rw/utility/GestNav4/LancementPopup.sh "$Installation_favoris" &
#lancement son début
	EnvoiSon startup.wav $1 1         #son, type media, durée en seconde
	sleep 2
	mount -o remount,rw /navi
	mount -o remount,rw $clem
	/bin/sync

	ecrit_log "GestNav4 Installation Favoris" " "
# efface les fichier de type .* généré par les mac
	find "$dir/" -name ".*" -exec rm "{}" \;
	find "/navi/" -name ".*" -exec rm "{}" \;
#on copie les fichiers des favoris pour toutes installs
	cp -Rva $dir/GestNav4/Installation_utilisateur/favoris/nng_rw/* /navi_rw > /dev/kmsg
	cp -Rva $dir/GestNav4/Installation_utilisateur/favoris/nng_rw/* /navi_rw/carbone > /dev/kmsg
	cp -Rva $dir/GestNav4/Installation_utilisateur/favoris/nng/* /navi > /dev/kmsg
	chown -Rfv 1004:1004 /navi_rw/*
	chown -Rfv 1004:1004 /navi/*
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