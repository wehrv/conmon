#!/bin/bash
git add .
git commit -m .
git push

cat <<- 'EOF' | docker build -t $(basename ${PWD}) -
FROM     golang
WORKDIR  /root/conmon
ENV      DEBIAN_FRONTEND noninteractive
RUN      git clone https://github.com/containers/conmon.git .
RUN      apt update
RUN      apt install -yq libglib2.0-dev

CMD      make ; \
         cp -v /root/app/bin/* /root/bin/.
EOF


docker run --rm -v /usr/include/linux/seccomp.h:/usr/include/linux/seccomp.h -v ${PWD}/bin:/root/bin $(basename $PWD)
