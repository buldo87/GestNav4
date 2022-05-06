#!/bin/bash
volume=6
temp_volume=-1
for f in $(ls -t /log_emmc/*.dlt $1); do
    temp_volume=$(tac $1/$f | busybox strings | grep -a -m1 "profileID = AUDIO :value =" | sed 's/.*AUDIO \:value =\([0-9]\+\).*/\1/')
    if [[ $temp_volume =~ ^[0-9]+$ ]] && [ ! $temp_volume == -1 ]
    then
        volume=$temp_volume
        break
    else
        temp_volume=-1
    fi
done

dindon="aa 51 12 01 "$(printf '%02X' $volume)

IFS=' ' read -ra dindon <<< "$dindon"

checksum=0
command=""

for i in "${dindon[@]}"
do    
    hex=0x$i
    checksum=$((($checksum ^ $hex) & 0xff))
    command=$command$(printf '\\x%02X' $hex)
done

command=$command$(printf '\\x%02X' $checksum)
printf "$command" >> /dev/ttymxc1 