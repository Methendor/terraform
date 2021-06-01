#!/bin/bash

# install website from git repo
apt-get -y install git
rm -Rf /opt/bitnami/nginx/html
mkdir /opt/bitnami/nginx/html
cd /opt/bitnami/nginx/html
git init .
git remote add -t \* -f origin https://github.com/Methendor/website.git
git checkout main
sed -i "s/{instance_id}/$(curl -s http:\/\/169.254.169.254\/latest\/meta-data\/instance-id)/g" /opt/bitnami/nginx/html/index.html
sed -i "s/{instance_ip}/$(curl -s http:\/\/169.254.169.254\/latest\/meta-data\/local-ipv4)/g" /opt/bitnami/nginx/html/index.html

# install systems manager agent
mkdir /tmp/ssm
cd /tmp/ssm
wget https://s3.eu-west-2.amazonaws.com/amazon-ssm-eu-west-2/latest/debian_amd64/amazon-ssm-agent.deb
dpkg -i amazon-ssm-agent.deb
systemctl enable amazon-ssm-agent
