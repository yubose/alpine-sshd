CONTAINER=$1
USER_NAME=$2

docker container exec ${CONTAINER} deluser ${USER_NAME}
