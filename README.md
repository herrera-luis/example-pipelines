## Jenkins pipeline for AWS EKS

you have to build the docker image using args that are:
* AWS_ACCESS_KEY_ID
* AWS_SECRET_ACCESS_KEY
* AWS_DEFAULT_REGION

for build the image use the next command

    sh ./setup_jenkins VALUE_OF_AWS_ACCESS_KEY_ID VALUE_OF_AWS_SECRET_ACCESS_KEY VALUE_OF_AWS_DEFAULT_REGION
        
 
