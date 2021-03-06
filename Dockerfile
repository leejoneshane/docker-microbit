FROM node:8-alpine

ADD entrypoint.sh /entrypoint.sh
WORKDIR /makecode

RUN chmod +x /entrypoint.sh \
    && apk add --no-cache python eudev-dev linux-headers build-base git \
    && git clone --depth=1 https://github.com/Microsoft/pxt-microbit.git \
    && cd pxt-microbit \
    && npm install -g pxt \
    && npm install \
    && npm install serialport \
    && npm audit fix
    
EXPOSE 80
ENTRYPOINT ["/entrypoint.sh"]
