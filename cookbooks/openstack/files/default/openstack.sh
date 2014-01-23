#!/bin/bash

NOVA="conductor compute network scheduler cert consoleauth novncproxy api"
GLANCE="registry api"
CINDER="scheduler api"

case "$1" in
start|restart|status)
        /sbin/$1 keystone
        for i in $GLANCE; do
                /sbin/$1 glance-$i
        done
        for i in $NOVA; do
                /sbin/$1 nova-$i
        done
        for i in $CINDER; do
                /sbin/$1 cinder-$i
        done
        ;;
stop)
        for i in $NOVA; do
                /sbin/stop nova-$i
        done
        for i in $GLANCE; do
                /sbin/stop glance-$i
        done
        for i in $CINDER; do
                /sbin/stop cinder-$i
        done
        /sbin/stop keystone
        ;;
esac
exit 0
