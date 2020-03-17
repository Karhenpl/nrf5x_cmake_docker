#!/bin/bash

# NOTE! this script just run container from host ready nrfdev_sdk image

IMAGE="nrfdev_sdk"
CONTAINER="nrfdev_sdk-container"
RCFILE="rcfile.docker"
# Current folder is mapped into /root/(currentfoldername) in container

GET_SCRIPT_ABS_DIR="`( cd \"$(dirname $0)\" && pwd )`"

GET_PROJECT_ABS_DIR="$(dirname "$(dirname $GET_SCRIPT_ABS_DIR)")"

PROJECT_DIR=$GET_PROJECT_ABS_DIR

echo "Project in: $GET_PROJECT_ABS_DIR"

if [ -z $SDK_DIR ]; then
  echo "error SDK_DIR not configured!"
  exit 1
fi

echo "SDK in: $SDK_DIR"

VIRTUAL_DIR="/root/${PROJECT_DIR##*/}"

docker run -it --name $CONTAINER \
--rm --privileged \
-v /dev/bus/usb:/dev/bus/usb \
-v $PROJECT_DIR:$VIRTUAL_DIR \
-v $SDK_DIR:/root/sdk \
-w /root \
--env PROJECT_DIR=$VIRTUAL_DIR \
--env SDK_DIR=/root/sdk \
--env NRFJPROG_DIR=/usr/bin/nrfjprog \
--env CONTAINER=TRUE \
$IMAGE /bin/bash --rcfile $RCFILE

