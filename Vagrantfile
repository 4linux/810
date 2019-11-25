# -*- mode: ruby -*-
# vi: set ft=ruby :

# Definição de maquinas do Laboratório de MongoDB
machines = {
	"mongos" => { "ip" => "10", "memory" => "512", "cpus" => "1" },
	"configsvr-01" => { "ip" => "11", "memory" => "512", "cpus" => "1" },
	"configsvr-02" => { "ip" => "12", "memory" => "512", "cpus" => "1" },
	"shard-01" => { "ip" => "13", "memory" => "512", "cpus" => "1" },
	"shard-02" => { "ip" => "14", "memory" => "512", "cpus" => "1" },
	"shard-03" => { "ip" => "15", "memory" => "512", "cpus" => "1" },
	"shard-04" => { "ip" => "16", "memory" => "512", "cpus" => "1" },
}

Vagrant.configure("2") do |config|
  machines.each do |name,conf|
    config.vm.define "#{name}" do |srv|
      srv.vm.box = "centos/7"
      srv.vm.hostname = "#{name}.example.com"
      srv.vm.network 'private_network', ip: "192.168.10.#{conf["ip"]}"
      srv.vm.provider 'virtualbox' do |vb|
        vb.name = "#{name}"
        vb.memory = "#{conf["memory"]}"
        vb.cpus = "#{conf["cpus"]}"
      end
    end

    config.vm.provision "shell", path: "install_and_config.sh"

  end
end
