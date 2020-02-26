#!/bin/bash

DATE=$(date +%Y-%m-%d-%H:%M:%S)

function log(){
    echo "$DATE INFO $@"
    return 0
}

function panic(){
    echo "$DATE ERROR $@"
    exit 1
}

if [ $# -lt 1 ]; then
    panic  "Usage: $0 <image dir>"
fi

IMGDIR=$1

find $IMGDIR -type f -not -path '*/\.*' -name '*.tar' -exec podman load -i {} \;
