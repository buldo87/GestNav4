#!/bin/bash
# lancement popup
source /navi_rw/utility/GestNav4/Traduction.sh
sleep 2
pop=${1// /\\u0020}
Merci_de_patienter=${Merci_de_patienter// /\\u0020}
dbus-send --system --print-reply --type=method_call --dest=com.lge.PopupManager /com/lge/PopupManager com.lge.PopupManager.Service.CreatePopup string:'{"type":"CONFIRM","data":{"title":"GestNav4","text1":"'$pop'","text2":"'$Merci_de_patienter'","textCount":"2","timer":"0"}}'
dbus-send --system --print-reply --type=method_call --dest=com.lge.PopupManager /com/lge/PopupManager com.lge.PopupManager.Service.ShowPopup int32:7000000
