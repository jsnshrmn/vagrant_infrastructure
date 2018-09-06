# -*- mode: ruby -*-
# vi: set ft=ruby :

##### Config

# Set the project that you would like to build
# by default, we built the trival dev project
vagrant_project ="projects/webmonitoring"

##### End of Config

# What am I doing?
vagrant_user = ENV.fetch("OULIB_USER", "vagrant")
vagrant_command = ARGV[0]
vagrantfile_path = File.dirname(__FILE__)

# Configure Ansible for specified project
ansible_cfg =<<CFG 
[defaults]
roles_path = /vagrant/roles 
host_key_checking = False
log_path = /vagrant/ansible.log
vault_password_file = /vagrant/scripts/vaultpw.sh
inventory = /vagrant/#{vagrant_project}/inventory.py
forks = 100
timeout = 30
[ssh_connection]
scp_if_ssh = True
CFG
open(vagrantfile_path+'/ansible.cfg', 'w') do |f|
  f.puts ansible_cfg
end

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
config.vm.synced_folder ".", "/vagrant"
config.ssh.forward_agent = true
#config.ssh.password = "vagrant"

config.vm.provider "docker" do |d|
  d.build_dir = "."
  d.has_ssh = true
  d.create_args = ["--privileged", "--cap-add", "SYS_ADMIN", "-v", "/run", "-v", "/tmp", "-v", "/sys/fs/cgroup:/sys/fs/cgroup:ro"]
end

# Use a "real" user for interactive logins
if  ['ssh', 'scp'].include? vagrant_command
  # Maybe you want to set this to a real account
  config.ssh.username = vagrant_user
end

# Load and build project VMs
# Use binding.eval to make sure that we're in the right scope.
binding.eval(File.read(File.expand_path(vagrantfile_path+'/'+ vagrant_project+"/vagrant.rb")))

# If we're doing anything that provisions or reprovisions machines, we
# need to start new versions of the config files that need to know
# about our VMs.
if  ['up', 'reload', 'provision'].include? vagrant_command
  # /etc/hosts file for control machine
  File.open(vagrantfile_path+'/hosts', 'w') do |hosts|
    hosts.puts "127.0.0.1	localhost.localdomain localhost"
  end
  # ~/.ssh/config for vagrant user on control machine
  File.open(vagrantfile_path+'/ssh.cfg', 'w') do |hosts|
    hosts.puts "Host *.vagrant.localdomain"
    hosts.puts "  StrictHostKeyChecking no"
  end
end

# All VMs should report in so we can configure them with ansible.
# Docker is fast enough that we may be executing before vagrant share is up.
# Thus the sleep block.
config.vm.provision "shell",
    inline: "while [ ! -f /vagrant/scripts/gethostinfo.sh ]; do sleep 1; done; \
        sudo /vagrant/scripts/gethostinfo.sh",
    keep_color: "True",
    run: "always"

# Ensure systemd is running on all containers.
config.vm.provision "shell",
    inline: "sudo /root/systemd.sh",
    keep_color: "True",
    run: "always"

# Build Ansible control machine and run vagrant playbook
config.vm.define "ansible" do |ansible|
    ansible.vm.hostname = "ansible.vagrant.localdomain"
    ansible.vm.network "private_network", ip: "192.168.96.2", :netmask => "255.255.255.0"
    ansible.vm.provision "shell",
    inline: "sudo /vagrant/scripts/bootstrap.sh #{vagrant_project}",
        keep_color: "True"
  end
end
