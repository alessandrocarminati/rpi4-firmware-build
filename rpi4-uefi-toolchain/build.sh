#!/bin/bash
SRC_HOME=/var/src/rpi4
set -eo pipefail
mkdir ${SRC_HOME} && cd ${SRC_HOME}
git clone https://github.com/tianocore/edk2.git && cd edk2 && git submodule update --init && cd ..
git clone https://github.com/tianocore/edk2-platforms.git && cd edk2-platforms && git submodule update --init && cd ..
git clone https://github.com/tianocore/edk2-non-osi.git  && cd edk2-non-osi && git submodule update --init && cd ..
git clone https://github.com/ARM-software/arm-trusted-firmware.git
export WORKSPACE=${SRC_HOME} && export PACKAGES_PATH=${SRC_HOME}/edk2:${SRC_HOME}/edk2-platforms:${SRC_HOME}/edk2-non-osi && export PRELOADED_BL33_BASE=0x20000
make -C ${SRC_HOME}/edk2/BaseTools
echo "+++++++++++++++++++++++++++++++++"
cd ${SRC_HOME}/edk2
. ./edksetup.sh
sed -i 's/^ACTIVE_PLATFORM/#ACTIVE_PLATFORM/' ${SRC_HOME}/edk2/Conf/target.txt && sed -i 's/^TARGET_ARCH/#TARGET_ARCH/' ${SRC_HOME}/edk2/Conf/target.txt &&
cd ${SRC_HOME}/edk2 && build -n $(getconf _NPROCESSORS_ONLN) -t GCC5 -p ${SRC_HOME}/edk2-platforms/Platform/RaspberryPi/RPi4/RPi4.dsc
