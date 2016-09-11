#!/usr/bin/env bash
SCRIPT_PATH="/vagrant/scripts"
SCRIPTLIB="${SCRIPT_PATH}/lib"
. ${SCRIPTLIB}/vagrant_driver.src

${SCRIPT_PATH}/setup-base.sh     # setup ssh_config, hosts
setup_zookeeper                  # install/config zookeeper

STORM_VERSION=${1-"1.0.2"}
setup_proxy
