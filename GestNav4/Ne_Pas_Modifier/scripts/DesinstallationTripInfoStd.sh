#!/bin/bash
# GestNav4 Désinstallation ux trip_info STD
		echo "**********************" > /dev/kmsg
		echo "Supprimer ux trip_info STD" > /dev/kmsg
source /navi_rw/utility/GestNav4/SuiviLog.sh
source /navi_rw/utility/GestNav4/common.sh
source /navi_rw/utility/GestNav4/Traduction.sh
dure="/navi/utility/GestNav4/Ne_Pas_Modifier"
suivi_log "Supprimer ux trip_info STD"

inifile=/navi_rw/save/system_A.ini
inifile2=/navi_rw/save/system_B.ini
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

# on vérifie que le chemin est valide
f="$dir/GestNav4"

if [ -d "$dir/GestNav4" ] || [ -d "$dure" ];then
/navi_rw/utility/GestNav4/LancementPopup.sh "$Desinstallation_TripInfoStd" &
#lancement son début
	EnvoiSon startup.wav $1 1         #son, type media, durée en seconde
	sleep 2
	mount -o remount,rw /navi
	mount -o remount,rw $clem
	/bin/sync

		rm -rfv /navi/ux/__tripinfo.zip > /dev/kmsg
		chown 1004:1004 /navi/ux/*
		chmod -R 644 /navi/ux/*
		setIniKey $inifile tripinfovisible 0 lua
		setIniKey $inifile2 tripinfovisible 0 lua
		rm /navi_rw/save/system_a*
		rm /navi_rw/save/system_b*
				
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