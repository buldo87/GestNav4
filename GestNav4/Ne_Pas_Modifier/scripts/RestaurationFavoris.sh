#!/bin/bash
# GestNav4 Restauration des favoris
echo "**********************" > /dev/kmsg
echo "Restauration des favoris" > /dev/kmsg
source /navi_rw/utility/GestNav4/common.sh
source /navi_rw/utility/GestNav4/SuiviLog.sh
source /navi_rw/utility/GestNav4/Traduction.sh
suivi_log "Restauration favoris"
# on vérifie que le chemin est valide

if [ -d "$cle" ]
then
	/navi_rw/utility/GestNav4/LancementPopup.sh "$Restauration_favoris" &
#lancement son début
	EnvoiSon startup.wav $1 1         #son, type media, durée en seconde
	mount -o remount,rw /navi
	mount -o remount,rw $clem
	/bin/sync
	CHEMIN_DOSSIER_SAVE=$dir/GestNav4/sauvegarde_restauration/favoris/favoris*
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
		carbone="/navi/ux/_carbone.zip"
		if [ -f "$carbone" ]
		then
			tar zxvf $CHEMIN_FICHIER_BACKUP -C /navi_rw/carbone/save > /dev/kmsg
		else
			tar zxvf $CHEMIN_FICHIER_BACKUP -C /navi_rw/save > /dev/kmsg			
		fi
	else
		echo "oups pas de sauvegarde" > /dev/kmsg
	fi
	cp -Rva $dir/GestNav4/sauvegarde_restauration/favoris/ux/pack_pois_GestNav4.zip /navi/ux > /dev/kmsg	
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