#!/bin/sh

set -e

for k in "force_color" "alias"; do
  sed -i.bak "s/#$k/$k/g" /etc/skel/.bashrc
done
rm /etc/skel/.bashrc.bak

source /etc/skel/.bashrc

# TODO fancy variant
# PS1='${debian_chroot:+($debian_chroot)}\[\033[01;36m\][\[\033[01;35m\]\u\[\033[01;36m\]@\[\033[01;34m\]\h\[\033[00m\] \[\033[00m\]\w\[\033[01;36m\]]\[\033[00m\]$ '

# TODO Add the following line to /root/.bashrc, in order to show a red prompt (not fancy, yet)
# PS1='${debian_chroot:+($debian_chroot)}\[\033[01;31m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]$ '

set +e

#PS1='\[\e[1;32m\][\u@\h \W]\$\[\e[0m\] '

# TODO gtk theme and icon theme

# TODO Check usage of DEBIAN_FRONTEND=noninteractive
# See https://github.com/moby/moby/issues/4032

# FIX Terminator must be started as `terminator -u`
# See https://bugs.launchpad.net/terminator/+bug/1763638
#
# terminator -u -x bash

#---

# echo "PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '" > /etc/profile.d/colorprompt.sh
# https://wiki.debian.org/BashColors
# https://wiki.archlinux.org/index.php/Bash/Prompt_customization
