#!/bin/bash

echo " Maven Build"
mvn clean install

sleep 5
clear
printf " \n\n\n****************** Build Spring boot app docker image *******************\n"
docker build -t satyak1238.azurecr.io/spring-boot-service .

sleep 5
clear

printf " \n\n\n****************** Build Envoy docker image ***********************\n"
docker build  -t satyak1238.azurecr.io/envoyproxy/envoy-servicemesh:latest -f envoy/Dockerfile-envoy-servicemesh .
docker build  -t satyak1238.azurecr.io/envoyproxy/envoy-frontproxy:latest -f envoy/Dockerfile-envoy-forntproxy .
printf " \n\n\n********************* Build Step Completed . Please wait for 30Sec ***************************"

sleep 20
