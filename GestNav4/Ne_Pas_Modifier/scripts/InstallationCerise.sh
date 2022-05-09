#!/bin/bash
# GestNav4 installation Cerise		
dir2=`tail -n 1 /etc/mtab`
dir=${dir2:10:20}
source /navi_rw/utility/GestNav4/common.sh
source /navi_rw/utility/GestNav4/SuiviLog.sh
source /navi_rw/utility/GestNav4/Traduction.sh

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

echo "************************************************" > /dev/kmsg
echo "Installation cerise" > /dev/kmsg

# on vérifie que le chemin est valide
			if [ -d "$dir/GestNav4/Installation_utilisateur/cerise/license" ] && [ -f "$dir/GestNav4/Installation_utilisateur/cerise/nngnavi" ] ; then
			echo "Installation cerise avec $media" > /dev/kmsg
			suivi_log "installation cerise sur $media"
			LancementPopup "$Installation_Cerise" &
			#lancement son début
			EnvoiSon startup.wav $1 1         #son, type media, durée en seconde
			sleep 2
			mount -o remount,rw /navi
			mount -o remount,rw $clem
			/bin/sync
    
			#copie Cerise	
			echo "copie des fichiers pour cerise" > /dev/kmsg
			cp -Rva $dir/GestNav4/Installation_utilisateur/cerise/license/LGe_Renault_ULC4_18CY_Primo_WEU_17Q2_HM_POI_KML_SPC_TMC_JV_iWEUHM@17Q2RenaultULC /navi/license/ > /dev/kmsg
			cp -Rva $dir/GestNav4/Installation_utilisateur/cerise/license/Mega_Free_1_Year_Update_FEU_NQ_2015_Q4.lyc /navi/license/ > /dev/kmsg
			cp -Rva $dir/GestNav4/Installation_utilisateur/cerise/license/Mega_Free_1_Year_Update_FEU_NQ_2018_Q3.lyc /navi/license/ > /dev/kmsg
			cp -Rva $dir/GestNav4/Installation_utilisateur/cerise/nngnavi /navi/ > /dev/kmsg
			
			chown -Rv 1004:1004 /navi/*
			suivi_log "		= > OK"
			mount -o remount,ro /navi
			mount -o remount,ro $clem
			/bin/sync
			EnvoiSon installation.wav $1 2
			FinPopup

		else
			echo "manque dossier cerise sur la clé" > /dev/kmsg
			suivi_log "		=> manque dossier cerise sur la clé, installation impossible"
			LancementPopup "$Installation_cerise_erreur_dossier" &
			sleep 8		
			FinPopup	
			
		fi
/bin/sync
echo "**** fin Installation cerise ********" > /dev/kmsg

exit 0