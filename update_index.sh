#!/bin/bash
echo "test" > /opt/bitnami/nginx/html/new.html
echo "<h1>${server_name}</h1>" > /opt/bitnami/nginx/html/index.html