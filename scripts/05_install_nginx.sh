#!/usr/bin/env bash

sudo -i

sudo yum update -y
sudo yum install -y nginx

sudo systemctl enable nginx.service