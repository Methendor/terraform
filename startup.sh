#!/bin/bash
sudo apt-get -y install git
cd /opt/bitnami/nginx/html
sudo git clone --depth 1 https://github.com/Methendor/website.git

mkdir /tmp/ssm
cd /tmp/ssm
sudo wget https://s3.eu-west-2.amazonaws.com/amazon-ssm-eu-west-2/latest/debian_amd64/amazon-ssm-agent.deb
sudo dpkg -i amazon-ssm-agent.deb
sudo systemctl enable amazon-ssm-agent