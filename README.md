# build image

```sh
$ docker-compose build
```

# push images to ECR

```sh
$ ./scripts/scripts/pushECR.sh
```

# create and delete ECS service

```sh
# create
$ ./scripts/createService.sh

# delete
$ ./scripts/deleteService.sh
```
