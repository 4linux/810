#!/bin/bash

installDocker() {
  dnf config-manager --add-repo https://download.docker.com/linux/centos/docker-ce.repo
  dnf install docker-ce docker-ce-cli containerd.io libseccomp --nobest -y
  systemctl enable docker
  systemctl start docker
}

prepPromethues(){
  mkdir /etc/prometheus
  cp prometheus.yml 
}

runPrometheus() {
  docker run -dti --name prometheus -p 9090:9090 prom/prometheus
}



installDocker
runPromethus
runGrafana
