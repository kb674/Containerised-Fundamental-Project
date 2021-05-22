#!/bin/bash

#Create netwoork
docker network create trick-network

# Build and run database container
docker run -d -e MYSQL_DATABASE=flask-db -e MYSQL_ROOT_PASSWORD=password --name mysql --network trick-network mysql:5.7

# Build container
docker build -t fundamental-project .

# Run flask app container called 'flask-app'
docker run -d --name flask-app \
-e DATABASE_URI=mysql+pymysql://root:password@mysql/flask-db  \
-e SECRET_KEY=jjjhsdfkjsdfuuwwergsdf \
--network trick-network \
fundamental-project

# Create the tables by running create.py
docker exec -d flask-app python3 create.py

# Create nginx container
docker run -d --network trick-network --mount type=bind,source=$(pwd)/nginx/nginx.conf,target=/etc/nginx/nginx.conf -p 80:80 --name nginx nginx:alpine 
