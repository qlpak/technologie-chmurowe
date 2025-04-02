#!/bin/bash

echo "Checking connections..."

curl -s http://localhost:8080 | grep -q "Frontend" && echo "Frontend OK" || echo "Frontend problem"

RESPONSE=$(curl -s http://localhost:8080)
echo "$RESPONSE" | grep -q "DB time" && echo "Backend <-> Database OK" || echo "Backend/DB problem"
