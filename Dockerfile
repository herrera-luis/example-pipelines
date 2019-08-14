FROM jenkinsci/blueocean:1.18.1

USER root 
RUN apk update
RUN apk add -y ruby-full nano tidy
RUN gem install bundler
COPY plugins.txt /usr/share/jenkins/ref/plugins.txt
RUN /usr/local/bin/install-plugins.sh < /usr/share/jenkins/ref/plugins.txt