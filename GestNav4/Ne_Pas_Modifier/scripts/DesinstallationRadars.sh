#!/bin/bash
# GestNav4 Desinstallation Radars
source /navi_rw/utility/GestNav4/SuiviLog.sh
source /navi_rw/utility/GestNav4/common.sh
source /navi_rw/utility/GestNav4/Traduction.sh
dure="/navi/utility/GestNav4/Ne_Pas_Modifier"
		echo "**********************" > /dev/kmsg
		echo "Desinstallation Radars " > /dev/kmsg
suivi_log "Desinstallation Radars"
# on vérifie que le chemin est valide
f="$dir/GestNav4"

if [ -d "$dir/GestNav4" ] || [ -d "$dure" ];then
/navi_rw/utility/GestNav4/LancementPopup.sh "$Desinstallation_Radars" &
#lancement son début
	EnvoiSon startup.wav $1 1         #son, type media, durée en seconde
mount -o remount,rw /navi
mount -o remount,rw $clem
/bin/sync

rm -rfv /navi_rw/speedcam/*.txt > /dev/kmsg
rm -rfv /navi_rw/speedcam/*.spc > /dev/kmsg
rm -rfv /navi_rw/speedcam/*.spdb > /dev/kmsg

ls  -la /navi_rw/speedcam > /dev/kmsg

if [ -f /navi/radars_std.ini ]; then
	cp -Rva $dir/GestNav4/Ne_Pas_Modifier/ux/original/sys.txt /navi > /dev/kmsg
	rm -rfv /navi/radars_std.ini > /dev/kmsg
	echo "on copie le sys.txt original pour les radars et on supprime le fichier ini" > /dev/kmsg
fi


suivi_log "		= > OK"
mount -o remount,ro /navi
mount -o remount,ro $clem

# lancement son fin et fin popup
	EnvoiSon desinstallation.wav $1 2
	/navi_rw/utility/GestNav4/PopupFin.sh &

else
		/navi_rw/utility/GestNav4/LancementPopup.sh "$Absence_cle" &
		sleep 6
		/navi_rw/utility/GestNav4/PopupFin.sh & 
fi
/bin/sync
		echo "**********************" > /dev/kmsg
exit 0