# ssw-590-final
Repo to house final paper/project work for SSW-590

## NOTES
Following https://mycloudjourney.medium.com/argocd-series-how-to-install-argocd-on-a-single-node-minikube-cluster-1d3a46aaad20:
1. Run K8s cluster using minikube
```
minikube start — memory='1985' — cpus='4'
```
2. Create argocd namespace
```
kubectl create namespace argocd
```
3. Install argocd + sealedsecrets resources
```
## Needed to use older version due to errors with repo-server
helm dependency update charts/argo-cd
helm upgrade -i --create-namespace argocd charts/argo-cd

helm dependency update charts/sealed-secrets
helm upgrade -i --create-namespace -n kube-system sealed-secrets charts/sealed-secrets
```
4. Get default admin password
```
kubectl -n argocd get secret argocd-initial-admin-secret -o jsonpath="{.data.password}" | base64 -d; echo
```
5. Port forward to UI
```
kubectl port-forward svc/argocd-server -n argocd 8080:443
```
6. Login with admin creds
```
argocd login localhost:8080
k apply -f argo/minikube/guestbook.yaml
argocd app list
```
