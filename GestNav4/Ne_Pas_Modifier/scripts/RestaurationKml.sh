#!/bin/bash
# GestNav4 Restauration des kml
echo "**********************" > /dev/kmsg
echo "Restauration des kml" > /dev/kmsg
source /navi_rw/utility/GestNav4/common.sh
source /navi_rw/utility/GestNav4/SuiviLog.sh
source /navi_rw/utility/GestNav4/Traduction.sh
suivi_log "Restauration KML"
# on vérifie que le chemin est valide
if [ -d "$cle" ]
then
	/navi_rw/utility/GestNav4/LancementPopup.sh "$Restauration_kml_perso" &
#lancement son début
	EnvoiSon startup.wav $1 1         #son, type media, durée en seconde
	mount -o remount,rw /navi
	mount -o remount,rw $clem
	/bin/sync
	CHEMIN_DOSSIER_SAVE=$dir/GestNav4/sauvegarde_restauration/kml_personnels/kml*
	CHEMIN_FICHIER_BACKUP=0

	for file2 in $(ls -U $CHEMIN_DOSSIER_SAVE | sort -r -n -t _ -k 6 | sort -r -n -t _ -k 5 | sort -r -n -t _ -k 2 | sort -r -n -t _ -k 3 | sort -r -n -t _ -k 4)
	do
		CHEMIN_FICHIER_BACKUP=$file2
		echo "Dernière sauvegarde : $CHEMIN_FICHIER_BACKUP" > /dev/kmsg
		break
	done

	if [ ! $CHEMIN_FICHIER_BACKUP = 0 ]
	then
		killall nngnavi
		echo "Restauration Sauvegarde : $CHEMIN_FICHIER_BACKUP" > /dev/kmsg
		rm -r /navi/content/userdata/*
		mkdir -p /navi/content/userdata > /dev/kmsg
		tar zxvf $CHEMIN_FICHIER_BACKUP -C /navi/content/userdata > /dev/kmsg

		chown 1004:1004 /navi/content/userdata/*
		mount -o remount,ro /navi
		mount -o remount,ro $clem
		echo "**********************" > /dev/kmsg
		/bin/sync
	else 
		echo "oups pas de sauvegarde" > /dev/kmsg
	fi
	suivi_log "		= > OK"	
	mount -o remount,ro /navi
	mount -o remount,ro $clem			
#lancement son fin et fin popup
	EnvoiSon restauration.wav $1 2
	/navi_rw/utility/GestNav4/PopupFin.sh &

fi

/bin/sync
echo "**********************" > /dev/kmsg
exit 0