#!/bin/sh
SCRIPT_PATH="/vagrant/scripts/"
. ${SCRIPT_PATH}/lib/nginx.src

install_nginx
remove_site 'default'
enable_site 80 "http://192.168.54.4:8080" 'storm.dev' 'nimbus.dev'
enable_site 8000 "http://192.168.54.5:8000" 'supervisor1.dev'
enable_site 8000 "http://192.168.54.6:8000" 'supervisor2.dev'
