#! /bin/sh

set -e

echo "$DOCKER_PASS" | docker login -u "$DOCKER_USER" --password-stdin
for tag in `echo $(docker images ghdl/ext:ide* | awk -F ' ' '{print $1 ":" $2}') | cut -d ' ' -f2-`; do
    if [ "$tag" = "REPOSITORY:TAG" ]; then break; fi
    printf "[DOCKER push] ${tag}\n"
    docker push $tag
done
docker logout
