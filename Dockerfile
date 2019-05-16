FROM node:8-alpine

ENV npm_config_loglevel error
ADD entrypoint.sh /entrypoint.sh
WORKDIR /makecode

RUN chmod +x /entrypoint.sh \
    && apk add --no-cache python eudev-dev linux-headers build-base git \
    && npm install -g jake typings serialport \
    && git clone https://github.com/microsoft/pxt \
    && cd pxt && rm -rf .git \
    && npm install && npm audit fix \
    && typings install \
    && jake \
    && cd .. \
    && git clone https://github.com/Microsoft/pxt-microbit.git \
    && cd pxt-microbit && rm -rf .git \
    && npm install \
    && npm link ../pxt && npm audit fix

EXPOSE 80
ENTRYPOINT ["/entrypoint.sh"]
