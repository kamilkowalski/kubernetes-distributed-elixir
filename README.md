# Distributed Elixir on Kubernetes

Phoenix's PubSub comes with two main adapters - `Phoenix.PubSub.PG2` and `Phoenix.PubSub.Redis`. While the Redis adapter relies on an external source of truth to synchronize messages between Erlang nodes, the PG2 adapter leverages distributed Erlang to do that, removing the SPOFiness of a Redis instance. In order to use PG2 however, nodes need to be connected into an Erlang cluster.

Configuring PG2 becomes a bit complicated in container orchestration systems like Kubernetes, because of the rather complex network setup. This repository contains a minimal Phoenix chat application, along with the Kubernetes setup that makes it possible to run a PG2-based pubsub to power Phoenix's channels.

## How-to

First you'll need a K8s cluster - I've decided to use [Kind](https://kind.sigs.k8s.io/docs/user/quick-start/), which runs the Kubernetes cluster as containers on your local Docker. To allow for nginx-ingress to be installed, the cluster needs to be configured appropriately using the `cluster.yml` file:

```bash
kind create cluster --config ./cluster.yaml
```

Once the cluster is created, let's check that it's our current context:

```bash
kubectl config current-context # should print kind-kind
```

If all is well and we're not working with a production cluster, we can start by installing the ingress controller:

```bash
kubectl apply -f https://raw.githubusercontent.com/kubernetes/ingress-nginx/master/deploy/static/provider/kind/deploy.yaml
```

Then wait for it to be ready:

```bash
kubectl wait --namespace ingress-nginx \
  --for=condition=ready pod \
  --selector=app.kubernetes.io/component=controller \
  --timeout=90s
```

Now let's build the Docker app image:

```bash
docker build -t shoutbox:latest ./shoutbox
```

To make the image available inside the cluster without an image registry, Kind allows to load the image into the cluster:

```bash
kind load docker-image shoutbox:latest
```

Finally, we can create Kubernetes resources, including permissions for fetching pods, the application service and an ingress:

```bash
kubectl apply -f deployment.yaml
```

## Easy mode

All of the above is available as a single script - `setup.sh` (just make sure you're **not logged into a production cluster**, as the script fires `kubectl`):

```bash
./setup.sh
```

## Demo

Go to http://localhost:4000 and you should see a demo app. Open it in multiple tabs and type in messages - they should appear across tabs, even though we're running 2 pods for that service.
