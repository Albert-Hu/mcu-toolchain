# mcu-toolchain

Using Docker environments to set up the toolchains for MCU firmware development.

## Overview

This project provides Docker environments for various microcontroller (MCU) development toolchains. Each Docker image contains all the necessary tools, compilers, and libraries needed for developing firmware for specific MCU platforms.

## Available Toolchains

The following toolchains are available:

- `arduino-avr`: Toolchain for Arduino AVR-based boards
- `stm32-libopencm3`: Toolchain for STM32 microcontrollers with libopencm3 support

## Usage

### Building Docker Images

The project includes a script `build-docker-image.sh` to build the Docker images:

```bash
# Build a specific Docker image
./build-docker-image.sh <dockerfile-name>

# List all available Dockerfiles
./build-docker-image.sh list

# Build all Docker images
# Note: Already existing Docker images will be skipped
./build-docker-image.sh all
```

### Using the Docker Images

After building the Docker images, you can use them for your MCU development:

```bash
# Run a Docker image (example)
docker run -it --rm -v $(pwd):/workspace <image-name>
```

## Project Structure

```
mcu-toolchain/
├── build-docker-image.sh  # Script to build Docker images
├── dockerfiles/           # Directory containing Dockerfiles
│   ├── arduino-avr        # Dockerfile for Arduino AVR toolchain
│   └── stm32-libopencm3   # Dockerfile for STM32 toolchain with libopencm3
└── README.md              # This README file
```
