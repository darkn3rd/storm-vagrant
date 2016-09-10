#!/usr/bin/env bash
SCRIPT_PATH="/vagrant/scripts"
SCRIPTLIB="${SCRIPT_PATH}/lib"
. ${SCRIPTLIB}/zookeeper.src

${SCRIPT_PATH}/setup-base.sh     # setup ssh_config, hosts
install_zookeper
create_user storm
