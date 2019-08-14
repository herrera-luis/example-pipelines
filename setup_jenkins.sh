#!/bin/bash

docker build -t machine/jenkins-blueocean .
docker run -d --name=jenkins-blueocean -p 8383:8080 -p 50001:50000 -v $(pwd)/jenkins_home:/var/jenkins_home -v $(pwd):/home/DevOps --restart=always machine/jenkins-blueocean
