#!/bin/sh
SCRIPT_PATH="/vagrant/scripts"
SCRIPTLIB="${SCRIPT_PATH}/lib"
. ${SCRIPTLIB}/zookeeper.src
install_zookeper
create_user storm
