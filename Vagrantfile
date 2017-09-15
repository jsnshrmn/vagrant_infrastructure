# -*- mode: ruby -*-
# vi: set ft=ruby :

##### Config

# Set the project that you would like to build
# by default, we built the trival dev project
vagrant_project ="projects/generic"

##### End of Config


# Configure Ansible for specified project
ansible_cfg =<<CFG 
[defaults]
roles_path = /vagrant/roles 
host_key_checking = False
log_path = /vagrant/ansible.log
vault_password_file = /vagrant/scripts/vaultpw.sh
inventory = /vagrant/#{vagrant_project}/inventory.py
forks = 100
[ssh_connection]
scp_if_ssh = True
CFG
open('ansible.cfg', 'w') do |f|
  f.puts ansible_cfg
end

# What am I doing?
vagrant_user = ENV.fetch("OULIB_USER", "vagrant")
vagrant_command = ARGV[0]
vagrantfile_path = File.dirname(__FILE__)

# Vagrantfile API/syntax version. Don't touch unless you know what you're doing!
VAGRANTFILE_API_VERSION = "2"

# VAGRANT COMPATIBILITY 
#
# Many recent vagrant releases have been buggy.
# - 1.9.4 is known to work on Linux, Windows, and MacOS
Vagrant.require_version( "!=1.9.3") # broken SMB sync
# - 1.9.2 might be OK.
Vagrant.require_version( "!=1.9.1") # broken network config
Vagrant.require_version( "!=1.8.7") # broken curl library
# - 1.8.6 is known to be good on Linux
Vagrant.require_version( "!=1.8.5") # broken ssh permissions
# - 1.8.4 is known to be good on MacOs and Windows

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
# Default configuration for all VMs
if Vagrant.has_plugin?("vagrant-vbguest")
  config.vm.synced_folder ".", "/vagrant", type: "virtualbox"
  config.vbguest.auto_update = false
end
config.vm.box = "geerlingguy/centos7"
config.vm.box_version = "1.1.7"
config.ssh.forward_agent = true
config.vm.provider :virtualbox do |v|
  v.cpus = 1
  v.memory = 512
  v.linked_clone = true
end

# Use a "real" user for interactive logins
if  ['ssh', 'scp'].include? vagrant_command
  # Maybe you want to set this to a real account
  config.ssh.username = vagrant_user
end


# Load and build project VMs
# Use binding.eval to make sure that we're in the right scope.
binding.eval(File.read(File.expand_path(vagrantfile_path+'/'+ vagrant_project+"/vagrant.rb")))

# Build Ansible control machine and run vagrant playbook
config.vm.define "ansible" do |ansible|
ansible.vm.hostname = "ansible.vagrant.localdomain"
ansible.vm.network "private_network", ip: "192.168.96.2", :netmask => "255.255.255.0"
    ansible.vm.provider :virtualbox do |v|
      v.memory = 256  # Keeping overhead low
    end
    ansible.vm.provision "shell",
                         path: "scripts/bootstrap.sh",
                         keep_color: "True",
                         args: vagrant_project
  end
end
