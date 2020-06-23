#!/usr/bin/env bash


printf " \n\n\n****************** Clean all Deployments *******************\n"
kubectl delete deployments forntproxy grafana jaeger-collector jaeger-query prometheus springboot-service-1 springboot-service-2 statsd-exporter

printf " \n\n\n****************** Clean all Services *******************\n"

kubectl delete services forntproxy grafana jaeger-collector jaeger-query prometheus springboot-service-1 springboot-service-2 statsd-exporter elasticsearch zipkin

sleep 10
printf " \n\n\n****************** Completed Cleanup *******************\n"

sh k8-frontproxy-deploy.sh
sh k8-jaeger-deploy.sh
sh k8-metrics-deploy.sh
sh k8-service-deploy.sh