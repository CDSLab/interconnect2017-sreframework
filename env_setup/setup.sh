#!/bin/bash

APACHE_IMAGE="nimmis/alpine-apache"
NGINX_IMAGE="smebberson/alpine-nginx"
CADVISOR_IMAGE="google/cadvisor"
LOG_FILE="setup.log"
APACHE_1="app1"
APACHE_2="app2"
NGINX="loadbalancer"

echo "\nPulling the required docker images... "

if docker pull $APACHE_IMAGE >>$LOG_FILE 2>&1 &&
   docker pull $NGINX_IMAGE >>$LOG_FILE 2>&1 &&
   docker pull $CADVISOR_IMAGE >>$LOG_FILE 2>&1
then  echo "\nDocker images pulled."
else echo "\nError pulling the docker images. Check logs."
fi

# Start the app containers
echo "\nStarting the Apache containers..."
if docker run -d --name $APACHE_1 -p 8081:80 $APACHE_IMAGE >>$LOG_FILE 2>&1 &&
   docker run -d --name $APACHE_2 -p 8082:80 $APACHE_IMAGE >>$LOG_FILE 2>&1
then  echo "\nApache containers started successfully."
else
  echo "\nKilling the existing containers and trying again..."
  docker rm -f $APACHE_1 >>$LOG_FILE 2>&1;
  docker rm -f $APACHE_2 >>$LOG_FILE 2>&1;
  echo "\nStarting the Apache containers again..."
  docker run -d --name $APACHE_1 -p 8081:80 $APACHE_IMAGE >>$LOG_FILE 2>&1;
  docker run -d --name $APACHE_2 -p 8082:80 $APACHE_IMAGE >>$LOG_FILE 2>&1;
  echo "\nApache containers started successfully."
fi

echo "\nSetting up the NginX Load Balancer..."

APACHE_1_IP=$(docker inspect --format '{{ .NetworkSettings.IPAddress }}' $APACHE_1)
# echo $APACHE_1_IP

APACHE_2_IP=$(docker inspect --format '{{ .NetworkSettings.IPAddress }}' $APACHE_2)
# echo $APACHE_2_IP

cat > default.conf <<- "EOF"
upstream backend {
  server $APACHE_1_IP;
  server $APACHE_2_IP backup;
}
server {
  listen 80;
  location / {
    proxy_pass http://backend;
  }
}
EOF

docker run -d -p 80:80 --name $NGINX $NGINX_IMAGE >>$LOG_FILE 2>&1
docker cp default.conf $NGINX:/etc/nginx/conf.d/default.conf >>$LOG_FILE 2>&1

if docker restart $NGINX >>$LOG_FILE 2>&1
then echo "Load Balancer setup completed."
else echo "Error setting up the Load Balancer. Check logs."
fi
