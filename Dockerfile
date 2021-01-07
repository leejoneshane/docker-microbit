FROM node:12-alpine

ENV NODE_ENV production
ADD entrypoint.sh /entrypoint.sh
WORKDIR /makecode

RUN chmod +x /entrypoint.sh \
    && apk add --no-cache python eudev-dev linux-headers build-base git \
    && npm install -g pxt \
    && git clone https://github.com/Microsoft/pxt-microbit.git \
    && cd pxt-microbit \
    && npm install --save serialport && npm fund \
    && npm audit fix
    
EXPOSE 80
ENTRYPOINT ["/entrypoint.sh"]
