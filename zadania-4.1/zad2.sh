#!/bin/bash

docker volume create nodejs_data
docker volume create nginx_data
docker volume create all_volumes

docker run -d --name my_node \
  -v nodejs_data:/app \
  node:alpine tail -f /dev/null

docker exec my_node sh -c "echo 'console.log(\”there goes node js !\”)’ > /app/index.js"

docker run --rm -v nginx_data:/usr/share/nginx/html alpine sh -c "echo '<h1>Nginx HTML</h1>' > /usr/share/nginx/html/index.html"

docker run --rm \
  -v nginx_data:/nginx_html \
  -v nodejs_data:/node_app \
  -v all_volumes:/all \
  alpine sh -c "mkdir -p /all/html && cp -r /nginx_html/* /all/html && mkdir -p /all/app && cp -r /node_app/* /all/app"

echo “all done. check all_volumes."
