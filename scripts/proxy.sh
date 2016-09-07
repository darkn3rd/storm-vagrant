#!/bin/sh
SCRIPT_PATH="/vagrant/scripts/"

export DEBIAN_FRONTEND=noninteractive
add-apt-repository ppa:nginx/stable
apt-get -qq update && apt-get -y install nginx

# config_ngix_site(upstream, server_names)
#
# each list does lookup of
# server_name $@
# get_ipaddress $1

cat <<-'STORMUI_CONF' > /etc/nginx/sites-available/storm
server {
  server_name storm.dev nimbus.dev;
  location / {
    proxy_pass http://192.168.54.4:8080;
  }
}

server {
  listen 8000;
  server_name supervisor1.dev;
  location / {
    proxy_pass http://192.168.54.5:8000;
  }
}

server {
  listen 8000;
  server_name supervisor2.dev;
  location / {
    proxy_pass http://192.168.54.6:8000;
  }
}

STORMUI_CONF

ln -s /etc/nginx/sites-available/storm storm

# if service nginx configtest

sudo service nginx reload
