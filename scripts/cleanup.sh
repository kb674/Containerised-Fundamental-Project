#! /bin/bash

docker rm -f mysql flask-app nginx

docker rmi fundamental-project

docker network rm trick-network 
