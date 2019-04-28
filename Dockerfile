FROM node:8

ADD entrypoint.sh /entrypoint.sh

WORKDIR /usr/src/app

RUN chmod +x /entrypoint.sh \
    && apt-get update && apt-get install -y build-essential libudev-dev git \
    && apt-get autoremove && apt-get clean \
    && npm install -g npm@latest \
    && git clone https://github.com/microsoft/pxt \
    && cd pxt && npm install && npm run build \
    && cd .. \
    && git clone https://github.com/microsoft/pxt-common-packages \
    && cd pxt-common-packages && npm install \
    && cd .. \
    && git clone https://github.com/microsoft/pxt-microbit \
    && cd pxt-microbit && npm install -g pxt && npm install \
    && pxt link ../pxt \
    && pxt link ../pxt-common-packages \
    && pxt npminstallnative

EXPOSE 80
ENTRYPOINT ["/entrypoint.sh"]
