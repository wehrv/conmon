#!/bin/bash
git add .
git commit -m .
git push

cat <<- 'EOF' | docker build -t $(basename ${PWD}) -
FROM     golang
WORKDIR  /root
ENV      DEBIAN_FRONTEND noninteractive
RUN      git clone https://github.com/containers/conmon.git
RUN      git clone https://github.com/containers/podman.git
RUN      apt update
RUN      apt install -yq libglib2.0-dev libgpgme-dev libseccomp-dev libsystemd-dev runc

CMD     cd /root/conmon; make; cp -rv ./bin/* /root/bin; \
        cd /root/podman; make; cp -rv ./bin/* /root/bin/.
EOF

docker run --rm -v ${PWD}:/root/bin $(basename $PWD)