# Optional Minikube extension

Run `minikube start`, `minikube image load deploybot-app:v1`, `kubectl apply -f k8s/`, and `minikube service deploybot-app`. Scale with `kubectl scale deployment/deploybot-app --replicas=4`; update with `kubectl set image deployment/deploybot-app app=deploybot-app:v2`.
