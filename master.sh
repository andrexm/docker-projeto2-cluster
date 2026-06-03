#!/bin/bash

# update and install docker
sudo apt update -y
sudo apt install -y apt-transport-https ca-certificates curl software-properties-common
curl -fsSL https://get.docker.com | bash
sudo usermod -aG docker vagrant

# start swarm and save worker join command
docker swarm init --advertise-addr=10.10.10.100
docker swarm join-token worker -q > /vagrant/swarm_token.txt