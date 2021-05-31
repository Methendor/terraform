FROM amazonlinux:latest

RUN yum -y update && \
    yum install -y yum-utils && \
    yum-config-manager -y --add-repo https://rpm.releases.hashicorp.com/AmazonLinux/hashicorp.repo && \
    yum -y install terraform git awscli && \
    cd /tmp && \
    git clone https://github.com/Methendor/terraform.git && \
    cd /tmp/terraform && \
    terraform init