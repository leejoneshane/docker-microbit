FROM node:8

ENV npm_config_loglevel error
ADD entrypoint.sh /entrypoint.sh

RUN chmod +x /entrypoint.sh \
    && mkdir -p /usr/src/app \
    && apt-get update && apt-get install -y build-essential libudev-dev git \
    && apt-get autoremove && apt-get clean \
    && git clone https://github.com/microsoft/pxt \
    && cd pxt && rm -rf .git && npm install && npm run build \
    && ln -s /usr/src/app/pxt/pxt-cli/pxt /usr/local/bin/pxt \
    && cd .. \
    && git clone https://github.com/microsoft/pxt-common-packages \
    && cd pxt-common-packages && rm -rf .git &&  npm install \
    && cd .. \
    && git clone https://github.com/microsoft/pxt-microbit \
    && cd pxt-microbit && rm -rf .git && npm install \
    && npm link ../pxt \
    && npm link ../pxt-common-packages \
    && pxt npm installnative

WORKDIR /usr/src/app/pxt-microbit
EXPOSE 80
ENTRYPOINT ["/entrypoint.sh"]
