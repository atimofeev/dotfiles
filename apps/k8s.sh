# kubectl
curl --location --remote-name --silent --show-error --fail "https://dl.k8s.io/release/$(curl --location --silent https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"
sudo install kubectl /usr/local/bin/kubectl
rm kubectl

# minikube
curl --location --remote-name --silent --show-error --fail https://storage.googleapis.com/minikube/releases/latest/minikube-linux-amd64
sudo install minikube-linux-amd64 /usr/local/bin/minikube
rm minikube-linux-amd64

# k9s (CLI GUI)
curl --silent --show-error --fail https://webinstall.dev/k9s | bash

# helm
curl --silent --show-error --fail https://raw.githubusercontent.com/helm/helm/main/scripts/get-helm-3 | bash
