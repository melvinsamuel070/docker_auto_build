#!/bin/bash

DockerfileName="Dockerfile"

if [[ -f $DockerfileName ]]
then
    echo "Dockerfile exists already"
    echo "FROM nginx:alpine" > $DockerfileName
    
else 
    ## file does not exist, create it
    echo "File does not exist..."
    echo "Creating it ..."
    sleep 3
    touch $DockerfileName
    echo "$DockerfileName file created ..."
    
    echo "FROM nginx:alpine" >> $DockerfileName 
    echo "WORKDIR /usr/share/nginx/html" >> $DockerfileName 
    echo "COPY index.html ." >> $DockerfileName 
    echo "RUN ls" >> $DockerfileName 
    echo "RUN apt update -y" >> $DockerfileName  
    echo "RUN apt upgrade -y" >> $DockerfileName 

    echo "docker build -t hipo -f $DockerfileName ."
    docker build -t hipo -f "$DockerfileName" .
    sleep 10
    docker run -d --name hipo -p 4587:80 hipo
fi  

sleep 5
if curl -sI http://localhost:4587 | grep "200 OK"; then
    echo "Success"
else
    echo "Failed"  
fi

docker ps 
docker stop hipo
docker rm hipo
docker ps

if docker rmi hipo:latest --force ; then
   echo "Image deleted"
else
   echo "Image not deleted"
fi

docker images
