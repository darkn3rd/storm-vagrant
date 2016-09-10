#!/usr/bin/env bash
SCRIPT_PATH="/vagrant/scripts"
SCRIPTLIB="${SCRIPT_PATH}/lib"
. ${SCRIPTLIB}/vagrant_driver.src

install_maven
install_storm
