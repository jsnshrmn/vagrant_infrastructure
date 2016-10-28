OULibraries vagrant_infrastructure
=========

A starting point for testing infrastructure playbooks in Vagrant.  Provisions multiple machines, including an Ansible control machine.  Then uses the Ansible machine to configure the various boxes appropriately for their roles.  Currently provisions:
* Drupal
* CAS
* Nginx

Though there is a way to go before all of these provision nicely together, since the CAS and Nginx roles are still being written.

Requirements
------------

* Requires [Vagrant](https://www.vagrantup.com/downloads.html). 
* Creates an Ansible control VM, so you don't need a working Ansible install.

Installation
------------

1. Install Vagrant.
1. Clone this repo to a local folder.
1. Configure the project to build:


On Linux or MacOS, you can symlink your project in projects to `project`, eg.
```
# Linux or MacOS
ln -s projects/example project
```

On Windows, you will need to edit two files: `Vagrantfile` and `ansible.cfg`

In `Vagrantfile`, specify your project
```
-VAGRANTFILE_PROJECT="project"
+VAGRANTFILE_PROJECT="projects/web"
```

In the `ansible.cfg`, specify the path to your projects inventory
```
-inventory = /vagrant/project/inventory.py
+inventory = /vagrant/projects/web/inventory.py
```


1. set an editor in your shell environment, eg.

```
export EDITOR=vim
```

Notes
------------

* This thing currently expects all or nothing up and provision commands. Doesn't do useful port forwarding currently.


* If you need to Vagrant to port forward to a privleged service, you can either run vagrant as root (eg. sudo vagrant), or (on Linux hosts) you can allow the vagrant binary to bind to privileged ports, by running something like the following.

```
sudo setcap 'cap_net_bind_service=+ep' /opt/vagrant/bin/vagrant
```

Where the specified executable is the actual vagrant binary, not the wrapper script that calls it. If this turns out to be unbearably obnoxious, we may change it in the future.

* This assumes that you'll be taking care of pesky name resolution yourself. You could do that using dnsmasq, eg.
```
address=/vagrant.localdomain/127.0.0.1
```

It may be easier to skip doing this an use ngrok. 


Vagrant Usage 
------------

The following vagrant commands are likely to see the most use.

* `vagrant up` to start the vm. The box will build itself on first startup.
* `vagrant ssh` to log in
* `vagrant halt` to shut the VM Down
* `vagrant reload` bounces the box

It maybe be neccessary to do a `halt` or `reload` if the guest VM gets confused about its network, or loses its fileshares. This most frequently happens when the host machine goes to sleep and/or moves between networks.

Less frequently, you'll may want to reprovision to get the lastest changes, or rebuild your VM Completely. In that case, you'll need these commands:
* `vagrant provision` will re-run the ansible provisioners
* `vagrant destroy` to delete the VM, in case you want to start over

TODO
------------

* Add support for the rest of our environments
