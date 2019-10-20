FROM alpine:latest
MAINTAINER Sascha Effert
RUN apk add --update google-authenticator openssh-server-pam openssh-client libqrencode && \
    rm  -rf /tmp/* /var/cache/apk/* && \
    sed -i 's/ChallengeResponseAuthentication no/ChallengeResponseAuthentication yes/' /etc/ssh/sshd_config && \
    adduser -D --uid 1000 fermat && \
    mkdir /home/fermat/.ssh && \
    chown fermat /home/fermat/.ssh && \
    passwd -d root
ADD docker-entrypoint.sh /usr/local/bin
ADD sshd.pam /etc/pam.d/sshd
EXPOSE 22
ENTRYPOINT ["/usr/local/bin/docker-entrypoint.sh"]
CMD ["/usr/sbin/sshd","-D"]

