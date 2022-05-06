#!/bin/bash
# GestNav4 Suppression de GestNav
        echo "**********************" > /dev/kmsg
        echo "Suppression de GestNav" > /dev/kmsg
source /navi_rw/utility/GestNav4/common.sh
source /navi_rw/utility/GestNav4/SuiviLog.sh
source /navi_rw/utility/GestNav4/Traduction.sh
suivi_log "Desinstallation GestNav4"
# on vérifie que le chemin est valide
f="$dir/GestNav4"
file="/rw_data/log_Gestnav.txt"
function ecrit_log
{
  echo "[`date +%d-%m-%Y_%H:%M:%S`] $1" >> "$file"
  echo "$2" >> "$file"
  echo " " >> "$file"
  /bin/sync
}
if [ -d "$f" ]
then
/navi_rw/utility/GestNav4/LancementPopup.sh "$Desinstallation_GestNav4" &
#lancement son début
	EnvoiSon startup.wav $1 1         #son, type media, durée en seconde
	mount -o remount,rw /app
    mount -o remount,rw /
    mount -o remount,rw /navi
    mount -o remount,rw $clem
    /bin/sync
    rm -rfv /navi/ux/__* > /dev/kmsg
    rm -rfv /navi/ux/pack_pois_GestNav4.zip > /dev/kmsg
    rm -rfv /navi/ux/_carbone* > /dev/kmsg
	rm -rfv /navi/ux/_skin_renault45.zip > /dev/kmsg
	rm -rfv /navi/ux/_skin_dacia45.zip > /dev/kmsg
    rm -rfv /navi/ux/ZGestNav4.zip > /dev/kmsg
    rm -rfv /navi_rw/speedcam/*.txt > /dev/kmsg
    rm -rfv /navi_rw/speedcam/*.spdb > /dev/kmsg
	rm -rfv /navi_rw/speedcam/SpeedcamUpdates.spud > /dev/kmsg
    rm -rfv /navi/ux/ux_car_* > /dev/kmsg
	rm -rfv /navi/ux/ux_carsize_cacou.zip > /dev/kmsg
    rm -rfv /navi/content/building_tomtom > /dev/kmsg
    rm -rfv /navi/content/map_tomtom > /dev/kmsg
    rm -rfv /navi/content/poi_tomtom > /dev/kmsg
    rm -rfv /navi/content/car > /dev/kmsg
    rm -rfv /navi_rw/carbone > /dev/kmsg
	rm -rfv /app/share/com.lge.bavn.settings/oss_info/*.txt
	cp -Rfva $dir/GestNav4/Ne_Pas_Modifier/a_propos/original/oss_info/* /app/share/com.lge.bavn.settings/oss_info > /dev/kmsg
	# mode test/ingénieur
	cp -Rfva $dir/GestNav4/Ne_Pas_Modifier/a_propos/original/bin/* /app/bin/ > /dev/kmsg
	# mode test/ingénieur
	
	rm -rfv /app/share/com.lge.bavn.settings/img/MI/GestNav_* > /dev/kmsg
	rm -rfv /app/share/com.lge.bavn.settings/qml/Constants/ImagePath.qml > /dev/kmsg
	rm -rfv /app/share/com.lge.bavn.settings/qml/screens > /dev/kmsg
	rm -rfv /$dir/GestNav4/Ne_Pas_Modifier/SkinLG/Original/share/com.lge.bavn.settings/img/MI/GestNav_* > /dev/kmsg
	rm -rfv /$dir/GestNav4/Ne_Pas_Modifier/SkinLG/Original/share/com.lge.bavn.settings/qml > /dev/kmsg
	# code auhentification
	rm -rfv /app/share/com.lge.bavn.appclock/qml > /dev/kmsg
	rm -rfv /$dir/GestNav4/Ne_Pas_Modifier/SkinLG/Original/share/com.lge.bavn.appclock/qml > /dev/kmsg
    #radar
    unlink /navi/content/speedcam
    cp -Rva /navi_rw/speedcam /navi/content > /dev/kmsg
    rm -rfv /navi_rw/speedcam > /dev/kmsg
    cp -Rva /navi_rw/spc/* /navi/content/speedcam > /dev/kmsg
    rm -rfv /navi_rw/speedcam > /dev/kmsg	
    rm -rfv /navi_rw/spc > /dev/kmsg
    cp -Rfv /usr/share/mxc-camera-app/boot-video/WelcomeAnimation_4.img.bak /usr/share/mxc-camera-app/boot-video/WelcomeAnimation_4.img
    cp -Rva $dir/GestNav4/Ne_Pas_Modifier/ux/original/* /navi > /dev/kmsg
	rm -rfv /navi/ux/__Addon_std_GestNav4.txt > /dev/kmsg
	# lancement son fin et fin popup
	EnvoiSon cagade.wav $1 3
	/navi_rw/utility/GestNav4/PopupFin.sh &
	/navi_rw/utility/GestNav4/Diagnostic.sh	
    sleep 3
    rm -rfv /navi/utility > /dev/kmsg
    rm -rfv /navi_rw/utility > /dev/kmsg
	suivi_log "		= > OK"	
	rm -rfv /rw_data/log_Gestnav.txt > /dev/kmsg
    mount -o remount,ro /navi
    mount -o remount,ro $clem
    mount -o remount,ro /
	else
        /navi_rw/utility/GestNav3/LancementPopup.sh "$Map_changer_pas_de_cle" &
        sleep 6
        /navi_rw/utility/GestNav3/PopupFin.sh &
fi
    /bin/sync
fi
    echo "**********************" > /dev/kmsg
exit 0