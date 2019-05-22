#!/bin/sh

cd /makecode/pxt-microbit

if [ ! -z "$*" ]; then
    /makecode/pxt/pxt-cli/pxt $*
else
    /makecode/pxt/pxt-cli/pxt serve -h 0.0.0.0 -p 80 --noBrowser
fi
