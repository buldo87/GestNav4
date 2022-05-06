#!/bin/bash
# Rest-Navi
dir2=`tail -n 1 /etc/mtab`
dir=${dir2:10:20}
clem=$dir
echo "**********************" > /dev/kmsg
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
	CHEMIN_FICHIER_BACKUP=$clem/backup_navi.tar.gz

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
fi
suivi_log "`df /navi`"
suivi_log "*******************"
/bin/sync
echo "**********************" > /dev/kmsg
exit 0