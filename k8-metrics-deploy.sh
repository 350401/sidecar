#!/bin/bash


printf " \n\n *************** Cleanup Metrics Server ********************* \n"

docker build  -t satyak1238.azurecr.io/grafana/grafana:latest -f metrics/Dockerfile-grafana .
docker build  -t satyak1238.azurecr.io/prom/prometheus:latest -f metrics/Dockerfile-prometheus .
docker push satyak1238.azurecr.io/grafana/grafana:latest
docker push satyak1238.azurecr.io/prom/prometheus:latest

kubectl delete deployemnts statsd-exporter
kubectl delete service statsd-exporter

kubectl delete deployemnts prometheus
kubectl delete deployemnts grafana

#kubectl delete service prometheus
#kubectl delete service grafana



printf "\n\n  ******************** Starting prometheus-grafana Deployments ******************* \n "

kubectl apply -f k8/prometheus-grafana-deployments.yml
printf "\n\n  ******************** Completed  prometheus-grafana Deployments ******************* \n "

sleep 5



