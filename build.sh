#! /bin/bash

THIS_SCRIPT_DIR=$(dirname $(readlink -e ${BASH_SOURCE[0]}))
pushd $THIS_SCRIPT_DIR

vagrant destroy --force || true
vagrant up
# Based on https://scotch.io/tutorials/how-to-create-a-vagrant-base-box-from-an-existing-one
vagrant ssh -- 'sudo time dd if=/dev/zero of=/EMPTY bs=1M ; sudo rm -f /EMPTY'
vagrant ssh -- 'sudo poweroff'
sleep 10
vagrant package --output alpine-docker-compose-$(date +%Y%m%d_%H%M%S).box

popd
