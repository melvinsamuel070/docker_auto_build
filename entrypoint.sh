#!/bin/bash

DockerfileName="Dockerfile"

if [[ -f $DockerfileName ]]
then
    echo "Dockerfile exists already"
else 
    ## file does not exist, create it
    echo "File does not exist..."
    echo "Creating it ..."
    sleep 3
    cat <<EOF > $DockerfileName
FROM nginx:alpine
WORKDIR /usr/share/nginx/html
COPY index.html .
RUN ls
RUN apk add --no-cache bash
RUN apk update && apk upgrade -y
EOF
fi  

# Ensure index.html exists before proceeding
if [[ ! -f index.html ]]; then
    echo "Error: index.html not found!"
    exit 1
fi

echo "Building the Docker image..."
docker build -t hipo -f "$DockerfileName" .

docker run -d --name hipo -p 4587:80 hipo

# Improved wait loop for better reliability
for i in {1..30}; do
    if curl -sI http://localhost:4587 | grep "200 OK"; then
        echo "✅ Container is running successfully!"
        break
    fi
    echo "⏳ Waiting for container to respond..."
    sleep 2
done

# Clean-up
docker ps 
docker stop hipo
docker rm hipo
docker ps

if docker rmi hipo:latest --force ; then
   echo "🗑️ Image deleted successfully"
else
   echo "❌ Image deletion failed"
fi

docker images
