# Playground

[![CircleCI](https://circleci.com/gh/omurakazuaki/playground.svg?style=svg)](https://circleci.com/gh/omurakazuaki/playground)

## minecraft docker image

### build image

```sh
# create ops.txt
$ cp minecraft/ops.txt.sample minecraft/ops.txt
$ vi minecraft/ops.txt 
# build images
$ docker-compose build
```

### push images to ECR

```sh
# edit environment variable for AWS
$ vi .env
$ ./scripts/scripts/pushECR.sh
```

### create and delete ECS service

```sh
# create
$ ./scripts/createService.sh

# delete
$ ./scripts/deleteService.sh
```

### up local server

```sh
$ ./scripts/startLocalServer.sh
```
