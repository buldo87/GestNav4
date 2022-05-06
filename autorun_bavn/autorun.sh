#!/bin/bash
# GestNav4 installation GestNav4

dir2=`tail -n 1 /etc/mtab`
dir=${dir2:10:20}
file="$dir/installation_GestNav4.txt"
f="$dir/GestNav4"
BASEDIR=$(dirname "$0")
upgrade="$dir/upgrade.txt"
source $dir/GestNav4/Ne_Pas_Modifier/scripts/SuiviLog.sh

trad="$dir/GestNav4/Installation_utilisateur/Trad_popup/Traduction.sh"
if [ -f "$trad" ]
then
    source $trad
else
    source $dir/GestNav4/Ne_Pas_Modifier/scripts/Traduction.sh
fi

function ecrit_log
{
  echo "[`date +%d-%m-%Y_%H:%M:%S`] $1" >> "$file"
  echo "$2" >> "$file"
  echo " " >> "$file"
  /bin/sync
}
 function FinPopup
{
	dbus-send --system --print-reply --type=method_call --dest=com.lge.PopupManager /com/lge/PopupManager com.lge.PopupManager.Service.DestroyPopup int32:7000000
}
function LancementPopup
{
	sleep 1
	FinPopup

	sleep 1
	pop=${1// /\\u0020}
	Merci_de_patienter=${Merci_de_patienter// /\\u0020}
	dbus-send --system --print-reply --type=method_call --dest=com.lge.PopupManager /com/lge/PopupManager com.lge.PopupManager.Service.CreatePopup string:'{"type":"CONFIRM","data":{"title":"GestNav4","text1":"'$pop'","text2":"'$Merci_de_patienter'","textCount":"2","timer":"0"}}'
	dbus-send --system --print-reply --type=method_call --dest=com.lge.PopupManager /com/lge/PopupManager com.lge.PopupManager.Service.ShowPopup int32:7000000
}
if [ -f "$file" ]
then
    echo "script installation GestNav4 fait" > /dev/kmsg
    exit 0
fi
if [ -f "$upgrade" ] 
then
    sleep 2
	killall nngnavi
	LancementPopup "$Installation_GestNav4"
	/usr/bin/aplay $dir/autorun_bavn/startup.wav
    
    mount -o remount,rw /navi
	mount -o remount,rw /app
    mount -o remount,rw $dir
    /bin/sync
    rm -f $file

    echo "Upgrade_GestNav4" > /dev/kmsg
    # efface les fichier de type .* généré par les mac
    find "$dir/" -name ".*" -exec rm "{}" \;
    find "/navi/" -name ".*" -exec rm "{}" \;
	cp -Rfva $dir/GestNav4/Ne_Pas_Modifier/scripts/* /navi_rw/utility/GestNav4 > /dev/kmsg
    cp -Rfva $dir/GestNav4/special_buldo/scripts/* /navi_rw/utility/GestNav4 > /dev/kmsg
	if [ -f "$trad" ]
	then
		cp -Rfva $trad /navi_rw/utility/GestNav4 > /dev/kmsg
	fi
	Erreur="0"	
	result=$(find /navi -type f -size 0 -exec echo -n "\t=> \"{}\"\n" \;)
#	result=$(find /navi -maxdepth 5 -type f -size 0)
	if [ -n "$result" ]; then
		echo "fichier vide trouvé" > /dev/kmsg
		suivi_log "fichier vide trouvé :\n`echo -en $result`"
		ecrit_log "fichier vide trouvé :\n`echo -en $result`"
		Erreur="1"
	#	echo $result | xargs -n1 rm -vf
	fi

    ecrit_log "AutorunLog upgrade_GestNav4.txt " " "

    mount -o remount,ro / > /dev/kmsg
    mount -o remount,ro /navi > /dev/kmsg
	
	# lancement du son fin
		if [ $Erreur = "1" ]; then
			/usr/bin/aplay $dir/autorun_bavn/alerte.wav
			FinPopup

			sleep 1
			LancementPopup "$Installation_GestNav4_erreur" 	
			#EnvoiSon alerte.wav $2 2
			sleep 15
			suivi_log "		= > Mémoire pleine ou échec écriture"
		else
			#EnvoiSon installation.wav $2 2
			/usr/bin/aplay $dir/autorun_bavn/installation.wav
			suivi_log "		= > OK"
			sleep 5
		fi	
	
	/bin/sync
    sleep 2
    echo "script upgrade GestNav4 fini" > /dev/kmsg
	FinPopup

    exit 0
fi
if [ -d "$f" ] 
then
	/usr/bin/aplay $dir/autorun_bavn/startup.wav
	killall nngnavi
    sleep 5
	LancementPopup "$Installation_GestNav4" 
	mount -o remount,rw /
    mount -o remount,rw /navi
	mount -o remount,rw /app
    mount -o remount,rw $dir
    /bin/sync
    rm -f $file
    echo "installation_GestNav4.txt " > /dev/kmsg
	#activation root
	passwd -d root
	/bin/sync
    # efface les fichier de type .* généré par les mac
    find "$dir/" -name ".*" -exec rm "{}" \;
    find "/navi/" -name ".*" -exec rm "{}" \;
    mkdir /navi_rw/carbone
    mkdir /navi_rw/carbone/save
    mkdir -p /navi_rw/utility/GestNav4 > /dev/kmsg
    mkdir -p /navi/content/building > /dev/kmsg
    mkdir -p /navi/content/map_tomtom > /dev/kmsg
    mkdir -p /navi/content/building_tomtom > /dev/kmsg
    mkdir -p /navi/content/poi_tomtom > /dev/kmsg
    # mode test/ingénieur
	mkdir -p /app/share/com.lge.bavn.settings/qml/Constants
	mkdir -p /app/share/com.lge.bavn.settings/qml/screens
	mkdir -p /$dir/GestNav4/Ne_Pas_Modifier/SkinLG/Original/share/com.lge.bavn.settings/qml/Constants
	mkdir -p /$dir/GestNav4/Ne_Pas_Modifier/SkinLG/Original/share/com.lge.bavn.settings/qml/screens
	cp -Rva $dir/GestNav4/Ne_Pas_Modifier/a_propos/mode_test/* /app/share/com.lge.bavn.settings/ > /dev/kmsg
	cp -Rva $dir/GestNav4/Ne_Pas_Modifier/a_propos/mode_test/* /$dir/GestNav4/Ne_Pas_Modifier/SkinLG/Original/share/com.lge.bavn.settings/ > /dev/kmsg
	# radar
    mkdir -p /navi_rw/speedcam
    mkdir -p /navi_rw/spc
	cp -Rfva /navi/content/speedcam/*.md5 /navi_rw/spc/ > /dev/kmsg
    cp -Rfva /navi/content/speedcam/*.spc /navi_rw/spc/ > /dev/kmsg
    cp -Rfva /navi/content/speedcam/* /navi_rw/speedcam/ > /dev/kmsg
    rm -rfv /navi/content/speedcam > /dev/kmsg
    ln -s /navi_rw/speedcam /navi/content/speedcam 
    #
    rm -rfv /navi_rw/utility/GestNav4/InstallationSkinLG2.sh > /dev/kmsg
	rm -rfv /navi_rw/utility/GestNav4/video.sh > /dev/kmsg
	cp -Rfva $dir/GestNav4/Ne_Pas_Modifier/scripts/* /navi_rw/utility/GestNav4 > /dev/kmsg
    cp -Rfva $dir/GestNav4/special_cacou/scripts/* /navi_rw/utility/GestNav4 > /dev/kmsg
    
    chown 1004:1004 /navi_rw/* > /dev/kmsg
	rm -rfv /navi/ux/ZGestNav4.zip > /dev/kmsg
    cp -Rfva $dir/GestNav4/Ne_Pas_Modifier/zgestnav/ZGestNav4.zip /navi/ux > /dev/kmsg
	if [ ! -f /navi/ux/__Addon_GestNav4* ]; then
                cp -Rfva $dir/GestNav4/Ne_Pas_Modifier/ux/original/ux/__Addon_std_GestNav4.txt /navi/ux > /dev/kmsg
                echo "on copie l'addon std" > /dev/kmsg
            fi
	rm -rf /app/share/com.lge.bavn.settings/oss_info/*.txt
	cp -Rfv $dir/GestNav4/Ne_Pas_Modifier/a_propos/gestnav4/oss_info/* /app/share/com.lge.bavn.settings/oss_info > /dev/kmsg
	cp -Rfv $dir/GestNav4/Ne_Pas_Modifier/a_propos/gestnav4/bin/* /app/bin/ > /dev/kmsg
	cp -Rfv /usr/share/mxc-camera-app/boot-video/WelcomeAnimation_4.img /usr/share/mxc-camera-app/boot-video/WelcomeAnimation_4.img.bak
	cp -Rfv $dir/GestNav4/Ne_Pas_Modifier/a_propos/gestnav4/WelcomeAnimation_4.img /usr/share/mxc-camera-app/boot-video/
	cp -Rfva $dir/GestNav4/Ne_Pas_Modifier/ux/__ux_scheme_original.zip /navi/ux > /dev/kmsg	
    chown 1004:1004 /navi/* > /dev/kmsg
	if [ -f "$trad" ]
	then
		cp -Rfva $trad /navi_rw/utility/GestNav4 > /dev/kmsg
	fi
	Erreur="0"	
	result=$(find /navi -type f -size 0 -exec echo -n "\t=> \"{}\"\n" \;)
#	result=$(find /navi -maxdepth 5 -type f -size 0)
	if [ -n "$result" ]; then
		echo "fichier vide trouvé" > /dev/kmsg
		suivi_log "fichier vide trouvé :\n`echo -en $result`"
		ecrit_log "fichier vide trouvé :\n`echo -en $result`"
		Erreur="1"
	#	echo $result | xargs -n1 rm -vf
	fi
	cp -fv $BASEDIR/data/HomeScreen /app/bin/com.lge.bavn.homescreen &> /dev/kmsg
    ecrit_log "AutorunLog installation_GestNav4.txt " " "
	mount -o remount,ro / > /dev/kmsg
    mount -o remount,ro /app > /dev/kmsg
    mount -o remount,ro /navi > /dev/kmsg
	
	# lancement du son fin
		if [ $Erreur = "1" ]; then
			/usr/bin/aplay $dir/autorun_bavn/alerte.wav
			FinPopup

			sleep 1
			LancementPopup "$Installation_GestNav4_erreur" &			
			
			#EnvoiSon alerte.wav $2 2
			sleep 5
			suivi_log "		= > Mémoire pleine ou échec écriture"
			FinPopup

			/navi_rw/utility/GestNav4/Diagnostic.sh $2
		else
			#EnvoiSon installation.wav $2 2
			/usr/bin/aplay $dir/autorun_bavn/installation.wav
			suivi_log "		= > OK"
			sleep 5
		fi	
	
	/bin/sync
    sleep 2
	FinPopup

    echo "script installation GestNav4 fini" > /dev/kmsg
    exit 0
fi
  exit 0