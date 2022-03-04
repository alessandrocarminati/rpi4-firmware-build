#build toolchain
```
$ sudo docker build -t build .
``` 
#execute build
```
$ sudo docker run -it --name buld_stuff2 --mount type=bind,source=`pwd`/src,target=/var/src build:latest
```
