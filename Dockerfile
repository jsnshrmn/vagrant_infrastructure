FROM library/debian:9

ENV container docker
ENV DEBIAN_FRONTEND "noninteractive"
ENV NOTVISIBLE "in users profile"

ADD scripts/dockerrun.sh /root/dockerrun.sh
ADD scripts/dockerexec.sh /root/dockerexec.sh

RUN /root/dockerrun.sh

STOPSIGNAL SIGRTMIN+3

CMD ["/root/dockerexec.sh", "-D"]
EXPOSE 22
