#!/bin/sh

cd /makecode/pxt-microbit

if [ ! -z "$*" ]; then
    pxt $*
else
    pxt serve -h 0.0.0.0 -p 80 --noBrowser
fi
