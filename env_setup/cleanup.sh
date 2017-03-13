#!/bin/bash

. ./variables.sh
. ./remove_images.sh
. ./remove_containers.sh
echo "\n\n\nTime: $(date)\n\n\n" >>$LOG_FILE
echo "\n**************** INITIATING CLEANUP ***********************"

remove_containers
remove_images

# rm $LOG_FILE

echo "\n**************** CLEANUP COMPLETED ***********************\n\n\n"
