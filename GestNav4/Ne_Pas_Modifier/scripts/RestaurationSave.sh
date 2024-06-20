#!/bin/bash
# GestNav4 Restauration du dossier /save
echo "**********************" > /dev/kmsg
echo "Restauration du dossier /save" > /dev/kmsg
source /navi_rw/utility/GestNav4/SuiviLog.sh
source /navi_rw/utility/GestNav4/common.sh
source /navi_rw/utility/GestNav4/Traduction.sh
suivi_log "Restauration save"
# on vérifie que le chemin est valide
if [ -d "$cle" ]
then
	/navi_rw/utility/GestNav4/LancementPopup.sh "$Restauration_save" &
#lancement son début
	EnvoiSon startup.wav $1 1         #son, type media, durée en seconde
	mount -o remount,rw /navi
	mount -o remount,rw $clem
	/bin/sync
	CHEMIN_FICHIER_BACKUP=0
	carbone="/navi/ux/_carbone.zip"
	if [ -f "$carbone" ]
	then
		CHEMIN_DOSSIER_SAVE=$dir/GestNav4/sauvegarde_restauration/save_carbone/save*
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
			rm -rf /navi_rw/carbone/save/*
			tar zxvf $CHEMIN_FICHIER_BACKUP -C /navi_rw/carbone/save > /dev/kmsg
			chown 1004:1004 /navi_rw/*
			suivi_log "		= > OK carbone"	
			mount -o remount,ro /navi
			mount -o remount,ro $clem
			#lancement son fin et fin popup
			EnvoiSon restauration.wav $1 2
			/navi_rw/utility/GestNav4/PopupFin.sh &
		else 
			echo "oups pas de sauvegarde" > /dev/kmsg
		fi	

	else
		CHEMIN_DOSSIER_SAVE=$dir/GestNav4/sauvegarde_restauration/save/save*

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
			rm -rf /navi_rw/save/*
			tar zxvf $CHEMIN_FICHIER_BACKUP -C /navi_rw/save > /dev/kmsg
			chown 1004:1004 /navi_rw/*
			suivi_log "		= > OK standard"	
			mount -o remount,ro /navi
			mount -o remount,ro $clem
			/bin/sync
			#lancement son fin et fin popup
			EnvoiSon restauration.wav $1 2
			/navi_rw/utility/GestNav4/PopupFin.sh &
			
	
	/sbin/reboot -f
		else 
			echo "oups pas de sauvegarde" > /dev/kmsg
			suivi_log "		= > Pas de sauvegarde"	
		fi		
	fi
			mount -o remount,ro /navi
			mount -o remount,ro $clem
			/bin/sync
else
	/navi_rw/utility/GestNav4/LancementPopup.sh "$Map_changer_pas_de_cle" &
	sleep 6
	/navi_rw/utility/GestNav4/PopupFin.sh &
fi
/bin/sync
		echo "**********************" > /dev/kmsg
exit 0