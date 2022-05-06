#!/bin/bash
# PopupFin

dbus-send --system --print-reply --type=method_call --dest=com.lge.PopupManager /com/lge/PopupManager com.lge.PopupManager.Service.DestroyPopup int32:7000000
