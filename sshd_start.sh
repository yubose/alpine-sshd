#!/bin/sh

# Since no host keys are exist in this docker image,
# this will generate host keys for /usr/sbin/sshd to start.
# ssh-keygen: generating new host keys: RSA DSA ECDSA ED25519
# and they are put under /etc/ssh/
ssh-keygen -A

# -v host:/var/log/sshd is recommended for keeping the container clean
# do not detach (-D), log to /var/log/sshd, passthrough other arguments
exec /usr/sbin/sshd -D -E /var/log/sshd/`date +%F` "$@"
