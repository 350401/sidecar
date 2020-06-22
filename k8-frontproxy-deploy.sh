#!/bin/bash

printf " \n\n *************** Push Images to ACR ********************* \n"
#az acr login --name satyak1238
docker push satyak1238.azurecr.io/envoyproxy/envoy-frontproxy:latest


sleep 5

printf " \n *************** Cleanup Existing Deployments ********************* \n\n"

  kubectl delete deployment forntproxy

sleep 5

printf "\n\n  ******************** Starting Front proxy Deployments ******************* \n "
 kubectl apply -f k8/forntproxy-deployment.yml
printf " \n ******************** Finished Front proxy Deployments *******************"
sleep 5

sleep 10