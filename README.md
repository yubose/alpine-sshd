## Make your OpenSSH fly on Alpine

### Overview
This image intends for cocorporation/organzization to use as master user login server.
 After login to this server,  user can visit other server on the same network.
Therefore, this server hold all users' authentication info.

For maintain clean container for backup and restore, leave log on the host machine by
-v host:/var/log/sshd:/var/log/sshd

Use this Dockerfile / -image to start a sshd-server upon a lightweight Alpine container.

### Features
* Always installs the latest OpenSSH-Version available for Alpine
* disable PasswordAuthentication, only allow using keypair to login
* enable X11Forwarding, this allow login user to map local port to other service port

### Basic Usage
```
$ docker run -d --name alpine-sshd \
-v host:/var/log/sshd:/var/log/sshd
--publish=2222:22 \
hyugecloud/alpine_sshd
```

After the container is up,
#to add user
adduser.sh container_name user_name group_name user_full_name path_to_public_key

#to delete user
deluser.sh container_name user_name

After the container is up you are able to ssh in it as root with a private-key which matches the provided public-key in authorized_keys for "root"-user.
```
$ ssh user_name@localhost -p 2222 -i /path/to/private_key
```
### Use with docker-compose
I built this image in order to use it along with mysql-server and tomcat API server
If you are interested in a Dockerfile which fulfills this need: [this way](https://github.com/Hermsi1337/docker-compose/blob/master/full_php_dev_stack/docker-compose.yml)
