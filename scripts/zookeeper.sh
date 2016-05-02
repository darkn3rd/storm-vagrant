#!/bin/sh
SCRIPT_PATH="/vagrant/scripts"
. ${SCRIPT_PATH}/provisionlib.src
install_zookeper
create_user storm
