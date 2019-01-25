ARG         ALPINE_VERSION=${ALPINE_VERSION:-3.8}
FROM        alpine:${ALPINE_VERSION}

LABEL       maintainer="https://github.com/yubose"

ARG         OPENSSH_VERSION=${OPENSSH_VERSION:-7.7_p1-r3}
ENV         OPENSSH_VERSION=${OPENSSH_VERSION} \
            ROOT_PASSWORD=root \
            KEYPAIR_LOGIN=false

ADD         sshd_start.sh /root/
ADD         changeConfig.sedcmd /root/
RUN         apk add --upgrade --no-cache openssh=${OPENSSH_VERSION} \
            && sed -i.orig -f /root/changeConfig.sedcmd  /etc/ssh/sshd_config \
            && chmod +x /root/sshd_start.sh \
            && mkdir -p /var/log/sshd \
            && rm -rf /var/cache/apk/*

EXPOSE      22
VOLUME      ["/var/log/sshd"]
ENTRYPOINT  ["/root/sshd_start.sh"]
