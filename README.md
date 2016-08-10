# vagrant_infrastructure

##  Notes

* Requires [Vagrant](https://www.vagrantup.com/downloads.html). 
* Creates an Ansible control VM, so you don't need a working Ansible install.
* Currently sets up CAS and Drupal environments

## Installation

1. Install Vagrant.
1. Clone this repo to a local folder.
1. Copy `my-vars.default.yml` to `my-vars.yml` and insert your particulars.


## Vagrant Usage 

The following vagrant commands are likely to see the most use. 

* `vagrant up` to start the vm. The box will build itself on first startup. 
* `vagrant ssh` to log in
* `vagrant halt` to shut the VM Down
* `vagrant reload` bounces the box

It maybe be neccessary to do a `halt` or `reload` if the guest VM gets confused about its network, or loses its fileshares. This most frequently happens when the host machine goes to sleep and/or moves between networks.

Less frequently, you'll may want to reprovision to get the lastest changes, or rebuild your VM Completely. In that case, you'll need these commands:
* `vagrant provision` will re-run the ansible provisioners
* `vagrant destroy` to delete the VM, in case you want to start over

## Gotchas

This thing currently expects all or nothing up and provision commands. Doesn't do useful port forwarding currently.

## TODO

* Add nginx box with port forwarding turned on.
* Add support for the rest of our environments
