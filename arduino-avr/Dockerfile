FROM ubuntu:latest

RUN apt update && apt install -y gcc-avr avr-libc make python3 python3-pip python3-venv avrdude dfu-programmer

RUN python3 -m venv /opt/venv/python3

RUN /opt/venv/python3/bin/pip install pyserial
