FROM node:8.9.4-alpine

ADD entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh \
    && apk add --no-cache git vim python2 build-base \
    && mkdir -p /usr/src/app \
    && cd /usr/src/app \
    && git clone https://github.com/microsoft/pxt \
    && cd pxt && npm install && npm run build \
    && npm install -g pxt \   
    && cd /usr/src/app \
    && git clone https://github.com/microsoft/pxt-common-packages \
    && cd pxt-common-packages && npm install \
    && cd /usr/src/app \
    && git clone https://github.com/microsoft/pxt-microbit \
    && cd pxt-microbit \
    && npm link ../pxt && npm link ../pxt-common-packages \
    && npm install && pxt npminstallnative

WORKDIR /usr/src/app/pxt-microbit
EXPOSE 80 3233
VOLUME ["/usr/src/app"]
ENTRYPOINT ["/entrypoint.sh"]
