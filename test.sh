#!/bin/sh

set -e

cd "$(dirname $0)"

mkdir -pv outputs

docker run --rm -t \
  -v "/$(pwd)/examples/full_adder://src" \
  -v "/$(pwd)/outputs://work" \
  -w "//work" \
  ghdl/ghdl:buster-mcode \
  bash -c "//src/test.sh"
