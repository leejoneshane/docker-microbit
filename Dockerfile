FROM node:8.9.4

ADD entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh \
    && apt-get update \
    && apt-get install git python build-essential udev \
    && apt-get clean autoclean \
    && apt-get autoremove --yes \
    && rm -rf /var/lib/{apt,dpkg,cache,log}/ \
    && mkdir -p /usr/src/app \
    && cd /usr/src/app \
    && git clone https://github.com/microsoft/pxt \
    && cd pxt && npm install && npm run build \
    && npm install -g pxt \   
    && cd /usr/src/app \
    && git clone https://github.com/microsoft/pxt-common-packages \
    && cd pxt-common-packages && npm install \
    && cd /usr/src/app \
    && git clone https://github.com/microsoft/pxt-microbit \
    && cd pxt-microbit \
    && npm link ../pxt && npm link ../pxt-common-packages \
    && npm install

WORKDIR /usr/src/app/pxt-microbit
EXPOSE 80 3233
VOLUME ["/usr/src/app"]
ENTRYPOINT ["/entrypoint.sh"]
