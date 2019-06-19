#!/bin/bash -ex

pushd $(dirname $0)/../ > /dev/null

if [ -f .env ]; then
  . ./.env
fi

docker-compose up -d ${NGROK_TARGET_SERVICE} ngrok
docker-compose logs -f
