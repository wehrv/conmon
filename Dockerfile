FROM     golang
WORKDIR  /root/app
ENV      DEBIAN_FRONTEND noninteractive
RUN      git clone https://github.com/containers/conmon.git .

FROM     golang
WORKDIR  /root/app
ENV      DEBIAN_FRONTEND noninteractive
RUN      apt update
#RUN      apt install -y
COPY     --from=0 /root/app/ .
RUN      make

CMD      cp -v /root/app/bin/* /root/pkg/.
