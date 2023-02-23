# ssw-590-final
Repo to house final paper/project work for SSW-590

## ArgoCD

Code lives under the [argocd/](argocd/) directory.

### Prerequisites
You must have the following installed to run this demo (assuming Mac):
* git
* Docker Desktop
* minikube
* kubectl
* helm


### Getting Started
1. Navigate to `argocd/` dir
```
cd argocd/
```
1. Start a minikube cluster
```
minikube start — memory='1985' — cpus='4'
```
1. Install argocd resources + CLI
```
# install resources
helm dependency update charts/argo-cd
helm upgrade -i --create-namespace -n argocd argocd charts/argo-cd

# install CLI ==> https://argo-cd.readthedocs.io/en/stable/cli_installation/
VERSION=$(curl --silent "https://api.github.com/repos/argoproj/argo-cd/releases/latest" | grep '"tag_name"' | sed -E 's/.*"([^"]+)".*/\1/')
curl -sSL -o argocd-darwin-amd64 https://github.com/argoproj/argo-cd/releases/download/$VERSION/argocd-darwin-amd64
sudo install -m 555 argocd-darwin-amd64 /usr/local/bin/argocd
rm argocd-darwin-amd64
```
1. Get default admin password
```
kubectl -n argocd get secret argocd-initial-admin-secret -o jsonpath="{.data.password}" | base64 -d; echo
```
1. Access ArgoCD via UI or CLI
```
## UI --> Port forward and go to localhost:8080 in browser
kubectl port-forward svc/argocd-server -n argocd 8080:443

## CLI --> Login locally
argocd login localhost:8080
```
1. Create root application
```
k apply -f root-app.yaml
```
1. Watch as child apps are created!
```
argocd app list
```

## Spinnaker

### Prerequisites

### Getting Started