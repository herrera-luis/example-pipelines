#!/bin/bash

AWS_ACCESS_KEY_ID=$1
AWS_SECRET_ACCESS_KEY=$2
AWS_DEFAULT_REGION=$3
AWS_NAME_EKS_CLUSTER=$4

if [ -d $(pwd)/jenkins_home ]
then
    echo "Directory jenkins_home already exists."
else
    echo "Creating the directory jenkins_home."
    mkdir $(pwd)/jenkins_home
    chmod -R 777 $(pwd)/jenkins_home
fi

docker build --build-arg AWS_ACCESS_KEY_ID=$AWS_ACCESS_KEY_ID --build-arg AWS_SECRET_ACCESS_KEY=$AWS_SECRET_ACCESS_KEY --build-arg AWS_DEFAULT_REGION=$AWS_DEFAULT_REGION --build-arg AWS_NAME_EKS_CLUSTER=$AWS_NAME_EKS_CLUSTER -t machine/jenkins-blueocean .
docker run -d --name=jenkins-blueocean --restart=always -p 8383:8080 -p 50000:50000 -v $(pwd)/jenkins_home:/var/jenkins_home -v $(pwd):/home/DevOps -v /var/run/docker.sock:/var/run/docker.sock  machine/jenkins-blueocean
echo "Open jenkins on your browser http://localhost:8383"
