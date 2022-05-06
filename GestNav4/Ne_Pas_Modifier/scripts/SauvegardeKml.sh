#!/bin/bash
# GestNav4 Sauvegarde des kml
		echo "**********************" > /dev/kmsg
		echo "Sauvegarde des kml" > /dev/kmsg
dir2=`tail -n 1 /etc/mtab`
dir=${dir2:10:20}
source /navi_rw/utility/GestNav4/common.sh
source /navi_rw/utility/GestNav4/SuiviLog.sh
source /navi_rw/utility/GestNav4/Traduction.sh
suivi_log "Sauvegarde KML"
# on vérifie que le chemin est valide
if [ -d "$cle" ]
then
	/navi_rw/utility/GestNav4/LancementPopup.sh "$Sauvegarde_kml_perso" &
#lancement son début
	EnvoiSon startup.wav $1 1         #son, type media, durée en seconde
	mount -o remount,rw $clem
	/bin/sync
	
	tdate=$(date +%d_%m_%Y_%H_%M)
	cd /navi/content/userdata && tar zcvf $dir/GestNav4/sauvegarde_restauration/kml_personnels/kml_$tdate.tar.gz * > /dev/kmsg
	suivi_log "		= > OK"	
	mount -o remount,ro $clem

#lancement son fin et fin popup
	EnvoiSon sauvegarde.wav $1 2
	/navi_rw/utility/GestNav4/PopupFin.sh &
	
fi
/bin/sync
		echo "**********************" > /dev/kmsg
exit 0
