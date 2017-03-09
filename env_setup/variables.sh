#!/bin/bash

APACHE_IMAGE="nimmis/alpine-apache"
NGINX_IMAGE="smebberson/alpine-nginx"
CADVISOR_IMAGE="google/cadvisor"
LOG_FILE="/tmp/setup.log"
APACHE_1="app1"
APACHE_2="app2"
NGINX="loadbalancer"
CADVISOR="cadvisor"

echo "\n\n\nTime: $(date)\n\n\n" >>$LOG_FILE 2>&1
