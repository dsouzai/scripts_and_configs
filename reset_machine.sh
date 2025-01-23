#!/bin/bash

echo "Resetting ulimit -c 0"
ulimit -c 0

echo "Resetting coredump pattern to apport"
sysctl -w kernel.core_pattern="|/usr/share/apport/apport -p%p -s%s -c%c -d%d -P%P -u%u -g%g -- %E"

