#!/bin/bash -ex

pushd $(dirname $0)/../ > /dev/null

if [ -f .env ]; then
  . ./.env
fi

ecs-cli compose -p ${AWS_ECS_TASK_NAME} --file docker-compose.ecs.yml --cluster-config ${AWS_ECS_CLUSTER_NAME}-config --aws-profile ${AWS_ECS_PROFILE} --ecs-params ./config/ecs/ecstaskparams.yml service up
