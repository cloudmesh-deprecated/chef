#!/bin/bash

NOVA="api compute network"

case "$1" in
start|restart|status)
        for i in $NOVA; do
                /sbin/$1 nova-$i
        done
        ;;
stop)
        for i in $NOVA; do
                /sbin/stop nova-$i
        done
        ;;
esac
exit 0
