#!/bin/bash
# GestNav4 Supprimer dossier /save
		echo "**********************" > /dev/kmsg
		echo "Supprimer dossier /save" > /dev/kmsg
source /navi_rw/utility/GestNav4/common.sh
source /navi_rw/utility/GestNav4/SuiviLog.sh
source /navi_rw/utility/GestNav4/Traduction.sh
suivi_log "Supprimer Save"
# on vérifie que le chemin est valide
f="$dir/GestNav4"

if [ -d "$f" ]
then
/navi_rw/utility/GestNav4/LancementPopup.sh "$Suppression_save" &
#lancement son début
	EnvoiSon startup.wav $1 1         #son, type media, durée en seconde
	mount -o remount,rw /navi
	mount -o remount,rw $clem
	/bin/sync

carbone="/navi/ux/_carbone.zip"
	if [ -f "$carbone" ]
	then
		suivi_log "Supprimer Save carbone"
		rm -rfv /navi_rw/carbone/save/* > /dev/kmsg
	else
		suivi_log "Supprimer Save"
		rm -rfv /navi_rw/save/* > /dev/kmsg
	fi
suivi_log "		= > OK"
mount -o remount,ro /navi
mount -o remount,ro $clem
/bin/sync

# lancement son fin et fin popup
	EnvoiSon desinstallation.wav $1 2
	/navi_rw/utility/GestNav4/PopupFin.sh &

else
	/navi_rw/utility/GestNav4/LancementPopup.sh "$Map_changer_pas_de_cle" &
	sleep 6
	/navi_rw/utility/GestNav4/PopupFin.sh &
fi
/bin/sync
		echo "**********************" > /dev/kmsg

exit 0