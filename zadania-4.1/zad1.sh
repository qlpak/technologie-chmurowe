#!/bin/bash

docker volume create nginx_data

docker run -d --name my_nginx \
  -p 8080:80 \
  -v nginx_data:/usr/share/nginx/html \
  nginx

sleep 2

docker run --rm -v nginx_data:/data alpine sh -c "echo '<h1>MY PAGE</h1>' > /data/index.html"

echo "get to:  http://localhost:8080"
