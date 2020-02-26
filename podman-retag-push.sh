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
    panic  "Usage: $0 Registry URL"
fi

REGISTRY=$1

images=$(podman image ls --format "{{.Repository}}:{{.Tag}}" | awk '{if(NR>1) print $NF}')

for img in $images
do
    src=${img}
    dst=${REGISTRY}/${img#*/}
    echo "retag and push $dst"

    podman tag ${src} ${dst}
    podman push ${dst}
done
