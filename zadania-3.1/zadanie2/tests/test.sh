#!/bin/bash

PORT=${1:-8080}

echo "testing availabilty on port: $PORT..."

curl -s http://localhost:$PORT | grep -q "Welcome to nginx"


if [ $? -eq 0 ]; then
    echo "test passed"
    exit 0
else
    echo "error. its not working "
    exit 1
fi
