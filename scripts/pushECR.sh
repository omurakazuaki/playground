#!/bin/bash -ex

pushd $(dirname $0)/../ > /dev/null

if [ -f .env ]; then
  . ./.env
fi

ecs-cli configure --cluster ${AWS_ECS_CLUSTER_NAME} --region ${AWS_DEFAULT_REGION} --config-name ${AWS_ECS_CLUSTER_NAME}-config --default-launch-type ${AWS_ECS_LAUNCH_TYPE}

`aws ecr get-login --no-include-email --region $AWS_DEFAULT_REGION`

REPSITORIES=$( aws ecr describe-repositories --query 'repositories[*].repositoryName' )
image=minecraft

echo "### Start build Docker image ${image} ###"
docker-compose build

if [ `echo $REPSITORIES | grep ${image} | wc -l` -eq 0 ]; then
  echo "### Create repository '${image}' ###"
  REPSITORY_ARM=$( aws ecr create-repository --repository-name ${image} --query 'repository.repositoryArn' )
  echo "### created repository '${REPSITORY_ARM}' ###"
  echo "### Set lifecycle policy ###"
  aws ecr put-lifecycle-policy --repository-name ${image} --lifecycle-policy-text "file://config/ecs/ecrlifecyclepolicy.json" --query 'repositoryName'
fi


echo "### Push ${image} to ECR ###"
ecs-cli push ${image}:1.12.2.forge
ecs-cli push ${image}:1.14.2
