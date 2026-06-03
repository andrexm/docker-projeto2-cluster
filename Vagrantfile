# -*- mode: ruby -*-
# vi: set ft=ruby  :

base_setup = {
  "memory" => "1024",
  "cpu" => "1",
  "image" => "bento/ubuntu-22.04"
}

Vagrant.configure("2") do |config|
  config.vm.box = base_setup["image"]

  # Master configuration
  config.vm.define "master" do |master|
    master.vm.hostname = "master"
    master.vm.network "private_network", ip: "10.10.10.100"

    master.vm.provider "virtualbox" do |vb|
      vb.memory = base_setup["memory"]
      vb.cpus = base_setup["cpu"]
    end

    master.vm.provision "shell", path: "master.sh"
  end

  # Worker nodes configuration
  (1..3).each do |i|
    config.vm.define "node0#{i}" do |node|
      node.vm.hostname = "node0#{i}"
      node.vm.network "private_network", ip: "10.10.10.10#{i}"

      node.vm.provider "virtualbox" do |vb|
        vb.memory = base_setup["memory"]
        vb.cpus = base_setup["cpu"]
      end
        
      node.vm.provision "shell", path: "worker.sh"
    end
  end
end
