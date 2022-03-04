FROM quay.io/centos/centos:stream9-development as build

RUN yum groupinstall -y "Development Tools" && yum install -y git libuuid-devel openssl-devel acpica-tools python3;\
	mkdir /tmp/src;\
	cd /var/tmp && git clone https://github.com/tianocore/edk2.git && cd edk2 && git submodule update --init && cd .. ;\
	cd /var/tmp && git clone https://github.com/tianocore/edk2-platforms.git && cd edk2-platforms && git submodule update --init && cd .. ;\
	cd /var/tmp && git clone https://github.com/tianocore/edk2-non-osi.git  && cd edk2-non-osi && git submodule update --init && cd .. ;\
	cd /var/tmp && git clone https://github.com/ARM-software/arm-trusted-firmware.git ;\
	ln -s /usr/bin/python3 /usr/bin/python ;\
	cd /var/tmp && export WORKSPACE=$(pwd) && export PACKAGES_PATH=$PWD/edk2:$PWD/edk2-platforms:$PWD/edk2-non-osi && export PRELOADED_BL33_BASE=0x20000 && make -C edk2/BaseTools ;\
	cd /var/tmp && export WORKSPACE=$(pwd) && export PACKAGES_PATH=$PWD/edk2:$PWD/edk2-platforms:$PWD/edk2-non-osi && export PRELOADED_BL33_BASE=0x20000 &&\
		source /var/tmp/edk2/edksetup.sh && sed -i 's/^ACTIVE_PLATFORM/#ACTIVE_PLATFORM/'  /var/tmp/edk2/Conf/target.txt && sed -i 's/^TARGET_ARCH/#TARGET_ARCH/' /var/tmp/edk2/Conf/target.txt && cd /var/tmp/edk2 &&\
		build -n $(getconf _NPROCESSORS_ONLN) -t GCC5 -p /var/tmp/edk2-platforms/Platform/RaspberryPi/RPi4/RPi4.dsc

