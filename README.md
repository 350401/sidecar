build.sh -- Build code and prepare docker image \n
k8-jaeger-deploy.sh -- deploy elastic search and jaeger in k8 Clsuter
k8-deploy.sh -- deploy Front proxy and Service mesh  in k8 Clsuter


kubectl get services

-- Front proxy URL
https://<forntproxy-external-ip>//service1/health

-- JAEGER Trace UI
https://<jaeger-query-external-ip>//service1/health