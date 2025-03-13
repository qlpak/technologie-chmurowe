#!/bin/bash

container="my_nginx"

if [ "$(docker ps -a -q -f name=$container)" ]; then
    echo "removing exisiting container.."
    docker rm -f $container
fi

echo "image buidling.."
docker build -t custom-nginx .

echo "starting the container"
docker run -d --name $container -p 8080:80 custom-nginx

echo "wait for container to start."
sleep 2

