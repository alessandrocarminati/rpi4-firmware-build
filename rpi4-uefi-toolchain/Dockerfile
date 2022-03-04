FROM quay.io/centos/centos:stream9-development as build

COPY build.sh /usr/local/bin/build.sh
RUN yum groupinstall -y "Development Tools" && yum install -y git libuuid-devel openssl-devel acpica-tools python3;\
	ln -s /usr/bin/python3 /usr/bin/python && chmod +x /usr/local/bin/build.sh
CMD ["build.sh"]
