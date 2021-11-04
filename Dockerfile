FROM python:2-alpine

LABEL maintainer="louis@orleans.io"

VOLUME /klipper-config
VOLUME /klipper/out/

WORKDIR /

RUN \
  echo "http://dl-cdn.alpinelinux.org/alpine/edge/main" >> /etc/apk/repositories && \
  echo "http://dl-cdn.alpinelinux.org/alpine/edge/community" >> /etc/apk/repositories && \
  echo "http://dl-cdn.alpinelinux.org/alpine/edge/testing" >> /etc/apk/repositories
RUN apk update && \
  apk add --no-cache git python-dev libffi-dev build-base \
  ncurses-dev libusb-dev avrdude gcc-avr binutils-avr avr-libc stm32flash \
  dfu-util newlib-arm-none-eabi gcc-arm-none-eabi binutils-arm-none-eabi

RUN git clone https://github.com/Klipper3d/klipper.git && \
  cd /klipper && \
  pip install -r /klipper/scripts/klippy-requirements.txt

COPY entrypoint.sh /

WORKDIR /klipper

ENV LOGFILE="/var/log/klippy.log"

ENTRYPOINT /entrypoint.sh
