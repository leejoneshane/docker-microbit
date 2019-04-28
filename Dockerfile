FROM node:8

ENV npm_config_loglevel error
ADD entrypoint.sh /entrypoint.sh

RUN chmod +x /entrypoint.sh \
    && mkdir -p /usr/src/app \
    && cd /usr/src/app \
    && npm install -g pxt webusb \   
    && pxt target microbit \
    && cd node_modules/pxt-microbit \
    && pxt link ../pxt-core \
    && pxt link ../pxt-common-packages \
    && pxt npminstallnative

WORKDIR /usr/src/app/pxt-microbit
EXPOSE 80
ENTRYPOINT ["/entrypoint.sh"]
