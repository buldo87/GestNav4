#!/bin/bash
echo "******** MapChanger ************ " > /dev/kmsg
source /navi_rw/utility/GestNav4/SuiviLog.sh
source /navi_rw/utility/GestNav4/Traduction.sh
suivi_log "MapChanger $1"
dir2=`tail -n 1 /etc/mtab`
dir=${dir2:10:20}
#clem=$dir
cle="$dir/GestNav4/Ne_Pas_Modifier"
dure="/navi/utility/GestNav4/Ne_Pas_Modifier"
file="/navi/sys.txt"
echo "cle=$cle " > /dev/kmesg
#Prends en paramètre une liste de fichiers sur lesquels appliquer la modification, la clé, la valeur et la section sur laquelle s'applique la clé.
function setIniKey
{
echo "function setIniKey" > /dev/kmesg
    key=$2
    value=$3
    section=$4
    escapedKey=$(echo $key | sed -e 's/[]\/$*.^|[]/\\&/g')
    escapedValue=$(echo $value | sed -e 's/[]\/$*.^|[]/\\&/g')
    escapedSection=$(echo $section | sed -e 's/[]\/$*.^|[]/\\&/g')
    for ini in $(ls $1 2>/dev/null); do
        if ! grep -E "[#; ]*$escapedKey\s*=" $ini > /dev/null
        # Key is not in file
        then
            if [ -z "$4" ]
            then
                # There is no section, add to the end of file
                echo "$key=$value" >> $ini
            else
                if grep -E "\[$escapedSection\]" $ini > /dev/null
                then
                    # If section is found, adds key = value just after the begining of the section
                    sed -i -e "/\[$escapedSection\]/a $escapedKey=$escapedValue" $ini
                else
                    # If section not found, adds section, followed by key = value
                    echo -e "\n[$4]\n$key=$value" >> $ini
                fi
            fi
        # Key is in file
        else
            sed -i -e "s/[#; ]*$escapedKey\s*=.*/$escapedKey=$escapedValue/g" $ini
        fi
    done
}
function EcrireSys 
{
#if [ -d "$cle" ] || [ -d "$dure" ];then
#lancement son début
echo "argument1 = $1 "  > /dev/kmsg
	if [ -d "$dure" ];then
		if [ $1 = "radio" ]; then
			echo "type = radio" > /dev/kmsg
			echo -en '\xAA\x51\x00\x02\x03\x01\xFB' > /dev/ttymxc1  #radio 2 usb
			/navi_rw/utility/GestNav4/volume.sh
			/usr/bin/aplay $dure/son/startup.wav
			sleep 1
			echo -en '\xAA\x51\x00\x02\x00\x01\xF8' > /dev/ttymxc1  #usb 2 radio
			/navi_rw/utility/GestNav4/volume.sh
		else
			echo "type = autre" > /dev/kmsg
			/usr/bin/aplay $dure/son/startup.wav
		fi

	else
		if [ $1 = "radio" ]; then
			echo "type = radio" > /dev/kmsg
			echo -en '\xAA\x51\x00\x02\x03\x01\xFB' > /dev/ttymxc1  #radio 2 usb
			/navi_rw/utility/GestNav4/volume.sh
			/usr/bin/aplay $dir/GestNav4/Ne_Pas_Modifier/son/startup.wav
			sleep 1
			echo -en '\xAA\x51\x00\x02\x00\x01\xF8' > /dev/ttymxc1  #usb 2 radio
			/navi_rw/utility/GestNav4/volume.sh
		else
			echo "type = autre" > /dev/kmsg
			/usr/bin/aplay $dir/GestNav4/Ne_Pas_Modifier/son/startup.wav
		fi
	fi
#	sleep 2

	mount -o remount,rw /navi
#	mount -o remount,rw $clem	

	setIniKey $file has_secondary_root 0 folders
	setIniKey $file buildings $VBuilding folders
	setIniKey $file poi $VPOI folders
	setIniKey $file maps $VMap folders
	setIniKey $file image_maps $VImageMap gestnav4
	
	/bin/sync
	suivi_log "		= > OK"
	mount -o remount,ro /navi > /dev/kmsg
#	mount -o remount,ro $clem > /dev/kmsg

#lancement son fin installation.wav

	if [ -d "$dure" ];then
		if [ $1 = "radio" ]; then
			echo "type = radio" > /dev/kmsg
			echo -en '\xAA\x51\x00\x02\x03\x01\xFB' > /dev/ttymxc1  #radio 2 usb
			/navi_rw/utility/GestNav4/volume.sh
			/usr/bin/aplay $dure/son/installation.wav
			sleep 2
			echo -en '\xAA\x51\x00\x02\x00\x01\xF8' > /dev/ttymxc1  #usb 2 radio
			/navi_rw/utility/GestNav4/volume.sh
		else
			echo "type = autre" > /dev/kmsg
			/usr/bin/aplay $dure/son/installation.wav
		fi

	else
		if [ $1 = "radio" ]; then
			echo "type = radio" > /dev/kmsg
			echo -en '\xAA\x51\x00\x02\x03\x01\xFB' > /dev/ttymxc1  #radio 2 usb
			/navi_rw/utility/GestNav4/volume.sh
			/usr/bin/aplay $dir/GestNav4/Ne_Pas_Modifier/son/installation.wav
			sleep 2
			echo -en '\xAA\x51\x00\x02\x00\x01\xF8' > /dev/ttymxc1  #usb 2 radio
			/navi_rw/utility/GestNav4/volume.sh
		else
			echo "type = autre" > /dev/kmsg
			/usr/bin/aplay $dir/GestNav4/Ne_Pas_Modifier/son/installation.wav
		fi
	fi
	/navi_rw/utility/GestNav4/PopupFin.sh &
echo "*************--------*********** " > /dev/kmsg
		/bin/sync
#		/sbin/reboot -f
#fi
}


case $1 in
        "here")
			/navi_rw/utility/GestNav4/LancementPopup.sh "$Map_changer_Here" &
			VMap='"../../navi/content/map"'
			VBuilding='"../../navi/content/building"'
			VPOI='"../../navi/content/poi"'	
			VImageMap='0'
			EcrireSys $2
			
            ;;
        "tomtom")
			/navi_rw/utility/GestNav4/LancementPopup.sh "$Map_changer_Tomtom" &
			VMap='"../../navi/content/map_tomtom"'
			VBuilding='"../../navi/content/building_tomtom"'
			VPOI='"../../navi/content/poi_tomtom"'
			VImageMap='1'	
			EcrireSys $2
            ;;
		"usb_here")
			if [ -d "$cle" ] ;then
				/navi_rw/utility/GestNav4/LancementPopup.sh "$Map_changer_Here_usb" &
				VMap='"../..'$dir'/GestNav4/Installation_utilisateur/map_changer/map"'
				VBuilding='"../..'$dir'/GestNav4/Installation_utilisateur/map_changer/building"'
				VPOI='"../..'$dir'/GestNav4/Installation_utilisateur/map_changer/poi"'
				VImageMap='2'
				EcrireSys $2
			else
				/navi_rw/utility/GestNav4/LancementPopup.sh "$Map_changer_pas_de_cle" &
				sleep 6
				/navi_rw/utility/GestNav4/PopupFin.sh &
			fi
            ;;
		"usb_tomtom")
			if [ -d "$cle" ] ;then
				/navi_rw/utility/GestNav4/LancementPopup.sh "$Map_changer_Tomtom_usb" &
				VMap='"../..'$dir'/GestNav4/Installation_utilisateur/map_changer/map_tomtom"'
				VBuilding='"../..'$dir'/GestNav4/Installation_utilisateur/map_changer/building_tomtom"'
				VPOI='"../..'$dir'/GestNav4/Installation_utilisateur/map_changer/poi_tomtom"'
				VImageMap='3'
				EcrireSys $2
			else
				/navi_rw/utility/GestNav4/LancementPopup.sh "$Map_changer_pas_de_cle" &
				sleep 6
				/navi_rw/utility/GestNav4/PopupFin.sh &
			fi
            ;;
        *)
			echo "Oups argument 1 $1" > /dev/kmsg
            ;;
esac
echo "argument1 = $1 VImageMap = $VImageMap " > /dev/kmsg
echo "$file : " > /dev/kmsg
cat $file > /dev/kmsg
echo "***************************** " > /dev/kmsg
exit 0