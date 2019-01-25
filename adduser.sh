CONTAINER=$1
USER_NAME=$2
GROUP_NAME=$3
FULL_NAME=$4
PATH_PUBLIC_KEY=$5

docker container exec ${CONTAINER} addgroup ${GROUP_NAME}
docker container exec ${CONTAINER} adduser -D -s /bin/sh -g "${FULL_NAME}" -G ${GROUP_NAME} ${USER_NAME}
#unlock user account
docker container exec ${CONTAINER} passwd -u ${USER_NAME}
docker container exec ${CONTAINER} mkdir /home/${USER_NAME}/.ssh
docker container cp ${PATH_PUBLIC_KEY} ${CONTAINER}:/home/${USER_NAME}/.ssh/authorized_keys
docker container exec ${CONTAINER} chown -R ${USER_NAME}.${GROUP_NAME} /home/${USER_NAME}
docker container exec ${CONTAINER} chmod 700 /home/${USER_NAME}/.ssh
docker container exec ${CONTAINER} chmod 600 /home/${USER_NAME}/.ssh/authorized_keys

