#!/usr/bin/env bash
# NAME: setup-base.sh
# AUTHOR: Joaquin Menchaca
# CREATED: 2015-11-23
# UPDATED:
#   * 2016-09-07 adopted by storm-vagrant project
#
# PURPOSE: Configures `/etc/hosts` and global ssh configuration for each
#  password-less system to system communication through ssh.
# DEPENDENCIES:
#  * base.src
# NOTES:
#  * This script will be run on the guest operating system

##### Variables
CONFIGFILE=${VAGRANT_CONFIG:-"/vagrant/config/default.hosts"}
SCRIPT_PATH="/vagrant/scripts"
SCRIPTLIB="${SCRIPT_PATH}/lib"

##### Verify Configuration Exists
[ -e ${CONFIGFILE} ] || \
  { echo "ERROR: ${CONFIGFILE} doesn't exist. Exiting"; exit 1; }

##### Source Base Library
#[ "${0:0:1}" = "/" ] && SCRIPTDIR="${0%/*}" || SCRIPTDIR="${PWD}/${0%/*}"
. ${SCRIPTLIB}/base.src

##### Setup /etc/ssh_config and /etc/hosts
config_ssh ${CONFIGFILE}
config_hosts ${CONFIGFILE}
install_utilities # install 'tree' 'curl' 'unzip' 'vim'
