# Build toolchain
```
$ sudo docker build -t build .
``` 
# Executes the build
```
$ sudo docker run -it --name buld_stuff2 --mount type=bind,source=`pwd`/src,target=/var/src build:latest
```
# Remote execution after having the docker image built
```
docker run -it --name buld_stuff2 --mount type=bind,source=`pwd`/src,target=/var/src build:latest
```
