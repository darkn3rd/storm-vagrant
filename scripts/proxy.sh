#!/bin/sh

# Configure Local Vagrant Paths
CONFIGFILE=${VAGRANT_CONFIG:-"/vagrant/config/default.hosts"}
SCRIPT_PATH="/vagrant/scripts"
SCRIPTLIB="${SCRIPT_PATH}/lib"

# Import Libraries
. ${SCRIPTLIB}/nginx.src  # install_nginx(), remote_site(), enable_site()
. ${SCRIPTLIB}/base.src   # get_ipaddress()

# Install nginx from vendor PPA
install_nginx

# Remove Default Site
remove_site 'default'

# Create Sites based on Configuration (e.g. config/default.hosts)
create_site 80 "http://$(get_ipaddress ${CONFIGFILE} nimbus.dev):8080" 'storm.dev' 'nimbus.dev'
create_site 8000 "http://$(get_ipaddress ${CONFIGFILE} supervisor1.dev):8000" 'supervisor1.dev'
create_site 8000 "http://$(get_ipaddress ${CONFIGFILE} supervisor2.dev):8000" 'supervisor2.dev'

# Enable newly created sites
enable_site nimbus.dev
enable_site supervisor1.dev
enable_site supervisor2.dev
