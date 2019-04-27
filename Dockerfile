FROM node:alpine

ADD entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh \
    && apk add --no-cache build-base python \
    && npm i npm@latest -g \
    && mkdir -p /usr/src/app \
    && cd /usr/src/app \
    && npm install -g pxt \   
    && pxt target microbit \
    && cd node_modules/pxt-microbit \
    && pxt link ../pxt-core \
    && pxt link ../pxt-common-packages \
    && pxt npminstallnative

WORKDIR /usr/src/app
EXPOSE 80

ENTRYPOINT ["/entrypoint.sh"]
