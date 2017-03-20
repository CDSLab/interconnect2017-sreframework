#!/bin/sh

sudo apt-get remove python-pip >>$LOG_FILE 2>&1 &&
sudo easy_install pip >>$LOG_FILE 2>&1 &&
