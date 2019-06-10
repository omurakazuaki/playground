#!/bin/bash -ex

pushd $(dirname $0)/../ > /dev/null

if [ -f .env ]; then
  . ./.env
fi

ecs-cli up --cluster-config ${AWS_ECS_CLUSTER_NAME}-config --aws-profile ${AWS_ECS_PROFILE} --keypair ${AWS_ECS_KEY_PAIR} --capability-iam --vpc ${AWS_ECS_VPC} --subnets ${AWS_ECS_SUBNET} --instance-type ${AWS_ECS_INSTANCE_TYPE}
