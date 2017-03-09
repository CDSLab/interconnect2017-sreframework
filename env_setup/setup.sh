#!/bin/bash

APACHE_IMAGE="nimmis/alpine-apache"
NGINX_IMAGE="smebberson/alpine-nginx"
CADVISOR_IMAGE="google/cadvisor"
LOG_FILE="/tmp/setup.log"
APACHE_1="app1"
APACHE_2="app2"
NGINX="loadbalancer"
CADVISOR="cadvisor"

echo "\n\n\n*********** INITIATING SETUP **************";

echo "\nPulling the required docker images... "

if docker pull $APACHE_IMAGE >>$LOG_FILE 2>&1 &&
   docker pull $NGINX_IMAGE >>$LOG_FILE 2>&1 &&
   docker pull $CADVISOR_IMAGE >>$LOG_FILE 2>&1
then 
  echo "Docker images pulled."
else 
  echo "Error pulling the docker images. Check logs at '$LOG_FILE'.";
  exit 1;
fi

# Start the app containers
echo "\nStarting the Apache containers..."
if docker run -d --name $APACHE_1 $APACHE_IMAGE >>$LOG_FILE 2>&1 &&
   docker run -d --name $APACHE_2 $APACHE_IMAGE >>$LOG_FILE 2>&1
then  echo "\nApache containers started successfully."
else
  echo "Killing the existing containers and trying again..."
  docker rm -f $(docker ps -aq) >>$LOG_FILE 2>&1;
  echo "Starting the Apache containers again..."
  docker run -d --name $APACHE_1 $APACHE_IMAGE >>$LOG_FILE 2>&1;
  docker run -d --name $APACHE_2 $APACHE_IMAGE >>$LOG_FILE 2>&1;
  echo "Apache containers started successfully."
fi

echo "\nSetting up the NginX Load Balancer..."

APACHE_1_IP=$(docker inspect --format '{{ .NetworkSettings.IPAddress }}' $APACHE_1)
# echo $APACHE_1_I

APACHE_2_IP=$(docker inspect --format '{{ .NetworkSettings.IPAddress }}' $APACHE_2)
# echo $APACHE_2_IP

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

docker run -d -p 80:80 --name $NGINX $NGINX_IMAGE >>$LOG_FILE 2>&1
docker cp default.conf $NGINX:/etc/nginx/conf.d/default.conf >>$LOG_FILE 2>&1

if docker restart $NGINX >>$LOG_FILE 2>&1
then 
  rm default.conf;
  echo "Load Balancer setup completed.";
else 
  echo "Error setting up the Load Balancer. Check logs at '$LOG_FILE'.";
  exit 1;
fi

echo "\nSetting up CAdvisor to monitor the containers..."

if docker run \
  --volume=/:/rootfs:ro \
  --volume=/var/run:/var/run:rw \
  --volume=/sys:/sys:ro \
  --volume=/var/lib/docker/:/var/lib/docker:ro \
  --publish=8081:8080 \
  --detach=true \
  --name=$CADVISOR \
  $CADVISOR_IMAGE >>$LOG_FILE 2>&1
then
  echo "CAdvisor set up successfully."
else
  echo "Error setting up CAdvisor. Check logs at '$LOG_FILE'.";
  exit 1;
fi

echo "\n*********** SETUP COMPLETED **************";

echo "\nApp:  http://localhost"
echo "CAdvisor: http://localhost:8081\n\n\n"


exit 0;



