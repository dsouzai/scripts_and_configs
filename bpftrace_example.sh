#!/bin/sh

YOURPID=$1

sudo bpftrace -e 'tracepoint:syscalls:sys_enter_sched_setaffinity /args->pid=='"$YOURPID"' || (args->pid==0 && pid=='"$YOURPID"')/ { printf("sched_setaffinity on %d from %d (%s)\n", args->pid, pid, comm); }'
