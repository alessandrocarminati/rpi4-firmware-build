#!/bin/sh
set -euxo pipefail
mkdir /var/src/rpi4 && cd /var/src/rpi4
git clone https://github.com/tianocore/edk2.git && cd edk2 && git submodule update --init && cd ..
git clone https://github.com/tianocore/edk2-platforms.git && cd edk2-platforms && git submodule update --init && cd ..
git clone https://github.com/tianocore/edk2-non-osi.git  && cd edk2-non-osi && git submodule update --init && cd ..
git clone https://github.com/ARM-software/arm-trusted-firmware.git
export WORKSPACE=$(pwd) && export PACKAGES_PATH=$PWD/edk2:$PWD/edk2-platforms:$PWD/edk2-non-osi && export PRELOADED_BL33_BASE=0x20000
make -C edk2/BaseTools
source /var/tmp/edk2/edksetup.sh
sed -i 's/^ACTIVE_PLATFORM/#ACTIVE_PLATFORM/' /var/tmp/edk2/Conf/target.txt && sed -i 's/^TARGET_ARCH/#TARGET_ARCH/' /var/tmp/edk2/Conf/target.txt &&
cd /var/src/rpi4/edk2 && build -n $(getconf _NPROCESSORS_ONLN) -t GCC5 -p /var/tmp/edk2-platforms/Platform/RaspberryPi/RPi4/RPi4.dsc
