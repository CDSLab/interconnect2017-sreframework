#!/bin/bash

. ./variables.sh


create_nginx_default_conf(){
cat > default.conf << EOF
upstream backend {
  server "$APACHE_1_IP";
  server "$APACHE_2_IP" backup;
}
server {
  listen 80;
  location / {
    proxy_pass http://backend;
  }
}
EOF
}
