#!/bin/sh

set -e

cd "$(dirname $0)"

#--

mkdir -pv outputs

for e in full_adder pid; do
  p="outputs/${e}/ghdl"
  mkdir -pv "$p"
  docker run --rm -t \
    -v "/$(pwd)/examples/tutorials/$e://src" \
    -v "/$(pwd)/$p://work" \
    -w "//work" \
    ghdl/ghdl:buster-mcode \
    bash -c "//src/test.sh"
done

mkdir -pv release
tar -zcvf "release/outputs.tgz" outputs
