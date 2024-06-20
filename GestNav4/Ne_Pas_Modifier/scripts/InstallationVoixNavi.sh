#!/bin/bash
# Installation voix améliorées GPS
echo "********** Installation voix améliorées GPS $1 avec $2 *************" > /dev/kmsg
source /navi_rw/utility/GestNav4/SuiviLog.sh
source /navi_rw/utility/GestNav4/common.sh
source /navi_rw/utility/GestNav4/Traduction.sh
suivi_log "Installation voix améliorées GPS $1 avec $2"

if [ -d "$dir/GestNav4" ] || [ -d "$dure" ];then
    mount -o remount,rw $clem
    mount -o remount,rw /app
	mount -o remount,rw /navi
    /bin/sync

    case $1 in
        "BelgeClaire")
			/navi_rw/utility/GestNav4/LancementPopup.sh "$Installation_VoixNavi" &
			#lancement son début
			EnvoiSon startup.wav $2 1		#son, type media, durée en seconde
			cp -Rva $dir/GestNav4/Ne_Pas_Modifier/voix/BelgeClaire/Voice_MediaNav_Belge_Claire_by_MCC.zip /navi/content/voice/ > /dev/kmsg
            ;;
        "FranceClaire")
			/navi_rw/utility/GestNav4/LancementPopup.sh "$Installation_VoixNavi" &
			#lancement son début
			EnvoiSon startup.wav $2 1		#son, type media, durée en seconde
			cp -Rva $dir/GestNav4/Ne_Pas_Modifier/voix/FranceClaire/Voice_MediaNav_France_Claire_by_MCC.zip /navi/content/voice/ > /dev/kmsg
            ;;
        "Original")
			/navi_rw/utility/GestNav4/LancementPopup.sh "$Installation_VoixNavi_original" &
			#lancement son début
			EnvoiSon startup.wav $2 1		#son, type media, durée en seconde
			rm -rfv /navi/content/voice/Voice_MediaNav_Belge_Claire_by_MCC.zip > /dev/kmsg
			rm -rfv /navi/content/voice/Voice_MediaNav_France_Claire_by_MCC.zip > /dev/kmsg
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
