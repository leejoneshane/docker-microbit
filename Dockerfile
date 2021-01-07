FROM node:10-alpine

ENV NODE_ENV production
ADD entrypoint.sh /entrypoint.sh
WORKDIR /makecode

RUN chmod +x /entrypoint.sh \
    && apk add --no-cache python eudev-dev linux-headers build-base git \
    && git clone --depth=1 https://github.com/Microsoft/pxt-microbit.git \
    && cd pxt-microbit \
    && npm install \
    && npm install pxt-core \
    && npm install pxt-common-packages \
    && npm install serialport \
    && npm audit fix
    
EXPOSE 80
ENTRYPOINT ["/entrypoint.sh"]
