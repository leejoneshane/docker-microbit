#!/bin/sh

if [ ! -z "$*" ]; then
    pxt $*
else
    pxt serve -h 0.0.0.0 -p 80 --rebundle
fi
