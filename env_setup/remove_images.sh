#!/bin/bash

. ./variables.sh

remove_images()
{
echo "\n\n\n>> Remvoving the images..." | tee -a $LOG_FILE

if docker images | grep "$APACHE_IMAGE" >>$LOG_FILE 2>&1
then
  if docker rmi $APACHE_IMAGE >>$LOG_FILE 2>&1
  then echo ">> $APACHE_IMAGE removed successfully." | tee -a $LOG_FILE
  else
    echo ">> Error removing $APACHE_IMAGE. Check logs at '$LOG_FILE'" | tee -a $LOG_FILE;
    exit 1;
  fi
else echo ">> Image $APACHE_IMAGE not present." | tee -a $LOG_FILE
fi


if docker images | grep "$NGINX_IMAGE" >>$LOG_FILE 2>&1
then
  if docker rmi $NGINX_IMAGE >>$LOG_FILE 2>&1
  then echo ">> $NGINX_IMAGE removed successfully." | tee -a $LOG_FILE
  else
    echo ">> Error removing $NGINX_IMAGE. Check logs at '$LOG_FILE'" | tee -a $LOG_FILE;
    exit 1;
  fi
else echo ">> Image $NGINX_IMAGE not present." | tee -a $LOG_FILE
fi


if docker images | grep "$CADVISOR_IMAGE" >>$LOG_FILE 2>&1
then
  if docker rmi $CADVISOR_IMAGE >>$LOG_FILE 2>&1
  then echo ">> $CADVISOR_IMAGE removed successfully." | tee -a $LOG_FILE
  else
    echo ">> Error removing $CADVISOR_IMAGE. Check logs at '$LOG_FILE'" | tee -a $LOG_FILE;
    exit 1;
  fi
else echo ">> Image $CADVISOR_IMAGE not present." | tee -a $LOG_FILE
fi





# if docker rmi $APACHE_IMAGE >>$LOG_FILE 2>&1 &&
#    docker rmi $NGINX_IMAGE >>$LOG_FILE 2>&1 &&
#    docker rmi $CADVISOR_IMAGE >>$LOG_FILE 2>&1
# then
#   echo ">> Images removed successfully." | tee -a $LOG_FILE
# else
#   echo ">> Error removing the images. One or more Images might not exist. Check logs at '$LOG_FILE'" | tee -a $LOG_FILE;
#   # exit 1;
# fi
}
