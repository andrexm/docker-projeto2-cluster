#!/bin/bash

# update system and install docker
sudo apt update -y
sudo apt install -y apt-transport-https ca-certificates curl software-properties-common
curl -fsSL https://get.docker.com | bash
sudo usermod -aG docker vagrant

# whait until the swarm token file is created by the master node
while [ ! -f /vagrant/swarm_token.txt ]
do
  sleep 2
done

# read the swarm token and join the swarm
TOKEN=$(cat /vagrant/swarm_token.txt)
sudo docker swarm join --token $TOKEN 10.10.10.10:2377