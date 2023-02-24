#!/bin/sh

echo "Grab admin password ==>"
echo "          kubectl -n argocd get secret argocd-initial-admin-secret -o jsonpath="{.data.password}" | base64 -d"

echo "Port forwarding to the UI ==>"
echo "          kubectl port-forward svc/argocd-server -n argocd 8080:443"

echo "Login via the CLI ==>"
echo "          argocd login localhost:8080 --insecure --username admin --password <ADMIN_PASSWORD>"

echo "Create the root app ==>"
echo "          kubectl apply -f argocd/root-app.yaml"

echo "Checking ArgoCD applications ==>"
echo "          argocd app list"
