FROM jenkinsci/blueocean:1.18.1
ARG AWS_ACCESS_KEY_ID
ARG AWS_SECRET_ACCESS_KEY
ARG AWS_DEFAULT_REGION
ARG AWS_NAME_EKS_CLUSTER
ENV AWS_ACCESS_KEY_ID=$AWS_ACCESS_KEY_ID
ENV AWS_SECRET_ACCESS_KEY=$AWS_SECRET_ACCESS_KEY
ENV AWS_DEFAULT_REGION=$AWS_DEFAULT_REGION
ENV AWS_NAME_EKS_CLUSTER=$AWS_NAME_EKS_CLUSTER
USER root
RUN apk update && apk add --no-cache --virtual .build-deps g++ python3-dev libffi-dev openssl-dev nano tidyhtml && \
    apk add --no-cache --update python3 && \
    pip3 install --upgrade pip setuptools
RUN pip3 install awscli --upgrade
RUN wget -O /bin/hadolint https://github.com/hadolint/hadolint/releases/download/v1.16.3/hadolint-Linux-x86_64 && \
    chmod +x /bin/hadolint
RUN curl --silent --location "https://github.com/weaveworks/eksctl/releases/download/latest_release/eksctl_$(uname -s)_amd64.tar.gz" | tar xz -C /tmp
RUN mv /tmp/eksctl /usr/local/bin
RUN curl -LO https://storage.googleapis.com/kubernetes-release/release/$(curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt)/bin/linux/amd64/kubectl && \
    chmod +x ./kubectl
RUN mv ./kubectl /usr/local/bin/kubectl
RUN aws --region us-west-2 eks update-kubeconfig --name $AWS_NAME_EKS_CLUSTER
COPY plugins.txt /usr/share/jenkins/ref/plugins.txt
COPY cloudformation/aws_auth_cm.yaml .
RUN /usr/local/bin/install-plugins.sh < /usr/share/jenkins/ref/plugins.txt
