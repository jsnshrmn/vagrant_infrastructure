OULibraries vagrant_infrastructure
=========

A starting point for testing infrastructure playbooks in Vagrant.  Provisions multiple machines, including an Ansible control machine.  Then uses the Ansible machine to configure the various boxes appropriately for their roles.  

Currently includes projects that define environments for:
* OU web dev
* CAS dev
* OJS dev

Requirements
------------

This environment can be a little finicky. The software combo below is know to work on a recentish release of MacOS and Windows and Fedora:
* Vagrant [v1.8.6](https://releases.hashicorp.com/vagrant/1.8.6/)
* Virtualbox [v5.1.6](https://www.virtualbox.org/wiki/Download_Old_Builds_5_1)
* base box [geerlingguy/centos7](https://atlas.hashicorp.com/geerlingguy/boxes/centos7/versions/1.1.3) v1.1.3

We've had lots of version related bugs with this stack, so the above versions should probably be considered requried.  

This environment creates an Ansible control VM, so you don't need a working local Ansible install on the VM host.

**NOTE:** This environment seems to be incompatible with the DDPE antivirus software, which OU Libraries Windows users may have installed. 


Installation
------------

1. Install Vagrant and VirtualBox
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
      +VAGRANTFILE_PROJECT="projects/web-light"
      ```
     
      In the `ansible.cfg`, specify the path to your projects inventory
      ```
      -inventory = /vagrant/project/inventory.py
      +inventory = /vagrant/projects/web-light/inventory.py
      ```
1. Set an editor in your shell environment, eg.

      ```
      export EDITOR=vim
      ```
1. If you want to configure interactive Vagrant commands (for example, ssh) to use  your normal user account, set the `OULIB_USER` environment variable to your username and make sure that the project that you're building adds your user to all of the boxes that you'll need to login to. 

     ```
     export OULIB_USER=jdoe
     ```


Notes
------------

* This thing currently expects all or nothing up and provision commands. Doesn't do useful port forwarding currently.
* Additional configuration is required for vagrant to forward to a privileged port. It's probably easier to use `ngrok` if you need something like that. 
    
Vagrant Usage 
------------

The following vagrant commands are likely to see the most use:

* `vagrant up` to start your vms. The box will build itself on first startup.
* `vagrant ssh $vm` to log in to `$vm`
* `vagrant halt` to shut down your vms
* `vagrant reload` bounces your vms. 

Less frequently, you'll may want to reprovision to get the lastest
changes, or rebuild your VM Completely. In that case, you'll need
these commands:

* `vagrant provision` will re-run the ansible provisioners
* `vagrant destroy` to delete the VM, in case you want to start over


Vagrant Troubleshooting
-----------------------

It maybe be neccessary to do a `halt` or `reload` if the guest VM gets
confused about its network, or loses its fileshares. This most
frequently happens when the host machine goes to sleep and/or moves
between networks.

In cases where vagrant up fails because it can't mount the vboxsf vagrant share
simply run vagrant up again until it succeeds.


Ngrok Troubleshooting
---------------------

Should ngrok become confused and broken, simply restart the oulib-ngrok service
on the vagrant machine running the tunnel.
```
sudo systemctl restart oulib-ngrok
```


TODO
------------

* Add support for the rest of our environments
* Lots and lots. 
