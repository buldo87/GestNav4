#!/bin/bash
# GestNav4 Sauvegarde Navigation dossier /sauvegarde sur clé
		echo "**********************" > /dev/kmsg
		echo "Sauvegarde Navigation" > /dev/kmsg
source /navi_rw/utility/GestNav4/common.sh
source /navi_rw/utility/GestNav4/SuiviLog.sh
source /navi_rw/utility/GestNav4/Traduction.sh
suivi_log "Sauvegarde Navigation"
# on vérifie que le chemin est valide

if [ -d "$cle" ]
then
	/navi_rw/utility/GestNav4/LancementPopup.sh "$Sauvegarde_navi" &
#lancement son début
	EnvoiSon startup.wav $1 1         #son, type media, durée en seconde
	mount -o remount,rw $clem
	/bin/sync
	tdate=$(date +%d_%m_%Y_%H_%M)
	#djeman
	cd /navi && tar cv * | gzip -3 > $dir/GestNav4/sauvegarde_restauration/navi/navi_$tdate.tar.gz
	cd /navi_rw/speedcam && tar cv * | gzip -3 > $dir/GestNav4/sauvegarde_restauration/navi/speedcam_$tdate.tar.gz
	suivi_log "		= > OK"	
	mount -o remount,ro $clem

#lancement son fin et fin popup
	EnvoiSon sauvegarde.wav $1 2
	/navi_rw/utility/GestNav4/PopupFin.sh &

fi
/bin/sync
		echo "**********************" > /dev/kmsg
exit 0