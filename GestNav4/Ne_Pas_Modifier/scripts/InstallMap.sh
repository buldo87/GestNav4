#!/bin/bash
# GestNav4 installation cartographie à partir de /GestNav4/Installation_utilisateur/navi sur clé
source /navi_rw/utility/GestNav4/SuiviLog.sh
source /navi_rw/utility/GestNav4/common.sh
source /navi_rw/utility/GestNav4/Traduction.sh

echo "**********************" > /dev/kmsg
echo "installation cartographie" > /dev/kmsg
echo "argument1=$1 argument2=$2" > /dev/kmsg
suivi_log "*************************"		
suivi_log "Installation cartographie $1 sur $2"
suivi_log "`df -h /navi`"
# on vérifie que le chemin est valide
if [ -d "$cle" ]
then
	mount -o remount,rw /navi
	mount -o remount,rw $clem
	/bin/sync

# efface les fichier de type .* généré par les mac
	
	case $1 in
        "navi")
		# on copie automatiquement les fichiers et répertoires autorisés par cacou, le reste est ignoré
		# liste des répertoires ignorés à la copie : building, building_tomtom, dem, map, map_tomtom, phoneme, poi, poi_tomtom, raster, scheme, speedcam
			/navi_rw/utility/GestNav4/LancementPopup.sh "$Installation_fichiers_utilisateurs_navi" &
		#lancement son début
			EnvoiSon startup.wav $2 1		#son, type media, durée en seconde
			find "$dir/" -name ".*" -exec rm "{}" \;
			find "/navi/" -name ".*" -exec rm "{}" \;
			$dir/GestNav4/Ne_Pas_Modifier/scripts/cpnavicac $dir/GestNav4/Installation_utilisateur/navi  > /dev/kmsg
            ;;
        "here")
			/navi_rw/utility/GestNav4/LancementPopup.sh "$Installation_cartographie_here" &
		#lancement son début
			EnvoiSon startup.wav $2 1		#son, type media, durée en seconde
			find "$dir/" -name ".*" -exec rm "{}" \;
			find "/navi/" -name ".*" -exec rm "{}" \;
            $dir/GestNav4/Ne_Pas_Modifier/scripts/cpnng $dir/GestNav4/Installation_utilisateur/map_changer/map /navi/content/map > /dev/kmsg
			$dir/GestNav4/Ne_Pas_Modifier/scripts/cpnng $dir/GestNav4/Installation_utilisateur/map_changer/poi /navi/content/poi> /dev/kmsg
			$dir/GestNav4/Ne_Pas_Modifier/scripts/cpnng $dir/GestNav4/Installation_utilisateur/map_changer/building /navi/content/building> /dev/kmsg
            ;;
        "tomtom")
			/navi_rw/utility/GestNav4/LancementPopup.sh "$Installation_cartographie_tomtom" &
		#lancement son début
			EnvoiSon startup.wav $2 1		#son, type media, durée en seconde
			find "$dir/" -name ".*" -exec rm "{}" \;
			find "/navi/" -name ".*" -exec rm "{}" \;
			$dir/GestNav4/Ne_Pas_Modifier/scripts/cpnng $dir/GestNav4/Installation_utilisateur/map_changer/map_tomtom /navi/content/map_tomtom> /dev/kmsg
			$dir/GestNav4/Ne_Pas_Modifier/scripts/cpnng $dir/GestNav4/Installation_utilisateur/map_changer/poi_tomtom /navi/content/poi_tomtom> /dev/kmsg
			$dir/GestNav4/Ne_Pas_Modifier/scripts/cpnng $dir/GestNav4/Installation_utilisateur/map_changer/building_tomtom /navi/content/building_tomtom> /dev/kmsg
            ;;
        *)
			echo "Oups argument 1 $1" > /dev/kmsg
            ;;
	esac
	Erreur="0"	
	result=$(find /navi -type f -size 0 -exec echo -n "\t=> \"{}\"\n" \;)
	if [ -n "$result" ]; then
		echo "fichier vide trouvé" > /dev/kmsg
		suivi_log "fichier vide trouvé :\n`echo -en $result`"
		ecrit_log "fichier vide trouvé :\n`echo -en $result`"
		Erreur="1"
	fi
	
	chown 1004:1004 /navi/*
	chmod -R 664 /navi/content/*
	mount -o remount,ro /navi
	mount -o remount,ro $clem
# lancement son fin et fin popup
        if [ $Erreur = "1" ]; then
            /usr/bin/aplay $dir/autorun_bavn/alerte.wav
            $dir/GestNav4/Ne_Pas_Modifier/scripts/PopupFin.sh &
            sleep 1
            $dir/GestNav4/Ne_Pas_Modifier/scripts/LancementPopup.sh "$Installation_GestNav4_erreur" &

            #EnvoiSon alerte.wav $2 2
            sleep 5
            suivi_log "        = > Mémoire pleine ou échec écriture"
            $dir/GestNav4/Ne_Pas_Modifier/scripts/PopupFin.sh &
            /navi_rw/utility/GestNav4/Diagnostic.sh $2
        else
            EnvoiSon installation.wav $2 2
            #/usr/bin/aplay $dir/autorun_bavn/installation.wav
            suivi_log "        = > OK"
            sleep 5
        fi	
	/navi_rw/utility/GestNav4/PopupFin.sh &
fi
/bin/sync
echo "**********************" > /dev/kmsg
suivi_log "`df -h /navi`"
suivi_log "*************************"

exit 0