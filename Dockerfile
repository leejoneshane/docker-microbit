FROM node:alpine

ADD entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh \
    && apk add --no-cache git vim python \
    && mkdir -p /usr/src/app \
    && cd /usr/src/app \
    && git clone https://github.com/microsoft/pxt \
    && cd pxt && npm install && npm run build \
    && cd /usr/src/app \
    && git clone https://github.com/microsoft/pxt-common-packages \
    && cd pxt-common-packages && npm install \
    && cd /usr/src/app \
    && git clone https://github.com/microsoft/pxt-microbit \
    && cd pxt-microbit && npm install -g pxt && npm install \
    && npm link ../pxt && npm link ../pxt-common-packages \
    && pxt npminstallnative

WORKDIR /usr/src/app/pxt-microbit
EXPOSE 80 3233
VOLUME ["/usr/src/app"]
ENTRYPOINT ["/entrypoint.sh"]
