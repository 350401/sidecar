#!/bin/bash

printf " \n\n *************** Push Images to ACR ********************* \n"
az acr login --name satyak1238
docker push satyak1238.azurecr.io/envoyproxy/envoy-dev:latest
docker push satyak1238.azurecr.io/spring-boot-service

sleep 5

printf " \n *************** Cleanup Existing Deployments ********************* \n\n"
 kubectl delete service springboot-service-1
 kubectl delete service springboot-service-2

  kubectl delete deployment springboot-service-1
  kubectl delete deployment springboot-service-2

sleep 5

printf "\n\n  ******************** Starting Fresh Deployments ******************* \n "
 kubectl apply -f spring-boot-app.yml
printf " \n ******************** Finished Deployments *******************"

sleep 20