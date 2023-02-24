# ssw-590-final
Repo to house final paper/project work for SSW-590

[[_TOC_]]

## Local Environment

1. Install prerequisites
You must have the following installed to run this demo (assuming Mac):
* git
* Docker Desktop
* minikube
* kubectl
* helm
* skaffold

2. Start a minikube cluster
```
minikube start — memory='1985' — cpus='4'
```
3. Open the minikube dashboard
```
minikube dashboard
```

## ArgoCD

Code lives under the [tools/argocd/](tools/argocd/) directory.

### Getting Started
1. Deploy ArgoCD
```
# deploy the argocd Helm chart using skaffold
skaffold --profile argocd deploy
```
2. Get default admin password
```
kubectl -n argocd get secret argocd-initial-admin-secret -o jsonpath="{.data.password}" | base64 -d; echo
```
3. Access ArgoCD via UI or CLI
```
## UI --> Port forward and go to localhost:8080 in browser
kubectl port-forward svc/argocd-server -n argocd 8080:443

## CLI --> Login locally
argocd login localhost:8080
```
4. Create root application
```
kubectl apply -f root-app.yaml
```
5. Watch as child apps are created!
```
argocd app list
```

## Spinnaker

Code lives under the [tools/spinnaker/](tools/spinnaker/) directory.

1. Deploy Spinnaker
```
# deploy the argocd Helm chart using skaffold
## NOTE: This may take some time!
skaffold --profile spinnaker deploy
```