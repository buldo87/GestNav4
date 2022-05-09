#!/bin/bash
echo " *********** installation divers navigation MN4 ************* " > /dev/kmsg
source /navi_rw/utility/GestNav4/common.sh
source /navi_rw/utility/GestNav4/SuiviLog.sh
source /navi_rw/utility/GestNav4/Traduction.sh
echo  "dir=$dir , cle=$cle , arg1=$1 , arg2=$2 , arg3=$3" > /dev/kmsg
suivi_log "****** installation.sh ******** dir=$dir , arg1=$1 , arg2=$2 , arg3=$3"
if [ -d "$dir/GestNav4" ];then
	
mount -o remount,rw /navi
mount -o remount,rw $clem
/bin/sync
#rm -f $dir/GestNav4.txt
TypeModif="installation"

case $1 in
        "schemes")
            CategorieModif="__ux_scheme_"
            ;;
        "fleche")
            CategorieModif="__ux_Arrow_"
            ;;
        "car")
            CategorieModif="ux_car_"
            ;;
		"POI")
            CategorieModif="__ux_poi_"
            ;;
		"radar")
            CategorieModif="__ux_alertes_eur+_"
            ;;
		"radarstd")
            CategorieModif="__ux_alertes_std_"
            ;;
		"telepules")
            CategorieModif="__ux_telepules_"
            ;;
		"skin")
            CategorieModif="skin_mediaevo_v3_"
            ;;
		"amelioration")
            CategorieModif="__"
            ;;
		"boot")
            ;;
		"boot_fav")
            ;;
        *)
			echo "Oups argument 1 $1" > /dev/kmsg
            ;;
esac

# Désinstallation
case $2 in
        "uninstall_scheme")
			TypeModif="desinstallation_schemes"
                echo " Desinstallation Scheme " > /dev/kmsg
                ;;
        "uninstall_skin")
			TypeModif="desinstallation_skin"
                echo " Desinstallation Skin " > /dev/kmsg
                ;;
        "uninstall_radar")
			TypeModif="desinstallation"
                echo " Desinstallation Radar " > /dev/kmsg
                ;;
		"uninstall_radarstd")
			TypeModif="desinstallation"
                echo " Desinstallation radarstd " > /dev/kmsg
                ;;
		"uninstall_fleche")
			TypeModif="desinstallation"
                echo " Desinstallation fleche " > /dev/kmsg
                ;;
		"uninstall_car")
			TypeModif="desinstallation"
                echo " Desinstallation car " > /dev/kmsg
                ;;
		"uninstall_POI")
			TypeModif="desinstallation"
                echo " Desinstallation POI " > /dev/kmsg
                ;;
		"uninstall_telepules")
			TypeModif="desinstallation"
                echo " Desinstallation Telepules " > /dev/kmsg
                ;;
		"uninstall_tous")
			TypeModif="desinstallation_tous"
                echo " Desinstallation Tous " > /dev/kmsg
                ;;
		*)
			echo " argument 2 $2" > /dev/kmsg
            ;;
esac

function install_mod
{
				if [ ! -f /navi/ux/__Addon_GestNav4* ]; then
					rm -v /navi_rw/speedcam/*.txt 
					rm -v /navi_rw/speedcam/*.spdb 
					echo "on vire les radars std" > /dev/kmsg
				fi	
				rm -rfv /navi/ux/__* > /dev/kmsg
				rm -rfv /navi/ux/_carbone* > /dev/kmsg				
				rm -rfv /navi/ux/_skin_renault45.zip > /dev/kmsg
				rm -rfv /navi/ux/_skin_dacia45.zip > /dev/kmsg
				cp -Rva $dir/GestNav4/Ne_Pas_Modifier/ux/original/ux/* /navi/ux > /dev/kmsg
				cp -Rva $dir/GestNav4/Ne_Pas_Modifier/ux/__ux_scheme_original.zip /navi/ux > /dev/kmsg
				cp -Rva $dir/GestNav4/Ne_Pas_Modifier/ux/__ux_addon_lang_french.zip /navi/ux > /dev/kmsg
				
				
			
}				
function install_mn4_type
{		
				if [ ! -f /navi/ux/__Addon_std_GestNav4* ]; then
					rm -v /navi_rw/speedcam/*.txt 
					rm -v /navi_rw/speedcam/*.spdb 
					echo "on vire les radars eur+" > /dev/kmsg
				fi	
				rm -rfv /navi/ux/__* > /dev/kmsg
				rm -rfv /navi/ux/_skin_dacia45.zip > /dev/kmsg
				rm -rfv /navi/ux/_carbone* > /dev/kmsg
				cp -Rva $dir/GestNav4/Ne_Pas_Modifier/ux/original/ux/* /navi/ux > /dev/kmsg
				cp -Rva $dir/GestNav4/Ne_Pas_Modifier/ux/__ux_scheme_original.zip /navi/ux > /dev/kmsg
				cp -v /navi_rw/spc/*.spc /navi_rw/speedcam
#				cp -v /navi_rw/spc/*.md5 /navi_rw/speedcam
				rm -rfv /navi/ux/__Addon_std_GestNav4.txt > /dev/kmsg
				cp -Rva $dir/GestNav4/Ne_Pas_Modifier/ux/mn4/* /navi			
}

echo " Categorie= $CategorieModif Type=$TypeModif" > /dev/kmsg
################################### installation
	if [ $TypeModif = "installation" ]; then
############ installation POI
        if [ $1 = "POI" ]; then
            if [ -f "$dir/GestNav4/Ne_Pas_Modifier/ux/$CategorieModif$2.zip" ];then
                /navi_rw/utility/GestNav4/LancementPopup.sh "$Installation_POI" &
                #lancement son début
                EnvoiSon startup.wav $3 1        #son, type media, durée en seconde
                suivi_log "    installation POI"
                echo "installation POI" > /dev/kmsg
                echo "rm -rfv /navi_rw/save/poi_visiblities" > /dev/kmsg
                echo "rm -rfv /navi/ux/$CategorieModif*" > /dev/kmsg
                echo "cp -Rva $dir/GestNav4/ux/$CategorieModif$2.zip /navi/ux" > /dev/kmsg
                rm -rfv /navi_rw/save/poi_visiblities* > /dev/kmsg
                rm -rfv /navi/ux/$CategorieModif* > /dev/kmsg
                cp -Rva $dir/GestNav4/Ne_Pas_Modifier/ux/$CategorieModif$2.zip /navi/ux > /dev/kmsg
                EnvoiSon installation.wav $3 1         #son, type=$1, durée en seconde
            else                 
                echo "installation POI pas de zip trouvé" > /dev/kmsg
                /navi_rw/utility/GestNav4/LancementPopup.sh "$ERREUR_POI" &
				sleep 8		
				/navi_rw/utility/GestNav4/PopupFin.sh &	
            fi

############ installation skin
		elif [ $1 = "skin" ]; then
			/navi_rw/utility/GestNav4/LancementPopup.sh "$Installation_Skin" &
			#lancement son début
			EnvoiSon startup.wav $3 1		#son, type media, durée en seconde
			suivi_log "	c'est un skin à installer"
			echo "c'est un skin à installer " > /dev/kmsg
			mv -v /navi_rw/speedcam/*.spc /navi_rw/spc
			mv -v /navi_rw/speedcam/*.md5 /navi_rw/spc
			rm -rfv /navi_rw/save/poi_visiblities* > /dev/kmsg
			if [ $2 = "mod_bleu" ]; then
				suivi_log "		mod_bleu"
				echo "mod_bleu" > /dev/kmsg
				install_mod
				cp -Rva $dir/GestNav3/Ne_Pas_Modifier/ux/__ux_poi_cacou_mcc.zip /navi/ux > /dev/kmsg
				cp -Rva $dir/GestNav3/Ne_Pas_Modifier/ux/__ux_Arrow_modbleu_cacou.zip /navi/ux > /dev/kmsg
				cp -Rva $dir/GestNav3/Ne_Pas_Modifier/ux/__ux_alertes_eur+_original_v1.zip /navi/ux > /dev/kmsg
				rm -rfv /navi/ux/__Addon_std_GestNav3.txt > /dev/kmsg
				cp -Rva $dir/GestNav3/Ne_Pas_Modifier/ux/mod_bleu/* /navi
			
			elif [ $2 = "mod_mediaevo" ];then
				suivi_log "		mod_mediaevo"
				echo "mod_mediaevo" > /dev/kmsg			
				install_mod
				cp -Rva $dir/GestNav3/Ne_Pas_Modifier/ux/__ux_poi_cacou_renault_dacia.zip /navi/ux > /dev/kmsg
				cp -Rva $dir/GestNav3/Ne_Pas_Modifier/ux/__ux_Arrow_original_mediaevo.zip /navi/ux > /dev/kmsg
				cp -Rva $dir/GestNav3/Ne_Pas_Modifier/ux/__ux_alertes_eur+_alain57_fonds_cyan.zip /navi/ux > /dev/kmsg
				rm -rfv /navi/ux/__Addon_std_GestNav3.txt > /dev/kmsg
				cp -Rva $dir/GestNav3/Ne_Pas_Modifier/ux/mod_mediaevo/* /navi

			elif [ $2 = "mod_mediaevo_plus" ];then
				suivi_log "		mod_mediaevo_plus"
				echo "mod_mediaevo_plus" > /dev/kmsg			
				install_mod
				cp -Rva $dir/GestNav3/Ne_Pas_Modifier/ux/__ux_poi_cacou_renault_dacia.zip /navi/ux > /dev/kmsg
				cp -Rva $dir/GestNav3/Ne_Pas_Modifier/ux/__ux_Arrow_blanc_renault_cacou.zip /navi/ux > /dev/kmsg
				cp -Rva $dir/GestNav3/Ne_Pas_Modifier/ux/__ux_alertes_eur+_original.zip /navi/ux > /dev/kmsg
				rm -rfv /navi/ux/__Addon_std_GestNav3.txt > /dev/kmsg
				cp -Rva $dir/GestNav3/Ne_Pas_Modifier/ux/mod_mediaevo_plus/* /navi

			elif [ $2 = "mod_rs" ]; then
				suivi_log "		mod_rs"
				echo "mod_rs" > /dev/kmsg
				install_mod
				cp -Rva $dir/GestNav3/Ne_Pas_Modifier/ux/__ux_poi_cacou_modRS.zip /navi/ux > /dev/kmsg
				cp -Rva $dir/GestNav3/Ne_Pas_Modifier/ux/__ux_Arrow_modRS_cacou.zip /navi/ux > /dev/kmsg
				cp -Rva $dir/GestNav3/Ne_Pas_Modifier/ux/__ux_alertes_eur+_original_v1.zip /navi/ux > /dev/kmsg
				rm -rfv /navi/ux/__Addon_std_GestNav3.txt > /dev/kmsg
				cp -Rva $dir/GestNav3/Ne_Pas_Modifier/ux/mod_rs/* /navi

			elif [ $2 = "mod_ultimate" ]; then
				suivi_log "		mod_ultimate"
				echo "mod_ultimate" > /dev/kmsg
				install_mod
				cp -Rva $dir/GestNav3/Ne_Pas_Modifier/ux/__ux_poi_cacou_inox.zip /navi/ux > /dev/kmsg
				cp -Rva $dir/GestNav3/Ne_Pas_Modifier/ux/__ux_Arrow_blanc_lisere_cacou.zip /navi/ux > /dev/kmsg
				cp -Rva $dir/GestNav3/Ne_Pas_Modifier/ux/__ux_alertes_eur+_Alain57_cacou_bigleux.zip /navi/ux > /dev/kmsg
				rm -rfv /navi/ux/__Addon_std_GestNav3.txt > /dev/kmsg
				cp -Rva $dir/GestNav3/Ne_Pas_Modifier/ux/mod_ultimate/* /navi

			elif [ $2 = "carbone" ]; then
				suivi_log "		carbone"
				echo "carbone" > /dev/kmsg
				if [ ! -f /navi/ux/__Addon_GestNav4* ]; then
					rm -v /navi_rw/speedcam/*.txt 
					rm -v /navi_rw/speedcam/*.spdb 
					echo "on vire les radars std" > /dev/kmsg
				fi	
				rm -rfv /navi/ux/__* > /dev/kmsg
				cp -Rva $dir/GestNav4/Ne_Pas_Modifier/ux/carbone/* /navi
				cp -Rva $dir/GestNav4/Ne_Pas_Modifier/ux/__ux_poi_cacou_mcc.zip /navi/ux > /dev/kmsg
				rm -rfv /navi/ux/_skin_dacia.zip > /dev/kmsg
				rm -rfv /navi/ux/_skin_lg_renault_ulc20.zip > /dev/kmsg
				rm -rfv /navi/ux/_skin_renault.zip > /dev/kmsg
				rm -rfv /navi/ux/_skin_renault45.zip > /dev/kmsg
				rm -rfv /navi/ux/_skin_dacia45.zip > /dev/kmsg
		
			elif [ $2 = "MN4" ]; then
				suivi_log "		MN4"
				echo "MN4" > /dev/kmsg			
				install_mn4_type
			
			elif [ $2 = "MN4_dacia" ]; then
				suivi_log "		MN4_dacia"
				echo "MN4" > /dev/kmsg			
				install_mn4_type
				cp -Rva $dir/GestNav4/Ne_Pas_Modifier/ux/mn4_dacia/* /navi
			fi
			EnvoiSon installation.wav $3 1         #son, type=$1, durée en seconde
############ installation image de boot_fav
		elif [ $1 = "boot_fav" ] && [ -d "$cle" ];then  
			/navi_rw/utility/GestNav4/LancementPopup.sh "$Installation_boot_fav" &
			#lancement son début
			EnvoiSon startup.wav $3 1		#son, type media, durée en seconde
			suivi_log "	installation image de boot_fav"
			echo "installation image de boot_fav" > /dev/kmsg
			mount -o remount,rw / > /dev/kmsg
			/bin/sync
			cp -fRva /usr/share/mxc-camera-app/boot-logo/* $clem/GestNav4/Installation_utilisateur/images_boot/sauvegarde/ > /dev/kmsg
			cp -fRva $clem/GestNav4/Installation_utilisateur/images_boot/$2.png /usr/share/mxc-camera-app/boot-logo/800x480_Dacia.png > /dev/kmsg
			cp -fRva $clem/GestNav4/Installation_utilisateur/images_boot/$2.png /usr/share/mxc-camera-app/boot-logo/800x480_Renault.png > /dev/kmsg
			mount -o remount,ro /
			/bin/sync
			# lancement du son
			EnvoiSon installation.wav $3 1         #son, type=$1, durée en seconde
			/sbin/reboot -f
############ installation image de boot
		elif [ $1 = "boot" ];then  
			echo "installation image de boot" > /dev/kmsg
			/navi_rw/utility/GestNav4/LancementPopup.sh "$Installation_boot" &
			#lancement son début
			EnvoiSon startup.wav $3 1		#son, type media, durée en seconde
			suivi_log "	installation image de boot"
			#mount -o remount,rw / > /dev/kmsg
			/bin/sync
			#cp -fRva /usr/share/mxc-camera-app/boot-logo/* $dir/GestNav4/Installation_utilisateur/images_boot/sauvegarde/ > /dev/kmsg
			#cp -fRva $dir/GestNav4/Ne_Pas_Modifier/images_boot/$2.png /usr/share/mxc-camera-app/boot-logo/800x480_Dacia.png > /dev/kmsg
			#cp -fRva $dir/GestNav4/Ne_Pas_Modifier/images_boot/$2.png /usr/share/mxc-camera-app/boot-logo/800x480_Renault.png > /dev/kmsg
			#mount -o remount,ro /
			/bin/sync
			# lancement du son
			EnvoiSon installation.wav $3 1         #son, type=$1, durée en seconde
			#/sbin/reboot -f
############ installation schemes
		elif [ $1 = "schemes" ] || [ $1 = "fleche" ] || [ $1 = "car" ] || [ $1 = "radar" ] || [ $1 = "radarstd" ] || [ $1 = "telepules" ] || [ $1 = "amelioration" ];then
			/navi_rw/utility/GestNav4/LancementPopup.sh "$Installation_ameliorations" &
			#lancement son début
			EnvoiSon startup.wav $3 1		#son, type media, durée en seconde
			suivi_log "	installation $1"
			echo "installation $1" > /dev/kmsg
			echo "rm -rfv /navi/ux/$CategorieModif*" > /dev/kmsg
			echo "cp -Rva $dir/GestNav4/Ne_Pas_Modifier/ux/$CategorieModif$2.zip /navi/ux" > /dev/kmsg
			rm -rfv /navi/ux/$CategorieModif* > /dev/kmsg
			cp -Rva $dir/GestNav4/Ne_Pas_Modifier/ux/$CategorieModif$2.zip /navi/ux	> /dev/kmsg
			EnvoiSon installation.wav $3 1         #son, type=$1, durée en seconde
		fi
	
############################## desinstallation
############ desinstallation sauf unistall_skin, uninstall_tous et uninstall_scheme, uninstall carbone
	elif [ $TypeModif = "desinstallation" ]; then 
			echo "****************desinstallation $1 *************" > /dev/kmsg	
		Popup "Désinstallation $1"
		navi_rw/utility/GestNav4/LancementPopup.sh "$Desinstallation_en_cours" &
			#lancement son début
			EnvoiSon startup.wav $3 1		#son, type media, durée en seconde
		suivi_log " desinstallation sauf unistall_skin, uninstall_tous et uninstall_scheme, uninstall carbone"
		echo "desinstallation sauf unistall_skin, uninstall_tous et uninstall_scheme, uninstall carbone" > /dev/kmsg
		echo "rm -rfv /navi/ux/$CategorieModif*" > /dev/kmsg
		rm -rfv /navi/ux/$CategorieModif* > /dev/kmsg
		EnvoiSon desinstallation.wav $3 1         #son, type=$1, durée en seconde

############ desinstallation unistall_skin
	elif [ $TypeModif = "desinstallation_skin" ]; then
		echo "****************desinstallation skin $1 *************" > /dev/kmsg	
		Popup "Désinstallation skin $1"
		navi_rw/utility/GestNav4/LancementPopup.sh "$Desinstallation_en_cours" &
			#lancement son début
			EnvoiSon startup.wav $3 1		#son, type media, durée en seconde
			suivi_log " c'est un skin à désinstaller"
			echo "c'est un skin à désinstaller" > /dev/kmsg
			install_mn4_type
			EnvoiSon desinstallation.wav $3 1         #son, type=$1, durée en seconde
############ desinstallation uninstall_tous
	elif [ $TypeModif = "desinstallation_tous" ]; then
		Popup "Désinstallation tous"
		navi_rw/utility/GestNav4/LancementPopup.sh "$Desinstallation_en_cours" &
			#lancement son début
			EnvoiSon startup.wav $3 1		#son, type media, durée en seconde
		suivi_log "	desinstallation tous"
		echo "faut tous effacer" > /dev/kmsg
		
		
		rm -rfv /navi/ux/__ux_scheme_* > /dev/kmsg
		rm -rfv /navi/ux/__ux_Arrow_* > /dev/kmsg
		rm -rfv /navi/ux/ux_car_* > /dev/kmsg
		rm -rfv /navi/ux/ux_carsize_cacou.zip > /dev/kmsg
		rm -rfv /navi/ux/__ux_poi_* > /dev/kmsg
		rm -rfv /navi/ux/__ux_alertes_* > /dev/kmsg
		rm -rfv /navi/ux/__ux_telepules_* > /dev/kmsg
		rm -rfv /navi/ux/__tripinfo.zip > /dev/kmsg
		rm -rfv /navi/ux/__Vitesse_Altitude.zip > /dev/kmsg
		rm -rfv /navi/ux/__vitesse.zip > /dev/kmsg
		rm -rfv /navi/ux/__Altitude.zip > /dev/kmsg
		rm -rfv /navi/ux/__Day_Night.zip > /dev/kmsg
		rm -rfv /navi/ux/__MiniJunctionView.zip > /dev/kmsg
		rm -rfv /navi/ux/__addon_font_Primo.zip > /dev/kmsg
		rm -fv /navi_rw/utility/GestNav4/loading_finished.sh > /dev/kmsg
#		rm -rfv /navi/ux/__skin_mediaevo_v3* > /dev/kmsg
		cp -Rva $dir/GestNav4/Ne_Pas_Modifier/ux/__ux_scheme_original.zip /navi/ux > /dev/kmsg
		EnvoiSon desinstallation.wav $3 1         #son, type=$1, durée en seconde
		
		
########### oups
	else
		echo "oups" > /dev/kmsg
	fi
# lancement du son

		/navi_rw/utility/GestNav4/PopupFin.sh &
fi
/bin/sync
echo " TypeModif=$TypeModif CategorieModif=$CategorieModif  arg1=$1 arg2=$2 " > /dev/kmsg
suivi_log "************* Fin Installation.sh ******************"
echo " ******************************* " > /dev/kmsg
exit 0
