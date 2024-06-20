#!/bin/bash
# Installation font GPS
echo "********** Installation font GPS $1 avec $2 *************" > /dev/kmsg
source /navi_rw/utility/GestNav4/SuiviLog.sh
source /navi_rw/utility/GestNav4/common.sh
source /navi_rw/utility/GestNav4/Traduction.sh
dure="/navi/utility/GestNav4/Ne_Pas_Modifier"
suivi_log "Installation font GPS $1 avec $2"

if [ -d "$dir/GestNav4" ] || [ -d "$dure" ];then
    mount -o remount,rw $clem
    mount -o remount,rw /app
	mount -o remount,rw /navi
    /bin/sync

    case $1 in
        "Algerian")
			/navi_rw/utility/GestNav4/LancementPopup.sh "$Installation_FontGPS" &
			#lancement son début
			EnvoiSon startup.wav $2 1		#son, type media, durée en seconde
			cp -Rva $dir/GestNav4/Ne_Pas_Modifier/fonts/Algerian/__addon_font_Primo.zip /navi/ux/ > /dev/kmsg
            ;;
        "Sugar")
			/navi_rw/utility/GestNav4/LancementPopup.sh "$Installation_FontGPS" &
			#lancement son début
			EnvoiSon startup.wav $2 1		#son, type media, durée en seconde
			cp -Rva $dir/GestNav4/Ne_Pas_Modifier/fonts/Sugar/__addon_font_Primo.zip /navi/ux/ > /dev/kmsg
            ;;
		"Airstream")
			/navi_rw/utility/GestNav4/LancementPopup.sh "$Installation_FontGPS" &
			#lancement son début
			EnvoiSon startup.wav $2 1		#son, type media, durée en seconde
			cp -Rva $dir/GestNav4/Ne_Pas_Modifier/fonts/Airstream/__addon_font_Primo.zip /navi/ux/ > /dev/kmsg
            ;;
        "Original")
			/navi_rw/utility/GestNav4/LancementPopup.sh "$Installation_FontGPS_original" &
			#lancement son début
			EnvoiSon startup.wav $2 1		#son, type media, durée en seconde
			rm -rfv /navi/ux/__addon_font_Primo.zip > /dev/kmsg
            ;;
        "Perso1")
			/navi_rw/utility/GestNav4/LancementPopup.sh "$Installation_FontGPS" &
			#lancement son début
			EnvoiSon startup.wav $2 1		#son, type media, durée en seconde
			cp -Rva $clem/GestNav4/Installation_utilisateur/fonts/Perso1/__addon_font_Primo.zip /navi/ux/ > /dev/kmsg
            ;;
		"Perso2")
			/navi_rw/utility/GestNav4/LancementPopup.sh "$Installation_FontGPS" &
			#lancement son début
			EnvoiSon startup.wav $2 1		#son, type media, durée en seconde
			cp -Rva $clem/GestNav4/Installation_utilisateur/fonts/Perso2/__addon_font_Primo.zip /navi/ux/ > /dev/kmsg
            ;;
		"Perso3")
			/navi_rw/utility/GestNav4/LancementPopup.sh "$Installation_FontGPS" &
			#lancement son début
			EnvoiSon startup.wav $2 1		#son, type media, durée en seconde
			cp -Rva $clem/GestNav4/Installation_utilisateur/fonts/Perso3/__addon_font_Primo.zip /navi/ux/ > /dev/kmsg
            ;;
		"Perso4")
			/navi_rw/utility/GestNav4/LancementPopup.sh "$Installation_FontGPS" &
			#lancement son début
			EnvoiSon startup.wav $2 1		#son, type media, durée en seconde
			cp -Rva $clem/GestNav4/Installation_utilisateur/fonts/Perso4/__addon_font_Primo.zip /navi/ux/ > /dev/kmsg
            ;;

        *)
            echo "Oups argument 1 $1" > /dev/kmsg
            ;;
    esac
	suivi_log "		= > OK"	
    mount -o remount,ro $clem
    mount -o remount,ro /app
	mount -o remount,ro /navi  

# lancement son fin et fin popup
	EnvoiSon installation.wav $2 2
	/navi_rw/utility/GestNav4/PopupFin.sh &

else
		/navi_rw/utility/GestNav4/LancementPopup.sh "$Absence_cle" &
		sleep 6
		/navi_rw/utility/GestNav4/PopupFin.sh & 
fi
/bin/sync
