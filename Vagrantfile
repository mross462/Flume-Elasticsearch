# -*- mode: ruby -*-
# vi: set ft=ruby :

n = '123.123.123'

#   Simple Architecture Diagram
#   _________________               _________________
#   |123.123.123.101|               |123.123.123.100|               -----------
#   | Worker        | 123.123.123.x | ES            | :80 to :8080  |         |
#   | -Flume        |===============| -Elasticsearch|===============| Macbook |
#   | -Apache       |  Host Only    | -Kibana       |               |         |
#   -----------------               -----------------                --------- 


Vagrant.configure("2") do |config|
  config.vm.box = "precise64"
  config.vm.box_url = "http://cloud-images.ubuntu.com/vagrant/precise/current/precise-server-cloudimg-amd64-vagrant-disk1.box"

  #Update the repo and apply all latest upgrades
  config.vm.provision :shell, :inline => "apt-get -y update"

  #Elasticsearch Node
  config.vm.define "es" do |es|
    es.vm.network :forwarded_port, guest: 80, host: 8080
    es.vm.network :forwarded_port, guest: 9200, host: 9200
    es.vm.network :private_network, ip: n + ".100"
    es.vm.provision :shell, :path => "es_setup.sh"
  end

  #Worker Node w/ apache and flume connected to elasticsearch
  config.vm.define "worker" do |worker|
    worker.vm.network "public_network", :bridge => 'en0: Ethernet'
    worker.vm.network :forwarded_port, guest: 80, host: 8081
    worker.vm.network :private_network, ip: n + ".101"
    worker.vm.provision :shell, :path => "worker_setup.sh"
  end

  config.vm.provider :virtualbox do |vb|
     vb.customize ["modifyvm", :id,
                   "--memory", "2048",
                   "--cpus", 2,
                   "--natdnshostresolver1", "on",
                   "--natdnsproxy1", "on"
                  ]
  end
end
