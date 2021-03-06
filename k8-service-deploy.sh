#!/bin/bash

echo " Maven Build"
mvn clean install

sleep 5
clear
printf " \n\n\n****************** Build Spring boot app docker image *******************\n"
docker build -t satyak1238.azurecr.io/spring-boot-service .
docker build  -t satyak1238.azurecr.io/envoyproxy/envoy-servicemesh:latest -f envoy/Dockerfile-envoy-servicemesh .

printf " \n\n *************** Push Images to ACR ********************* \n"
az acr login --name satyak1238
docker push satyak1238.azurecr.io/envoyproxy/envoy-servicemesh:latest
docker push satyak1238.azurecr.io/spring-boot-service

sleep 5

printf " \n *************** Cleanup Existing Deployments ********************* \n\n"
 #kubectl delete service springboot-service-1
 #kubectl delete service springboot-service-2

kubectl delete deployment springboot-service-1
kubectl delete deployment springboot-service-2

sleep 5

printf "\n\n  ******************** Starting Service Mesh Deployments ******************* \n "
 kubectl apply -f k8/service1-deployment.yml
 kubectl apply -f k8/service2-deployment.yml
printf " \n ******************** Finished Service Mesh Deployments *******************"

sleep 5

