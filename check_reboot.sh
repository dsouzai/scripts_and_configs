#!/bin/bash

user_date=$(last --time-format=iso $USER | head -2 | tail -1 | perl -pe 's/.*(\d\d\d\d-\d\d-\d\dT\d\d:\d\d:\d\d).*/$1/g')
reboot_date=$(last --time-format=iso reboot | head -1 | perl -pe 's/.*(\d\d\d\d-\d\d-\d\dT\d\d:\d\d:\d\d).*/$1/g')

epoch_user=$(date -d "${user_date}" +"%s")
epoch_reboot=$(date -d "${reboot_date}" +"%s")

if [ "$epoch_user" -lt "$epoch_reboot" ]; then
  echo "############################################################"
  echo "#                                                          #"
  echo "#                                                          #"
  echo "#           SYSTEM REBOOTED SINCE LAST LOGIN               #"
  echo "#                                                          #"
  echo "#                                                          #"
  echo "############################################################"
fi
