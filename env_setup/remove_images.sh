#!/bin/bash

. ./variables.sh

remove_images()
{
echo "\n\n\nRemvoving the images..."
if docker rmi $APACHE_IMAGE >>$LOG_FILE 2>&1 &&
   docker rmi $NGINX_IMAGE >>$LOG_FILE 2>&1 &&
   docker rmi $CADVISOR_IMAGE >>$LOG_FILE 2>&1
then
  echo "Images removed successfully."
else
  echo "Error removing the images. Check logs at '$LOG_FILE'";
  exit 1;
fi
}
