FROM linuxserver/wireguard:latest

RUN apk update
RUN apk add tinyproxy
RUN apk add coreutils
EXPOSE 8888


COPY ./docker/start.sh /start.sh
ENTRYPOINT ["/start.sh"]


