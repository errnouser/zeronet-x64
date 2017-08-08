FROM alpine:latest

ENV HOME /root

COPY launch /root/launch
COPY obfs4proxy /usr/bin/obfs4proxy

RUN apk --update upgrade \
  && apk add tor --update-cache --repository http://dl-4.alpinelinux.org/alpine/edge/community/ \
  && apk --no-cache --no-progress add git musl-dev bash gcc python python-dev py2-pip \
  && pip install gevent msgpack-python \
  && apk del musl-dev gcc python-dev py2-pip \
  && rm -rf /var/cache/apk/* /tmp/* /var/tmp/* \
  && chmod +x /root/launch /usr/bin/obfs4proxy

VOLUME /root/data

WORKDIR /root

ENV ZERONET_UI_PORT=43110 ZERONET_HOME=1HeLLo4uzjaLetFx6NH3PMwFP3qbRbTf3D DISABLE_TOR=false UI_PASSWORD=None

EXPOSE 43110 15441

CMD ["/root/launch"]
