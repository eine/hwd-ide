#!/bin/sh

mkdir -pv outputs

echo "$0"
echo "$(dirname $0)"
echo "$(dirname $0)/.."
echo "$(cd `dirname $0`/..; pwd)"

for e in $(pwd)/examples/*; do
  printf "\n$e\n"
  p="outputs/$(basename $e)/ghdl"
  mkdir -pv "$p"
  v_src="/$(cd `dirname $0`/..; pwd)/examples/$(basename $e)://src"
  v_wrk="/$(pwd)/$p://work"
  echo "v_src $v_src"
  echo "v_wrk $v_wrk"
  docker run --rm -t \
             -v "$v_src" \
             -v "$v_wrk" \
             -w "//work" \
             ghdl/ghdl:stretch-mcode \
             bash -c "//src/test.sh"
done

mkdir -pv release
tar -zcvf "release/outputs.tgz" outputs
