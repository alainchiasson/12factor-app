#!/bin/bash
kubectl delete pod dbinit

kubectl delete svc mysql
kubectl delete rc mysql
kubectl delete deployment mysql

kubectl delete svc app
kubectl delete rc app
kubectl delete deployment app

kubectl delete ing 12factor
