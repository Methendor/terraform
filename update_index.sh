#!/bin/bash
echo "<h1>${server_name}</h1>" > /opt/bitnami/nginx/html/index.html
aws s3 cp s3://${bucket_name}/index.html /opt/bitnami/nginx/html/index.html
mkdir /tmp/ssm
cd /tmp/ssm
sudo wget https://s3.eu-west-2.amazonaws.com/amazon-ssm-eu-west-2/latest/debian_amd64/amazon-ssm-agent.deb
sudo dpkg -i amazon-ssm-agent.deb
sudo systemctl enable amazon-ssm-agent