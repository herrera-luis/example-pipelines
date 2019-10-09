FROM jenkinsci/blueocean:1.18.1

USER root
RUN apk update
RUN apk add --no-cache --virtual .build-deps g++ python3-dev libffi-dev openssl-dev nano tidyhtml && \
    apk add --no-cache --update python3 && \
    pip3 install --upgrade pip setuptools
RUN pip3 install awscli --upgrade --user
COPY plugins.txt /usr/share/jenkins/ref/plugins.txt
RUN /usr/local/bin/install-plugins.sh < /usr/share/jenkins/ref/plugins.txt
