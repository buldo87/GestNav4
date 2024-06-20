#!/bin/bash
# GestNav4 Sauvegarde des favoris
		echo "**********************" > /dev/kmsg
		echo "Sauvegarde des favoris" > /dev/kmsg
source /navi_rw/utility/GestNav4/common.sh
source /navi_rw/utility/GestNav4/SuiviLog.sh
source /navi_rw/utility/GestNav4/Traduction.sh
suivi_log "Sauvegarde favoris"
# on vérifie que le chemin est valide
if [ -d "$cle" ]
then
	/navi_rw/utility/GestNav4/LancementPopup.sh "$Sauvegarde_favoris" &
#lancement son début
	EnvoiSon startup.wav $1 1         #son, type media, durée en seconde
	mount -o remount,rw $clem
	/bin/sync
	tdate=$(date +%d_%m_%Y_%H_%M)
	mount -o remount,rw $clem
	/bin/sync
	ecrit_log "GestNav4 Sauvegarde des favoris" " "
	carbone="/navi/ux/_carbone.zip"
	if [ -f "$carbone" ]
	then
		cd /navi_rw/carbone/save && tar zcvf $dir/GestNav4/sauvegarde_restauration/favoris/favoris_$tdate.tar.gz user* > /dev/kmsg			
	else
		cd /navi_rw/save && tar zcvf $dir/GestNav4/sauvegarde_restauration/favoris/favoris_$tdate.tar.gz user* > /dev/kmsg	
	fi
	mkdir -p $dir/GestNav4/sauvegarde_restauration/favoris/ux > /dev/kmsg
	cp -vaf /navi/ux/pack_pois_GestNav4.zip $dir/GestNav4/sauvegarde_restauration/favoris/ux > /dev/kmsg
	suivi_log "		= > OK"	
	mount -o remount,ro $clem

#lancement son fin et fin popup
	EnvoiSon sauvegarde.wav $1 2
	/navi_rw/utility/GestNav4/PopupFin.sh &

else
	/navi_rw/utility/GestNav4/LancementPopup.sh "$Map_changer_pas_de_cle" &
	sleep 6
	/navi_rw/utility/GestNav4/PopupFin.sh &
fi
/bin/sync

		echo "**********************" > /dev/kmsg
exit 0