#!/bin/bash

# Create cluster prepared for an ingress controller
kind create cluster --config ./cluster.yaml

# Install ingres-nginx
kubectl apply -f https://raw.githubusercontent.com/kubernetes/ingress-nginx/master/deploy/static/provider/kind/deploy.yaml

# Build application image
docker build -t shoutbox:latest ./shoutbox

# Load image into cluster
kind load docker-image shoutbox:latest

# Wait for ingress-nginx to be ready
kubectl wait --namespace ingress-nginx \
  --for=condition=ready pod \
  --selector=app.kubernetes.io/component=controller \
  --timeout=90s

# Deploy Kubernetes resources
kubectl apply -f deployment.yaml
