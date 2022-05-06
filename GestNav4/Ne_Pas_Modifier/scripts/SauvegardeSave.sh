#!/bin/bash
# GestNav4 Sauvegarde du dossier save
source /navi_rw/utility/GestNav4/common.sh
echo "**********************" > /dev/kmsg
echo "Sauvegarde du dossier save" > /dev/kmsg
source /navi_rw/utility/GestNav4/SuiviLog.sh
source /navi_rw/utility/GestNav4/Traduction.sh
suivi_log "Sauvegarde Save"
# on vérifie que le chemin est valide
if [ -d "$cle" ]
then
	/navi_rw/utility/GestNav4/LancementPopup.sh "$Sauvegarde_save" &
#lancement son début
	EnvoiSon startup.wav $1 1         #son, type media, durée en seconde
	mount -o remount,rw $clem
	mount -o remount,rw /navi
	/bin/sync

	ecrit_log "GestNav4 Sauvegarde du dossier save" " "

	tdate=$(date +%d_%m_%Y_%H_%M)
	carbone="/navi/ux/_carbone.zip"
	if [ -f "$carbone" ]
	then
		suivi_log "		= > OK Sauvegarde Save carbone"
		cd /navi_rw/carbone/save && tar zcvf $dir/GestNav4/sauvegarde_restauration/save_carbone/save_carbone_$tdate.tar.gz * > /dev/kmsg
	else
		suivi_log "		= > OK Sauvegarde Save"
		cd /navi_rw/save && tar zcvf $dir/GestNav4/sauvegarde_restauration/save/save_$tdate.tar.gz * > /dev/kmsg
	fi

	mount -o remount,ro $clem
	/bin/sync

#lancement son fin et fin popup
	EnvoiSon sauvegarde.wav $1 2
	/navi_rw/utility/GestNav4/PopupFin.sh &

else
  ecrit_log "autorun.sh introuvable, le chemin est invalide ! " "on sort !" 
  exit 0
fi
/bin/sync
		echo "**********************" > /dev/kmsg

exit 0
