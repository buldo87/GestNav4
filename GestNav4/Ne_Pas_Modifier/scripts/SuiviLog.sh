#!/bin/bash
version_gestnav=$(cat /navi_rw/utility/GestNav4/ZGestNav4_version.txt )
fichier_log="/rw_data/log_Gestnav.txt"
function suivi_log
{
	tail -n 500 /rw_data/log_Gestnav.txt > /rw_data/file.tmp && mv /rw_data/file.tmp /rw_data/log_Gestnav.txt
	echo -e "$version_gestnav [`date +%d-%m-%Y_%H:%M:%S`] $1" >> "$fichier_log"
}