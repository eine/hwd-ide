#!/bin/sh

set -e

cd "$(dirname $0)"

#---

enable_color() {
  ENABLECOLOR='-c '
  ANSI_RED="\033[31m"
  ANSI_GREEN="\033[32m"
  ANSI_YELLOW="\033[33m"
  ANSI_BLUE="\033[34m"
  ANSI_MAGENTA="\033[35m"
  ANSI_CYAN="\033[36;1m"
  ANSI_DARKCYAN="\033[36m"
  ANSI_NOCOLOR="\033[0m"
}

disable_color() { unset ENABLECOLOR ANSI_RED ANSI_GREEN ANSI_YELLOW ANSI_BLUE ANSI_MAGENTA ANSI_CYAN ANSI_DARKCYAN ANSI_NOCOLOR; }

enable_color

#---

[ -n "$TRAVIS" ] && {
  # This is a trimmed down copy of
  # https://github.com/travis-ci/travis-build/blob/master/lib/travis/build/templates/header.sh
  travis_time_start() {
    # `date +%N` returns the date in nanoseconds. It is used as a replacement for $RANDOM, which is only available in bash.
    travis_timer_id=`date +%N`
    travis_start_time=$(travis_nanoseconds)
    echo "travis_time:start:$travis_timer_id"
  }
  travis_time_finish() {
    travis_end_time=$(travis_nanoseconds)
    local duration=$(($travis_end_time-$travis_start_time))
    echo "travis_time:end:$travis_timer_id:start=$travis_start_time,finish=$travis_end_time,duration=$duration"
  }

  if [ "$TRAVIS_OS_NAME" = "osx" ]; then
    travis_nanoseconds() {
      date -u '+%s000000000'
    }
  else
    travis_nanoseconds() {
      date -u '+%s%N'
    }
  fi
}

#--

getDockerCredentialPass () {
  PASS_URL="$(curl -s https://api.github.com/repos/docker/docker-credential-helpers/releases/latest | grep "browser_download_url.*pass-.*-amd64" | sed 's/.* "\(.*\)"/\1/g')"
  [ "$(echo "$PASS_URL" | cut -c1-5)" != "https" ] && { PASS_URL="https://github.com/docker/docker-credential-helpers/releases/download/v0.6.0/docker-credential-pass-v0.6.0-amd64.tar.gz"; }
  echo "PASS_URL: $PASS_URL"
  curl -fsSL "$PASS_URL" | tar xv
  chmod + $(pwd)/docker-credential-pass
}

#---

dockerLogin () {
  if [ "$CI" = "true" ]; then
    gpg --batch --gen-key <<-EOF
%echo Generating a standard key
Key-Type: DSA
Key-Length: 1024
Subkey-Type: ELG-E
Subkey-Length: 1024
Name-Real: Meshuggah Rocks
Name-Email: meshuggah@example.com
Expire-Date: 0
# Do a commit here, so that we can later print "done" :-)
%commit
%echo done
EOF

    key=$(gpg --no-auto-check-trustdb --list-secret-keys | grep ^sec | cut -d/ -f2 | cut -d" " -f1)
    pass init $key

    echo "$DOCKER_PASS" | docker login -u "$DOCKER_USER" --password-stdin
  fi
}

#---

images () {
  cd filebrowser
  for tag in `sed -e 's/FROM.*AS //;tx;d;:x' Dockerfile`; do
    printf "[DOCKER build] ${tag}\n"
    docker build -t "ghdl/ext:$tag" --target "$tag" .
  done
  cd ..
}

deploy () {
  getDockerCredentialPass
  dockerLogin
  for tag in `echo $(docker images ghdl/ext:* | awk -F ' ' '{print $1 ":" $2}') | cut -d ' ' -f2-`; do
    if [ "$tag" = "REPOSITORY:TAG" ]; then break; fi
    printf "[DOCKER push] ${tag}\n"
    docker push $tag
  done
  docker logout
}

test () {
  mkdir -pv outputs

  for e in $(pwd)/examples/*; do
    printf "\n$e\n"
    p="outputs/$(basename $e)/ghdl"
    mkdir -pv "$p"
    docker run --rm -t \
               -v "/$(pwd)/examples/$(basename $e)://src" \
               -v "/$(pwd)/$p://work" \
               -w "//work" \
               ghdl/ghdl:stretch-mcode \
               bash -c "//src/test.sh"
  done

  mkdir -pv release
  tar -zcvf "release/outputs.tgz" outputs
}

#---

case "$1" in
  "-t")
    test
  ;;
  "-i")
    images
  ;;
  "-d")
    deploy
  ;;
  *)
    echo "Unknown arg <$1>"
  ;;
esac
