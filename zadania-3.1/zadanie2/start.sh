#!/bin/bash

container="my_custom_nginx"
PORT=${1:-8080} 

if [ "$(docker ps -a -q -f name=$container)" ]; then
    echo "deleting exisiting container....."
    docker rm -f $container
fi

sed "s/listen 8080;/listen $PORT;/" nginx/nginx.conf > nginx/temp_nginx.conf

echo "image buildining.."
docker build -t custom-nginx-2 .

echo "trying to run a container on port: $PORT..."
docker run -d --name $container -p $PORT:$PORT -v $(pwd)/nginx/temp_nginx.conf:/etc/nginx/nginx.conf custom-nginx-2

echo "waiting for container to start."
sleep 2

