FROM node:alpine

RUN apk add --no-cache git vim \
    && mkdir -p /usr/src/app \
    && cd /usr/src/app \
    && git clone https://github.com/microsoft/pxt \
    && cd pxt && npm install && npm run build \
    && cd /usr/src/app \
    && git clone https://github.com/microsoft/pxt-common-packages \
    && cd pxt-common-package && npm install \
    && cd /usr/src/app \
    && git clone https://github.com/microsoft/pxt-microbit \
    && cd pxt-microbit && npm install -g pxt && npm install \
    && npm link ../pxt && npm link ../pxt-common-packages

WORKDIR /usr/src/app/pxt-microbit
EXPOSE 80 3233
VOLUME ["/usr/src/app"]
ENTRYPOINT ["entrypoint.sh"]
