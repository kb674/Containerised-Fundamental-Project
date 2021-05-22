#! /bin/bash

docker rm -f mysql flask-app

docker rmi fundamental-project

docker network rm trick-network 
