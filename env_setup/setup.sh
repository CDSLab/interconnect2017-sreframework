#!/bin/bash

. ./variables.sh
. ./remove_containers.sh

echo "\n\n\n*********** INITIATING SETUP **************";


create_nginx_default_conf(){
cat > default.conf << EOF
"upstream backend {
  server "$APACHE_1_IP";
  server "$APACHE_2_IP" backup;
}
server {
  listen 80;
  location / {
    proxy_pass http://backend;
  }
}"
EOF
}


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
then  echo "Apache containers started successfully."
else
  echo "Killing the existing containers and trying again..."
  remove_containers
  echo "Starting the Apache containers again..."
  docker run -d --name $APACHE_1 $APACHE_IMAGE >>$LOG_FILE 2>&1;
  docker run -d --name $APACHE_2 $APACHE_IMAGE >>$LOG_FILE 2>&1;
  echo "Apache containers started successfully."
fi

echo "\nSetting up the NginX Load Balancer..."

APACHE_1_IP=$(docker inspect --format '{{ .NetworkSettings.IPAddress }}' $APACHE_1)
APACHE_2_IP=$(docker inspect --format '{{ .NetworkSettings.IPAddress }}' $APACHE_2)

if docker run -d -p 80:80 --name $NGINX $NGINX_IMAGE >>$LOG_FILE 2>&1 &&
   create_nginx_default_conf &&
   docker cp default.conf $NGINX:/etc/nginx/conf.d/default.conf >>$LOG_FILE 2>&1 &&
   docker restart $NGINX >>$LOG_FILE 2>&1
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

echo "\n*********** SETUP COMPLETED **************"

echo "\nApp:  http://localhost"
echo "CAdvisor: http://localhost:8081\n\n\n"

exit 0
