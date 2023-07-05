# Install k9s
docker pull quay.io/derailed/k9s

alias k9s='docker run --rm -it -v $KUBECONFIG:/root/.kube/config quay.io/derailed/k9s'
