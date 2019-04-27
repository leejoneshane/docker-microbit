FROM node

ADD entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh \
    && apt-get update && apt-get install -y build-essential libudev-dev git \
    && npm i npm@latest -g \
    && mkdir -p /usr/src/app \
    && cd /usr/src/app \
#    && npm install -g pxt \   
#    && pxt target microbit \
#    && cd node_modules/pxt-microbit \
#    && pxt link ../pxt-core \
#    && pxt link ../pxt-common-packages \   
    && git clone https://github.com/microsoft/pxt \
    && cd pxt && npm install && npm run build && npm install -g pxt \
    && cd .. \
    && git clone https://github.com/microsoft/pxt-common-packages \
    && cd pxt-common-packages && npm install \
    && cd .. \
    && git clone https://github.com/microsoft/pxt-microbit \
    && cd pxt-microbit && npm install \
    && npm link ../pxt && npm link ../pxt-common-packages

WORKDIR /usr/src/app
EXPOSE 80

ENTRYPOINT ["/entrypoint.sh"]
