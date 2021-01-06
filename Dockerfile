FROM node:alpine

ENV npm_config_loglevel error
ADD entrypoint.sh /entrypoint.sh
WORKDIR /makecode

RUN chmod +x /entrypoint.sh \
    && apk add --no-cache python git \
    && npm install -g pxt \
    && git clone https://github.com/Microsoft/pxt-microbit.git \
    && cd pxt-microbit \
    && npm install serialport && npm install \
    && npm audit fix --force
    
EXPOSE 80
ENTRYPOINT ["/entrypoint.sh"]
