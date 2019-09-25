FROM python:2-alpine

LABEL maintainer="louis@orleans.io"

# user-configurable vars
ENV EULA false
ENV RAM_MAX 8G

VOLUME /klipper-config

WORKDIR /

RUN echo "http://dl-cdn.alpinelinux.org/alpine/edge/testing" >> /etc/apk/repositories && \
  apk update && \
  apk add --no-cache git python-dev libffi-dev build-base \
  ncurses-dev libusb-dev avrdude gcc-avr binutils-avr avr-libc stm32flash \
  dfu-util newlib-arm-none-eabi gcc-arm-none-eabi binutils-arm-none-eabi

RUN git clone https://github.com/KevinOConnor/klipper.git && \
  cd /klipper && \
  pip install -r /klipper/scripts/klippy-requirements.txt

# CMD ls -la /klipper/klippy
CMD python /klipper/klippy/klippy.py /klipper-config/printer.cfg
