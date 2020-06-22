#!/bin/bash

printf " \n\n *************** Create Config map ********************* \n"
kubectl delete configmap jaeger-configuration
kubectl create -f https://raw.githubusercontent.com/jaegertracing/jaeger-kubernetes/master/production-elasticsearch/configmap.yml

sleep 5
printf " \n\n *************** Create Elastic Server ********************* \n"
kubectl apply -f k8/elsaticsearch.yml

sleep 10
printf " \n\n *************** Create Jaeger Server ********************* \n"
kubectl delete deployemnts jaeger-collector
kubectl delete deployemnts jaeger-query
kubectl apply -f k8/jaeger-production-template.yml


printf " \n\n *************** Create Jaeger Server ********************* \n"
kubectl get service jaeger-query


