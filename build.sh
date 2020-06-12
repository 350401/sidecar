#!/bin/bash

echo " Maven Build"
mvn clean install

echo " Build Spring boot app docker image"
docker build -t satyak1238.azurecr.io/spring-boot-service .

sleep 20

echo " Build Envoy docker image"
docker build  -t satyak1238.azurecr.io/envoyproxy/envoy-dev:latest -f Dockerfile-envoy .

sleep 30
