#!/bin/bash

. ./variables.sh

remove_containers()
{
echo ">> Remvoving the containers..." | tee -a $LOG_FILE

if docker ps -a | grep "$APACHE_1" >>$LOG_FILE 2>&1
then
  if docker rm -f $APACHE_1 >>$LOG_FILE 2>&1
  then echo ">> Container $APACHE_1 removed successfully." | tee -a $LOG_FILE
  else
    echo ">> Error removing the container $APACHE_1. One or more Containers might not exist. Check logs at '$LOG_FILE'" | tee -a $LOG_FILE;
    exit 1;
  fi
else echo ">> Container $APACHE_1 not present." | tee -a $LOG_FILE
fi


if docker ps -a | grep "$APACHE_2" >>$LOG_FILE 2>&1
then
  if docker rm -f $APACHE_2 >>$LOG_FILE 2>&1
  then echo ">> Container $APACHE_2 removed successfully." | tee -a $LOG_FILE
  else
    echo ">> Error removing the container $APACHE_2. One or more Containers might not exist. Check logs at '$LOG_FILE'" | tee -a $LOG_FILE;
    exit 1;
  fi
else echo ">> Container $APACHE_2 not present." | tee -a $LOG_FILE
fi


if docker ps -a | grep "$NGINX" >>$LOG_FILE 2>&1
then
  if docker rm -f $NGINX >>$LOG_FILE 2>&1
  then echo ">> Container $NGINX removed successfully." | tee -a $LOG_FILE
  else
    echo ">> Error removing the container $NGINX. One or more Containers might not exist. Check logs at '$LOG_FILE'" | tee -a $LOG_FILE;
    exit 1;
  fi
else echo ">> Container $NGINX not present." | tee -a $LOG_FILE
fi


if docker ps -a | grep "$CADVISOR" >>$LOG_FILE 2>&1
then
  if docker rm -f $CADVISOR >>$LOG_FILE 2>&1
  then echo ">> Container $CADVISOR removed successfully." | tee -a $LOG_FILE
  else
    echo ">> Error removing the container $CADVISOR. One or more Containers might not exist. Check logs at '$LOG_FILE'" | tee -a $LOG_FILE;
    exit 1;
  fi
else echo ">> Container $CADVISOR not present." | tee -a $LOG_FILE
fi

#
# if docker rm -f $APACHE_1 >>$LOG_FILE 2>&1 &&
#    docker rm -f $APACHE_2 >>$LOG_FILE 2>&1 &&
#    docker rm -f $NGINX >>$LOG_FILE 2>&1 &&
#    docker rm -f $CADVISOR >>$LOG_FILE 2>&1
# then
#   echo ">> Containers removed successfully." | tee -a $LOG_FILE
# else
#   echo ">> Error removing the containers. One or more Containers might not exist. Check logs at '$LOG_FILE'" | tee -a $LOG_FILE;
#   # exit 1;
# fi
}
