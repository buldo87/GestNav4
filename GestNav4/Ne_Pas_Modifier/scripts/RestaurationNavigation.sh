#!/bin/bash
# GestNav4 Restauration Navigation du dossier /sauvegarde_restauration sur clé
echo "**********************" > /dev/kmsg
echo "Restauration Navigation" > /dev/kmsg
source /navi_rw/utility/GestNav4/common.sh
source /navi_rw/utility/GestNav4/SuiviLog.sh
source /navi_rw/utility/GestNav4/Traduction.sh
suivi_log "*******************"
suivi_log "Restauration navigation"
# on vérifie que le chemin est valide
if [ -d "$cle" ]
then
	/navi_rw/utility/GestNav4/LancementPopup.sh "$Restauration_navi" &
#lancement son début
	EnvoiSon startup.wav $1 1         #son, type media, durée en seconde
	mount -o remount,rw /navi
	mount -o remount,rw $clem
	/bin/sync
# efface les fichier de type .* généré par les mac
	find "$dir/" -name ".*" -exec rm "{}" \;
	find "/navi/" -name ".*" -exec rm "{}" \;
	CHEMIN_DOSSIER_SAVE_SPEEDCAM=$dir/GestNav4/sauvegarde_restauration/navi/speedcam*
	CHEMIN_FICHIER_BACKUP_SPEEDCAMS=0
	CHEMIN_DOSSIER_SAVE=$dir/GestNav4/sauvegarde_restauration/navi/navi*
	CHEMIN_FICHIER_BACKUP=0

	for file2 in $(ls -U $CHEMIN_DOSSIER_SAVE | sort -r -n -t _ -k 6 | sort -r -n -t _ -k 5 | sort -r -n -t _ -k 2 | sort -r -n -t _ -k 3 | sort -r -n -t _ -k 4)
	do
		CHEMIN_FICHIER_BACKUP=$file2
		echo "Dernière sauvegarde : $CHEMIN_FICHIER_BACKUP" > /dev/kmsg
		break
	done
	for file3 in $(ls -U $CHEMIN_DOSSIER_SAVE_SPEEDCAM | sort -r -n -t _ -k 6 | sort -r -n -t _ -k 5 | sort -r -n -t _ -k 2 | sort -r -n -t _ -k 3 | sort -r -n -t _ -k 4)
	do
		CHEMIN_FICHIER_BACKUP_SPEEDCAMS=$file3
		echo "Dernière sauvegarde speedcams : $CHEMIN_FICHIER_BACKUP" > /dev/kmsg
		break
	done
	if [ ! $CHEMIN_FICHIER_BACKUP = 0 ]
	then
		killall nngnavi
		echo "Restauration Sauvegarde : $CHEMIN_FICHIER_BACKUP" > /dev/kmsg
		rm -r /navi/*
		rm -r /navi_rw/save/*
		rm -r /navi_rw/speedcam/*
		ln -s /navi_rw/speedcam /navi/content/speedcam
		ln -s /navi_rw/save /navi/save
		tar zxvf $CHEMIN_FICHIER_BACKUP -C /navi > /dev/kmsg
		tar zxvf $CHEMIN_FICHIER_BACKUP_SPEEDCAMS -C /navi_rw/speedcam > /dev/kmsg
		chown 1004:1004 /navi/*
		chown 1004:1004 /navi_rw/speedcam/*
		mount -o remount,ro /navi
		mount -o remount,ro $clem
		#lancement son fin et fin popup
		EnvoiSon restauration.wav $1 2
		/navi_rw/utility/GestNav4/PopupFin.sh &
		echo "**********************" > /dev/kmsg
		/bin/sync
		suivi_log "		= > OK"	
		/sbin/reboot -f
	else 
		echo "oups pas de sauvegarde" > /dev/kmsg
		suivi_log "		= > pas de sauvegarde"			
	fi

	mount -o remount,ro /navi
	mount -o remount,ro $clem
	suivi_log "`df /navi`"
	suivi_log "*******************"

else
	/navi_rw/utility/GestNav4/LancementPopup.sh "$Map_changer_pas_de_cle" &
	sleep 6
	/navi_rw/utility/GestNav4/PopupFin.sh &
fi
/bin/sync
echo "**********************" > /dev/kmsg
exit 0