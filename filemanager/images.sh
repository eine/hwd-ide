#! /bin/sh

set -e

cd "$(dirname $0)"

for tag in `sed -e 's/FROM.*AS //;tx;d;:x' Dockerfile`; do
    printf "[DOCKER build] ${tag}\n"
    docker build -t "ghdl/ext:$tag" --target "$tag" .
done
