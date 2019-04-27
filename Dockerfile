FROM node:8

ADD entrypoint.sh /entrypoint.sh

WORKDIR /usr/src/app

RUN chmod +x /entrypoint.sh \
    && apt-get update && apt-get install -y build-essential libudev-dev git \
    && apt-get autoremove && apt-get clean \
    && npm install -g npm@latest \
    && npm install -g pxt \
    && pxt target microbit \
    && cd node_modules/pxt-microbit \
    && pxt link ../pxt-core \
    && pxt link ../pxt-common-packages \
    && pxt npminstallnative

EXPOSE 80
ENTRYPOINT ["/entrypoint.sh"]
