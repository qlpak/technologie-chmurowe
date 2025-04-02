#!/bin/bash

docker -v >/dev/null 2>&1 || { echo "Docker nie jest zainstalowany."; exit 1; }
docker-compose -v >/dev/null 2>&1 || { echo "Docker Compose nie jest zainstalowany."; exit 1; }

cat <<EOF > Dockerfile
FROM node:16
WORKDIR /app
COPY package.json package-lock.json ./
RUN npm install
COPY . .
CMD ["node", "server.js"]
EOF

cat <<EOF > docker-compose.yml
version: '3.8'
services:
  mongo:
    image: mongo
    container_name: mongo_db
    restart: always
    ports:
      - "27017:27017"
    environment:
      MONGO_INITDB_ROOT_USERNAME: root
      MONGO_INITDB_ROOT_PASSWORD: example

  app:
    build: .
    container_name: express_app
    restart: always
    ports:
      - "8080:8080"
    depends_on:
      - mongo
    environment:
      MONGO_URI: "mongodb://root:example@mongo:27017"
EOF

docker-compose up -d

sleep 5 
docker ps | grep -q express_app || { echo "Kontener aplikacji nie działa."; exit 1; }
docker ps | grep -q mongo_db || { echo "Kontener MongoDB nie działa."; exit 1; }
curl -s http://localhost:8080 | grep -q '\[\]' || { echo "Aplikacja nie zwraca poprawnych danych."; exit 1; }

echo "Skrypt zakończony pomyślnie!"
