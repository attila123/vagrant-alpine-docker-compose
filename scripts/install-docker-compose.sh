#! /bin/bash -eux

# glibc is required for docker-compose to run, otherwise it fails to run with 'No such file or directory'
# Based on https://github.com/sgerrand/alpine-pkg-glibc/
apk add ca-certificates wget
wget -q -O /etc/apk/keys/sgerrand.rsa.pub https://raw.githubusercontent.com/sgerrand/alpine-pkg-glibc/master/sgerrand.rsa.pub
GLIBC_VERSION='2.27-r0'
wget https://github.com/sgerrand/alpine-pkg-glibc/releases/download/${GLIBC_VERSION}/glibc-${GLIBC_VERSION}.apk
apk add glibc-${GLIBC_VERSION}.apk
wget https://github.com/sgerrand/alpine-pkg-glibc/releases/download/${GLIBC_VERSION}/glibc-bin-${GLIBC_VERSION}.apk
apk add glibc-bin-${GLIBC_VERSION}.apk
rm -f *.apk

# Parsing DL URI: https://github.com/wernight/docker-compose/blob/master/Dockerfile
DOCKER_COMPOSE_DL_URI=$(curl -L https://github.com/docker/compose/releases/latest | grep -Eo 'href="[^"]+docker-compose-Linux-x86_64' | sed 's/^href="//' | head -1)
# https://docs.docker.com/compose/install/#install-compose
[ -f /usr/local/bin/docker-compose ] || curl -L https://github.com/${DOCKER_COMPOSE_DL_URI} -o /usr/local/bin/docker-compose
chmod +x /usr/local/bin/docker-compose
mkdir -p /etc/bash_completion.d
DOCKER_COMPOSE_BASH_COMPLETION_DL_URI=$(echo ${DOCKER_COMPOSE_DL_URI} | sed 's/\/releases\/download//' | sed 's/docker-compose-Linux-x86_64/contrib\/completion\/bash\/docker-compose/')
curl -L https://raw.githubusercontent.com${DOCKER_COMPOSE_BASH_COMPLETION_DL_URI} -o /etc/bash_completion.d/docker-compose
