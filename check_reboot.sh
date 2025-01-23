#!/bin/bash

echo "Resetting ulimit -c 0"
ulimit -c 0

echo "Resetting coredump pattern to apport"
sysctl -w kernel.core_pattern="|/usr/share/apport/apport -p%p -s%s -c%c -d%d -P%P -u%u -g%g -- %E"

dsouzai@ub-cascadelake-2s32c-03:~/OL-24.0.0.6/mpirvu/AcmeAir$ cat ~/check_reboot.sh
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
