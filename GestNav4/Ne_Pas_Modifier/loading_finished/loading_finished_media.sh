#!/bin/bash
# loading_finished démarrage sur media
source /navi_rw/utility/GestNav4/SuiviLog.sh
source /navi_rw/utility/GestNav4/common.sh
source /navi_rw/utility/GestNav4/Traduction.sh

echo " -------------- loading_finished.sh --------------------- " > /dev/kmsg
dbus-send --system --print-reply --type=method_call --dest=com.lge.AppManager /com/lge/AppManager com.lge.AppManager.launchApps string:'{"appId": "com.lge.bavn.appmediaplayer", "windowType": "NORMAL", "visible": true}'
exit 0


