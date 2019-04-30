FROM node:8

ENV npm_config_loglevel error
ADD entrypoint.sh /entrypoint.sh
WORKDIR /usr/src/app

RUN chmod +x /entrypoint.sh \
    && apt-get update && apt-get install -y build-essential libudev-dev git \
    && apt-get autoremove && apt-get clean \
    && npm install -g pxt \    
    && pxt target microbit \
    && cd node_modules/pxt-microbit \
    && pxt link ../pxt-core \
    && pxt link ../pxt-common-packages \
    && pxt npminstallnative \
    && cd /usr/local/bin && npm update \
    && cd /usr/src/app && npm update

EXPOSE 80
ENTRYPOINT ["/entrypoint.sh"]
