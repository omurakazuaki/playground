#!/bin/bash -l

pushd $(dirname $0)/../ > /dev/null

if [ -f .env ]; then
  . ./.env
fi

TIMESTAMP=`date "+%Y%m%d_%H%M%S"`

ssh ${AWS_EC2_SERVER_NAME} <<EOC
mkdir -p /minecraft/backup
tar -zcvf /minecraft/backup/world_${TIMESTAMP}.tar.gz /minecraft/world
ls -drt /minecraft/backup/* | head -1 | xargs rm
ls /minecraft/backup
EOC

mkdir -p ./minecraft/backup
scp -r ${AWS_EC2_SERVER_NAME}:/minecraft/backup/world_${TIMESTAMP}.tar.gz ./minecraft/backup
