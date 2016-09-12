#!/usr/bin/env bash
SCRIPT_PATH="/vagrant/scripts"
SCRIPTLIB="${SCRIPT_PATH}/lib"
. ${SCRIPTLIB}/vagrant_driver.src

STORM_VERSION=${1-"1.0.2"}
MAVEN_VERSION="3.3.9"

${SCRIPT_PATH}/setup-base.sh              # setup ssh_config, hosts
setup_storm ${STORM_VERSION} # install nimbus, ui
setup_maven ${MAVEN_VERSION} # optionally install maven

# Install Node if NODE_VERSION specified
if [ ! -z ${NODE_VERSION} ]; then
  . ${SCRIPTLIB}/node.src
  install_nodejs ${NODE_VERSION}
fi
