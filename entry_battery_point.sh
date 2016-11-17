#!/bin/sh
nohup /home/posten/bat.sh > battery_mon.log 2>&1 & echo $! > batmon.pid
exit 143
