#!/bin/bash
# loading_finished 
source /navi_rw/utility/GestNav4/SuiviLog.sh
source /navi_rw/utility/GestNav4/common.sh
source /navi_rw/utility/GestNav4/Traduction.sh

echo " -------------- loading_finished.sh --------------------- " > /dev/kmsg
#dbus-send --system --print-reply --type=method_call --dest=com.lge.AppManager /com/lge/AppManager com.lge.AppManager.launchApps string:'{"appId": "com.lge.bavn.navi", "extra": "SYSTONAVI_MAP_SCREEN", "windowType": "NORMAL", "visible": true}'
dbus-send --system --print-reply --type=method_call --dest=com.lge.AppManager /com/lge/AppManager com.lge.AppManager.launchApps string:'{"appId":"com.lge.bavn.navi","extra":"SYSTONAVI_NAVI_TAB","requester":"com.lge.bavn.homescreen","visible":true,"windowType":"NORMAL"}'
exit 0
