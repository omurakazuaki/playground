#!/bin/bash -ex

pushd $(dirname $0)/../ > /dev/null

if [ -f .env ]; then
  . ./.env
fi

ecs-cli configure --cluster ${AWS_ECS_CLUSTER_NAME} --region ${AWS_DEFAULT_REGION} --config-name ${AWS_ECS_CLUSTER_NAME}-config --default-launch-type ${AWS_ECS_LAUNCH_TYPE}

aws ecr get-login-password | docker login --username AWS --password-stdin ${AWS_ACCOUNT_ID}.dkr.ecr.${AWS_DEFAULT_REGION}.amazonaws.com

REPSITORIES=$( aws ecr describe-repositories --query 'repositories[*].repositoryName' )
image=minecraft

echo "### Start build Docker images ###"
#docker-compose build

if [ `echo $REPSITORIES | grep ${image} | wc -l` -eq 0 ]; then
  echo "### Create repository ###"
  REPSITORY_ARM=$( aws ecr create-repository --repository-name ${image} --query 'repository.repositoryArn' )
  echo "### created repository '${REPSITORY_ARM}' ###"
  echo "### Set lifecycle policy ###"
  aws ecr put-lifecycle-policy --repository-name ${image} --lifecycle-policy-text "file://config/ecs/ecrlifecyclepolicy.json" --query 'repositoryName'
fi


echo "### Push images to ECR ###"
#ecs-cli push ${image}:1.12.2.forge
#ecs-cli push ${image}:1.14.2
#ecs-cli push ${image}:1.14.4.fabric
ecs-cli push ${image}:1.15.2.forge
