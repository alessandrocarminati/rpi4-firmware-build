#!/bin/bash
set -eo pipefail

REMOTE="rc3399.hqhome163.com"
TS=$(date +%Y%m%d.%H%M%S)

ssh ${REMOTE} 'cd ~/src/rpi4/rpi4-uefi-toolchain && rm -rf src && mkdir src && docker run --mount type=bind,source=`pwd`/src,target=/var/src build:latest'
mkdir artifacts/${TS}
scp ${REMOTE}:/var/src/rpi4/Build/RPi4/DEBUG_GCC5/FV/RPI_EFI.fd artifacts/${TS}/
scp ${REMOTE}:/var/src/rpi4/edk2-non-osi/Platform/RaspberryPi/RPi4/TrustedFirmware/bl31.bin artifacts/${TS}/

