# -*- mode: ruby -*-
# vi: set ft=ruby :

VAGRANTFILE_USERNAME = "vagrant"
#VAGRANTFILE_KEY_PATH = "/home/jsherman/.ssh/id_rsa"
VAGRANTFILE_COMMAND = ARGV[0]
VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  # General Vagrant VM configuration.
  config.vm.box = "geerlingguy/centos7"
  #config.ssh.insert_key = false
  #config.ssh.private_key_path = VAGRANTFILE_KEY_PATH
  config.ssh.forward_agent = true
  config.vm.network "private_network", type: "dhcp"
  config.vm.provider :virtualbox do |v|
    v.memory = 1024
    v.linked_clone = true
  end

  # write hostfile when provisioning
  if  ['up', 'provision'].include? VAGRANTFILE_COMMAND
    # Start new Ansible hosts file for ansible control machine
    File.open('ansible.hosts', 'w') do |hosts|
      hosts.puts "ansible.vagrant.dev ansible_connection=local"
      hosts.puts "[vagrant]"
    end
    # Start new hosts file for ansible control machine
    File.open('hosts', 'w') do |hosts|
      hosts.puts "127.0.0.1	localhost.localdomain localhost"
    end
    # Start new ssh.cfg file for ansible control machine
    File.open('ssh.cfg', 'w') do |hosts|
      hosts.puts "Host *.vagrant.dev"
      hosts.puts "  StrictHostKeyChecking no"
    end
  end
  # Use a "real" user for interactive logins
  if  ['ssh', 'scp'].include? VAGRANTFILE_COMMAND
    # Maybe you want to set this to a real account
    config.ssh.username = VAGRANTFILE_USERNAME
  end


  # CAS
  config.vm.define "cas" do |cas|
    cas.vm.hostname = "cas.vagrant.dev"
    cas.vm.provision "shell",
      path: "gethostinfo.sh", keep_color: "True"
  end

  # Drupal 7
  config.vm.define "d7" do |d7|
    d7.vm.hostname = "d7.vagrant.dev"
    d7.vm.provision "shell",
      path: "gethostinfo.sh", keep_color: "True"
  end

  # Nginx
  config.vm.define "nginx" do |nginx|
    nginx.vm.provider :virtualbox do |v|
      v.memory = 512
      v.linked_clone = true
    end
    nginx.vm.hostname = "nginx.vagrant.dev"
    nginx.vm.network "forwarded_port", guest:443, host:443
    nginx.vm.provision "shell",
      path: "gethostinfo.sh", keep_color: "True"
  end
  # Ansible Control
  config.vm.define "ansible" do |ansible|
    ansible.vm.provider :virtualbox do |v|
      v.memory = 512
      v.linked_clone = true
    end
    ansible.vm.hostname = "ansible.vagrant.dev"
    ansible.vm.provision "shell",
      path: "gethostinfo.sh", keep_color: "True"
    ansible.vm.provision "shell",
      path: "bootstrap.sh", keep_color: "True"
  end

end
