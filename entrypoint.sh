#!/bin/sh

if [ ! -z "$*" ]; then
    pxt $*
else
    pxt serve -noBrowser --rebundle
fi