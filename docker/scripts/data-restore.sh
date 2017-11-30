#!/bin/bash
# This script allows you to backup all volumes from a container in a tar.gz file

CONTAINER_NAME=$1
FILENAME=$2
echo "Restore docker's volume(s) from : "$CONTAINER_NAME_DATA

usage() {
  echo "Usage: $0 [container name]"
  exit 1
}

if [ -z $CONTAINER_NAME ]
then
  echo "Error: missing container name parameter."
  usage
fi

if [ -z $FILENAME ]
then
  echo "Error: missing filename."
  usage
fi

printf "\n"
echo "Pause docker container : "$CONTAINER_NAME
docker stop $CONTAINER_NAME >> /dev/null

echo "Restore datas from "$CONTAINER_NAME" container"

docker run --volumes-from $CONTAINER_NAME -v $(pwd):/backup ubuntu bash -c "tar xf /backup/$FILENAME"

printf "\n"
echo "Start docker container : "$CONTAINER_NAME
docker start $CONTAINER_NAME >> /dev/null

echo "Done."
