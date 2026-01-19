#!/bin/bash
# ======================================================================
#          ------- Custom Functions -------                            #
#  Space for adding custom functions so each repo can customize as.    # 
#  needed.                                                             #
# ======================================================================


customFunction(){
  printInfoSection "This is a custom function that calculates 1 + 1"

  printInfo "1 + 1 = $(( 1 + 1 ))"

}

deployOpentelemetryDemo(){

  NAMESPACE="opentelemetry-demo"

  printInfoSection "Installing latest Opentelemetry Demo in NS='$NAMESPACE' from https://opentelemetry.io/docs/demo/kubernetes-deployment/"

  helm repo add open-telemetry https://open-telemetry.github.io/opentelemetry-helm-charts
  
  helm install opentelemetry-demo open-telemetry/opentelemetry-demo --namespace $NAMESPACE --create-namespace

  getNextFreeAppPort true
  PORT=$(getNextFreeAppPort)
  if [[ $? -ne 0 ]]; then
    printWarn "Application can't be deployed"
    return 1
  fi

  printInfo "Change $NAMESPACE frontend service from ClusterIP to NodePort"
  
  kubectl patch service frontend-proxy --namespace=$NAMESPACE --patch='{"spec": {"type": "NodePort"}}'

  printInfo "Exposing the $NAMESPACE frontend-proxy in NodePort $PORT"

  kubectl patch service frontend-proxy --namespace=$NAMESPACE --type='json' --patch="[{\"op\": \"replace\", \"path\": \"/spec/ports/0/nodePort\", \"value\":$PORT}]"

  printInfo "$NAMESPACE deployed succesfully and should handle request in port $PORT"
  
  printWarn "$NAMESPACE is quite heavy and might take a while to schedule all pods $PORT"

}

undeployOpentelemetryDemo(){

  printInfoSection "Uninstalling Opentelemetry Demo"

  helm uninstall opentelemetry-demo --namespace opentelemetry-demo
  
  printInfo "Deleting namespace opentelemetry-demo"

  kubectl delete namespace opentelemetry-demo
}


deployAstroshop(){

  ASTROSHOPDIR="astroshop"

  printInfoSection "Deploying Demo.Live Astroshop"
  if [[ "$ARCH" != "x86_64" ]]; then
    printWarn "This version of the Astroshop only supports AMD/x86 architectures and not ARM, exiting deployment..."
    return 1
  fi

  getNextFreeAppPort true
  PORT=$(getNextFreeAppPort)

  if [[ $? -ne 0 ]]; then
    printWarn "Application can't be deployed"
    return 1
  fi

  NAMESPACE="astroshop"

  dynatraceEvalReadSaveCredentials

  if [[ -z "${DT_INGEST_TOKEN}" || -z "${DT_OTEL_ENDPOINT}" ]]; then  
    printWarn "DT_INGEST_TOKEN and/or DT_OTEL_ENDPOINT are not setted. DT_OTEL_ENDPOINT is calculated with the function 'dynatraceEvalReadSaveCredentials' and the env var DT_ENVIRONMENT"  
  else
    printInfo "OTEL Configuration URL $DT_OTEL_ENDPOINT and Ingest Token $DT_INGEST_TOKEN"  
  fi

  kubectl apply -n $NAMESPACE -f $REPO_PATH/.devcontainer/apps/$ASTROSHOPDIR/yaml/astroshop-deployment.yaml

  kubectl -n $NAMESPACE create secret generic dt-credentials --from-literal="DT_API_TOKEN=$DT_INGEST_TOKEN" --from-literal="DT_ENDPOINT=$DT_OTEL_ENDPOINT"
  
  printInfo "Waiting for all pods of $NAMESPACE to be scheduled"
  
  printWarn "Not waiting for all pods of $NAMESPACE to be scheduled, this can take a while, type 'kubectl get pod -n $NAMESPACE --all' to see the status of them"
  
  printInfo "Change astroshop frontend service from ClusterIP to NodePort so it can be exposed"
  
  kubectl patch service frontend-proxy --namespace=$NAMESPACE --patch='{"spec": {"type": "NodePort"}}'

  printInfo "Exposing the $NAMESPACE frontend in NodePort $PORT"

  kubectl patch service frontend-proxy --namespace=$NAMESPACE --type='json' --patch="[{\"op\": \"replace\", \"path\": \"/spec/ports/0/nodePort\", \"value\":$PORT}]"

  waitAppCanHandleRequests $PORT

  PUBLIC_IP=$(curl ifconfig.me)
  printInfo "Astroshop deployed succesfully and handling request in http://$PUBLIC_IP:$PORT"


}
