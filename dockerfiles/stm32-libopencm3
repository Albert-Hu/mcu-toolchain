FROM ubuntu:22.04

RUN apt-get update && \
  apt-get install -y \
    git \
    build-essential \
    gcc-arm-none-eabi \
    gdb-multiarch \
    stlink-tools \
    openocd \
    python3 \
    python3-venv \
    python3-pip \
    make \
    cmake

RUN python3 -m venv /opt/venv/python3

RUN /opt/venv/python3/bin/pip install pyserial

ENV PATH="/opt/venv/python3/bin:${PATH}"

RUN git clone https://github.com/libopencm3/libopencm3.git /opt/libopencm3

RUN make -C /opt/libopencm3 -j$(nproc)
