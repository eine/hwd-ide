#!/bin/sh

cd $(dirname $0)

  echo "> run all"

for d in default map_32bit twofuncs dummy; do
  echo ""
  echo ">> $d"
  cd "$d"
  ../runme.sh
  cd ..
done
