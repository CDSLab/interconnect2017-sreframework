#!/bin/bash

. ./variables.sh
. ./remove_containers.sh
. ./default_conf.sh
echo "\n\n\nTime: $(date)\n\n\n" >>$LOG_FILE
echo "\n\n\n*********** INITIATING SETUP **************";

echo "\n>> Pulling the required docker images... " | tee -a $LOG_FILE

if docker pull $APACHE_IMAGE >>$LOG_FILE 2>&1 &&
   docker pull $NGINX_IMAGE >>$LOG_FILE 2>&1 &&
   docker pull $CADVISOR_IMAGE >>$LOG_FILE 2>&1
then
  echo ">> Docker images pulled." | tee -a $LOG_FILE
else
  echo ">> Error pulling the docker images. Check logs at '$LOG_FILE'." | tee -a $LOG_FILE;
  exit 1;
fi

# Start the app containers
echo "\n>> Starting the Apache containers..." | tee -a $LOG_FILE
if docker run -d --name $APACHE_1 $APACHE_IMAGE >>$LOG_FILE 2>&1 &&
   docker run -d --name $APACHE_2 $APACHE_IMAGE >>$LOG_FILE 2>&1
then  echo "Apache containers started successfully." | tee -a $LOG_FILE
else
  echo ">> Killing the existing containers and trying again..." | tee -a $LOG_FILE
  remove_containers
  echo ">> Starting the Apache containers again..." | tee -a $LOG_FILE
  docker run -d --name $APACHE_1 $APACHE_IMAGE >>$LOG_FILE 2>&1;
  docker run -d --name $APACHE_2 $APACHE_IMAGE >>$LOG_FILE 2>&1;
  echo ">> Apache containers started successfully." | tee -a $LOG_FILE
fi

echo "\n>> Setting up the NginX Load Balancer..." | tee -a $LOG_FILE

APACHE_1_IP=$(docker inspect --format '{{ .NetworkSettings.IPAddress }}' $APACHE_1)
APACHE_2_IP=$(docker inspect --format '{{ .NetworkSettings.IPAddress }}' $APACHE_2)

if docker run -d -p 80:80 --name $NGINX $NGINX_IMAGE >>$LOG_FILE 2>&1
then
  create_nginx_default_conf;
  docker cp default.conf $NGINX:/etc/nginx/conf.d/default.conf >>$LOG_FILE 2>&1;
  docker restart $NGINX >>$LOG_FILE 2>&1;
  # rm default.conf;
  echo ">> Load Balancer setup completed." | tee -a $LOG_FILE;
else
  echo ">> Error setting up the Load Balancer. Check logs at '$LOG_FILE'." | tee -a $LOG_FILE;
  exit 1;
fi

echo "\n>> Setting up CAdvisor to monitor the containers..." | tee -a $LOG_FILE

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
  echo ">> CAdvisor set up successfully." | tee -a $LOG_FILE
else
  echo ">> Error setting up CAdvisor. Check logs at '$LOG_FILE'." | tee -a $LOG_FILE;
  exit 1;
fi

echo "\n*********** SETUP COMPLETED **************"

echo "\nApp:  http://localhost"
echo "CAdvisor: http://localhost:8081\n\n\n"

exit 0
