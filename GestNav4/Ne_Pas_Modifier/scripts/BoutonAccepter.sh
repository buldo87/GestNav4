#!/bin/bash
#  bouton accepter
echo "********** bouton accepter $1 avec $2 *************" > /dev/kmsg
source /navi_rw/utility/GestNav4/SuiviLog.sh
source /navi_rw/utility/GestNav4/common.sh
source /navi_rw/utility/GestNav4/Traduction.sh
dure="/navi/utility/GestNav4/Ne_Pas_Modifier"
suivi_log "Installation/desinstallation bouton accepter $1 avec $2 **********"

if [ -d "$dir/GestNav4" ] || [ -d "$dure" ];then
	test=$(sha256sum /app/bin/com.lge.bavn.homescreen/HomeScreen | cut -c1-64)
	case $test in
        "51669b33e634dcb311f014e35421a52f9c300ebe3a8f88a896c8c3b602e1fbaa"| "a8d8b50c4c8a0f372c0441a99b93089815c9d60b38b1a580da3d05776e7a046b")
			mount -o remount,rw $clem
			mount -o remount,rw /app
			/bin/sync
			mkdir -p /app/share/com.lge.bavn.homescreen/qml/Screen
			case $1 in
				"installation")
				/navi_rw/utility/GestNav4/LancementPopup.sh "$Bouton_accept_ON" &
				#lancement son début
				EnvoiSon startup.wav $2 1		#son, type media, durée en seconde
				killall HomeScreen
				cp -Rfva $dir/GestNav4/Ne_Pas_Modifier/scripts/HomeScreen_98_custom_accepte /app/bin/com.lge.bavn.homescreen/HomeScreen > /dev/kmsg			
				suivi_log "		= >installation OK"	
				;;
				"desinstallation")
				/navi_rw/utility/GestNav4/LancementPopup.sh "$Bouton_accept_OFF" &
				#lancement son début
				EnvoiSon startup.wav $2 1		#son, type media, durée en seconde
				killall HomeScreen
				cp -Rfva $dir/GestNav4/Ne_Pas_Modifier/scripts/HomeScreen_98_custom /app/bin/com.lge.bavn.homescreen/HomeScreen > /dev/kmsg	
				suivi_log "		= >desinstallation OK"	
				;;

				*)
				echo "Oups argument 1 $1" > /dev/kmsg
				;;
			esac
			mount -o remount,ro $clem
			mount -o remount,ro /app
			# lancement son fin et fin popup
			EnvoiSon installation.wav $2 2
			/navi_rw/utility/GestNav4/PopupFin.sh &
			/bin/sync

		;;
	
		
        *)
			echo "Oups pas la bonne version x.0.9.8 custom" > /dev/kmsg
			suivi_log "		=> Oups pas en version x.0.9.8_custom, Version différente $test****"
			/navi_rw/utility/GestNav4/LancementPopup.sh "$Installation_erreur_version" &
			sleep 8
			/navi_rw/utility/GestNav4/PopupFin.sh &			
        ;;
	esac

		


else
		/navi_rw/utility/GestNav4/LancementPopup.sh "$Absence_cle" &
		sleep 6
		/navi_rw/utility/GestNav4/PopupFin.sh & 
fi
