#!/bin/sh

if [ ! -z "$*" ]; then
    pxt $*
else
    pxt serve -h 0.0.0.0 -p ${PORT} --noBrowser --rebundle
fi
