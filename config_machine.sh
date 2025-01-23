#!/bin/bash

profile="balanced"

echo "Setting tuned-adm profile to $profile"
tuned-adm profile $profile

echo "Verifying profile"
tuned-adm verify

echo "Setting scaling_governer to performance"
echo performance | sudo tee /sys/devices/system/cpu/cpu*/cpufreq/scaling_governor

echo "Setting ulimit -c unlimited"
ulimit -c unlimited

echo "Setting coredump pattern to core.%p"
sysctl -w kernel.core_pattern=core.%p

echo "Stopping numad.service"
systemctl stop numad.service

echo "Setting 0 to kptr_restrict"
echo 0 > /proc/sys/kernel/kptr_restrict
