#!/bin/bash

. ./variables.sh

remove_images()
{
echo "\n\n\n>> Remvoving the images..." | tee -a $LOG_FILE
if docker rmi $APACHE_IMAGE >>$LOG_FILE 2>&1 &&
   docker rmi $NGINX_IMAGE >>$LOG_FILE 2>&1 &&
   docker rmi $CADVISOR_IMAGE >>$LOG_FILE 2>&1
then
  echo ">> Images removed successfully." | tee -a $LOG_FILE
else
  echo ">> Error removing the images. One or more Images might not exist. Check logs at '$LOG_FILE'" | tee -a $LOG_FILE;
  # exit 1;
fi
}
