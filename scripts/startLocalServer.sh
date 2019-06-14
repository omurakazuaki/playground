#!/bin/bash -ex

if [ -f .env ]; then
  . ./.env
fi

docker-compose up -d ${NGROK_TARGET_SERVICE} ngrok
docker-compose logs -f
