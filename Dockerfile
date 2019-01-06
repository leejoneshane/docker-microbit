FROM node:8

ADD entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh \
    && apt-get update \
    && apt-get install -y git python build-essential udev apt-utils \
    && apt-get clean autoclean \
    && apt-get autoremove --yes \
    && rm -rf /var/lib/{apt,dpkg,cache,log}/ \
    && npm i npm@latest -g \
    && mkdir -p /usr/src/app \
    && cd /usr/src/app \
    && git clone https://github.com/microsoft/pxt \
    && cd pxt && npm install && npm run build \
    && npm install -g pxt \   
    && cd /usr/src/app \
    && git clone https://github.com/microsoft/pxt-common-packages \
    && cd pxt-common-packages && npm install \
    && rm -rf node_modules/pxt-core && pxt link ../pxt \
    && cd /usr/src/app \
    && git clone https://github.com/microsoft/pxt-microbit \
    && cd pxt-microbit \
    && npm install \
    && rm -rf node_modules/pxt-core && pxt link ../pxt \
    && rm -rf node_modules/pxt-common-packages && npm link ../pxt-common-packages  

WORKDIR /usr/src/app/pxt-microbit
EXPOSE 80 3233
VOLUME ["/usr/src/app"]
ENTRYPOINT ["/entrypoint.sh"]
