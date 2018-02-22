# -*- mode: ruby -*-
# vi: set ft=ruby :

# Chamando módulo YAML
require 'yaml'

# Lendo o arquivo YAML com as configuracoes do ambiente
env = YAML.load_file('machines.yml')

Vagrant.configure("2") do |config|
  env.each do |env|
    config.vm.define env['name'] do |srv|
      srv.vm.box = "centos7"
      srv.vm.hostname = env['hostname']
      srv.vm.network 'private_network', ip: env['ipaddress']
      srv.vm.network 'forwarded_port', guest: 27017, host: env['port']
      srv.vm.provider 'virtualbox' do |v|
        v.name = env['name']
        v.memory = env['memory']
        v.cpus = env['cpus']
      end
    end
  end
end
