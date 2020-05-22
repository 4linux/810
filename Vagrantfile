# -*- mode: ruby -*-
# vi: set ft=ruby :

# Definição de maquinas do Laboratório de MongoDB
machines = {
	"mongos" => { "ip" => "10", "memory" => "512", "cpus" => "1" },
	"configsvr-01" => { "ip" => "11", "memory" => "512", "cpus" => "1" },
	"configsvr-02" => { "ip" => "12", "memory" => "512", "cpus" => "1" },
	"sh0-01" => { "ip" => "13", "memory" => "512", "cpus" => "1" },
	"sh0-02" => { "ip" => "14", "memory" => "512", "cpus" => "1" },
	"sh1-01" => { "ip" => "15", "memory" => "512", "cpus" => "1" },
	"sh1-02" => { "ip" => "16", "memory" => "512", "cpus" => "1" },
	"prometheus" => { "ip" => "254", "memory" => "512", "cpus" => "1" },
}

Vagrant.configure("2") do |config|
  machines.each do |name,conf|
    config.vm.define "#{name}" do |srv|
      srv.vm.box = "centos/7"
      srv.vm.hostname = "#{name}.example.com"
      srv.vm.network 'private_network', ip: "192.168.100.#{conf["ip"]}"
      srv.vm.provider 'virtualbox' do |vb|
        vb.name = "#{name}"
        vb.memory = "#{conf["memory"]}"
        vb.cpus = "#{conf["cpus"]}"
      end
      if name == 'prometheus'
        config.vm.provision "ansible" do |ansible|
          ansible.limit = "all"
          ansible.playbook = "playbook.yml"
        end
      end
    end
  end
  


end
