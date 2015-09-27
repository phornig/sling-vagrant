# encoding: UTF-8
# -*- mode: ruby -*-
# vi: set ft=ruby :

require 'rbconfig'
is_windows = (RbConfig::CONFIG['host_os'] =~ /mswin|mingw|cygwin/)
is_nix = (RUBY_PLATFORM =~ /linux/ or RUBY_PLATFORM =~ /darwin/)

box       = "pp_centos_7_0_vbox"
box_url   = "https://basebox.pixelpark.com/pp_centos_7_0_vbox.box"

nodes = [
  { :hostname => "sling.local", :ip => "192.168.18.64", :ram => 2096},
]

Vagrant.configure("2") do |config|
  nodes.each do |node|
    config.vm.define node[:hostname] do |node_config|
      node_config.vm.box = box
      node_config.vm.box_url = box_url

      node_config.vbguest.auto_update = false

      node_config.vm.hostname = node[:hostname]
      node_config.vm.network "private_network", ip: node[:ip]

      if (is_nix)
        node_config.vm.synced_folder "./share", "/home/vagrant/share", :nfs => true
      end

      node_config.vm.synced_folder "./puppet/hieradata", "/tmp/vagrant-puppet/hieradata", :owner=> 'vagrant', :group=>'vagrant'

      node_config.vm.provider :virtualbox do |v|
        memory = node[:ram] ? node[:ram] : 512
        v.customize ["modifyvm", :id, "--name", node[:hostname] + "_" + Time.now.strftime("%s")]
        v.customize ["modifyvm", :id, "--memory", memory.to_s]
        v.customize ["modifyvm", :id, "--natdnshostresolver1", "on"]
        v.customize ["modifyvm", :id, "--natdnsproxy1", "on"]
      end

      node_config.vm.provision :puppet do |puppet|
        puppet.manifests_path = "./vagrant"
        puppet.manifest_file = "epel.pp"
        puppet.module_path = "./vagrant/modules"
        puppet.options = "--verbose --trace --summarize --environment=local"
        puppet.hiera_config_path = "./puppet/hiera.yaml"
        puppet.working_directory = "/tmp/vagrant-puppet/hieradata"
      end

      node_config.vm.provision :puppet do |puppet|
        puppet.manifests_path = "./puppet/classes/manifests"
        puppet.manifest_file = "site.pp"
        puppet.module_path = "./puppet/classes/modules"
        puppet.options = "--verbose --trace --summarize --environment=local"
        puppet.hiera_config_path = "./puppet/hiera.yaml"
        puppet.working_directory = "/tmp/vagrant-puppet/hieradata"
      end

      if (is_windows)
        node_config.vm.provision :puppet do |puppet|
          puppet.manifests_path = "./vagrant"
          puppet.manifest_file = "samba.pp"
          puppet.module_path = "./vagrant/modules"
          puppet.options = "--verbose --trace --summarize --environment=local"
          puppet.hiera_config_path = "./puppet/hiera.yaml"
          puppet.working_directory = "/tmp/vagrant-puppet/hieradata"
        end
      end
    end
  end
end
