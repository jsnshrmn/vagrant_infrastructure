# -*- mode: ruby -*-
# vi: set ft=ruby :

##### Config

vagrant_project ="project"

##### End of Config

vagrant_user = ENV.fetch("OULIB_USER", "vagrant")
vagrant_command = ARGV[0]
vagrantfile_path = File.dirname(__FILE__)

# Vagrantfile API/syntax version. Don't touch unless you know what you're doing!
VAGRANTFILE_API_VERSION = "2"

# Recent vagrant releases have been buggy
Vagrant.require_version( "<1.8.7")  # blacklisting untested versions
Vagrant.require_version( "!=1.8.7") # broken curl
Vagrant.require_version( "!=1.8.5") # broken ssh permissions
# - vagrant 1.8.4 is known to be a good choice on MacOs and Windoes
# - vagrant 1.8.6 is known to be a good choice on Linux

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  # Default configuration for all VMs
  config.vm.box = "geerlingguy/centos7"
  config.vm.box_version = "1.1.7"
  config.ssh.forward_agent = true
  if Vagrant.has_plugin?("vagrant-cachier")
    config.cache.scope = :box
  end
  config.vm.provider :virtualbox do |v|
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
      v.cpus = 1
    end
    ansible.vm.provision "shell",
                         path: "scripts/bootstrap.sh",
                         keep_color: "True",
                         args: vagrant_project
  end
end
