# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure(2) do |config|
  config.vm.box = 'ubuntu/trusty64'
  config.vm.network "forwarded_port", guest: 80, host: 8080
  config.vm.network "forwarded_port", guest: 3000, host: 8081
  config.vm.provider "virtualbox" do |v|
    v.memory = 2048
  end
  config.vm.provision 'chef_zero' do |chef|
    chef.add_recipe 'test::default'
  end
end
