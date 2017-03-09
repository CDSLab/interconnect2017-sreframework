#!/bin/bash

. ./variables.sh

remove_containers()
{
echo "\n\n\nRemvoving the containers..."
if docker rm -f $APACHE_1 >>$LOG_FILE 2>&1 &&
   docker rm -f $APACHE_2 >>$LOG_FILE 2>&1 &&
   docker rm -f $NGINX >>$LOG_FILE 2>&1 &&
   docker rm -f $CADVISOR >>$LOG_FILE 2>&1
then
  echo "Containers removed successfully."
else
  echo "Error removing the containers. Check logs at '$LOG_FILE'";
  exit 1;
fi
}
