# -*- mode: ruby -*-
# vi: set ft=ruby :

# Definição de maquinas do Laboratório de MongoDB
machines = {
	"mongodb-node01" => { "ip" => "10", "memory" => "1024", "cpus" => "1" },
	"mongodb-node02" => { "ip" => "20", "memory" => "1024", "cpus" => "1" },
	"mongodb-node03" => { "ip" => "30", "memory" => "1024", "cpus" => "1" },
}

Vagrant.configure("2") do |config|
  machines.each do |name,conf|
    config.vm.define "#{name}" do |srv|
      srv.vm.box = "centos/7"
      srv.vm.hostname = "#{name}.dexter.com.br"
      srv.vm.network 'private_network', ip: "192.168.100.#{conf["ip"]}"
      srv.vm.provider 'virtualbox' do |vb|
        vb.name = "#{name}"
        vb.memory = "#{conf["memory"]}"
        vb.cpus = "#{conf["cpus"]}"
      end
    end
  end
end
