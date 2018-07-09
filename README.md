OU Libraries Vagrant Infrastructure
=========

The Vagrant Infrastructure project is very much a work in
progress. We're currently focused on collecting together the various
project environments that currently exist and are looking for patterns
that can be standardized and shared between them.

## Goals

### Cross Team Collaboration

This project is intended to provide a common development environment
shared across teams and projects to make it easier for us to work
together and support each other.

### Highly Accurate Testing

Vagrant Infrastructure makes use of the same Ansible roles that the
Ops team uses to provision systems, allowing us to have an accurate
development environments that closely duplicate the configuration of
our test and production systems.

### DevOps Documentation and Collaboration

Vagrant Infrastructure is designed to improve communication and
collaboration between the developers and the Ops team by providing a
common point of reference for the configuration and deployment of
systems,  and a working model of our production environment where
developers and the Ops team can work together to design, document, and
implement deployment of new systems.

## Current Status

This project provisions an Ansible control machine that matches our
current configuration for deploying production and then uses that
control machine to configure the set of VMs specified for that
development environment.

Currently the following development environments are available:
* [web](https://github.com/OULibraries/vagrant_infrastructure/blob/master/projects/web/README.md) - multi-VM Drupal+ dev environment.
* [islandora](https://github.com/OULibraries/vagrant_infrastructure/blob/master/projects/islandora/README.md) - single VM Islandora dev environment
* [dspace](https://github.com/OULibraries/vagrant_infrastructure/blob/master/projects/dspace/README.md) - single VM DSpace dev environment


Requirements
------------

This environment can be a little finicky. The software combo below is known to work on a recentish release of MacOS and Windows and Fedora:
* Vagrant [v1.8.6](https://releases.hashicorp.com/vagrant/1.8.6/)
* Virtualbox [v5.1.14](http://download.virtualbox.org/virtualbox/5.1.14/) and compatible Guest Additions
* base box [geerlingguy/centos7](https://atlas.hashicorp.com/geerlingguy/boxes/centos7/versions/1.1.7) v1.1.7

We've had lots of version related bugs with this stack, so the above versions should probably be considered required.

All projects create an Ansible control VM, so you don't need a working local Ansible install on the VM host. 

### Windows only notes
* This environment seems to be incompatible with the default DDPE antivirus software install, which OU Libraries Windows users may have installed.
* Use our [msys2 setup](https://github.com/OULibraries/msys2-setup) to get an okay shell environment. You'll need to run vagrant from inside msys2.
* For convenience you may which to alias the windows vagrant.exe to the vagrant command in bash. One way to do that is to add the following to ~/.bash_profile
```
# Alias vagrant bin if it exists
if [ -f "/c/HashiCorp/Vagrant/bin/vagrant.exe" ] ; then
  alias vagrant="/c/HashiCorp/Vagrant/bin/vagrant.exe"
fi
```
* For convenience you may wish to alias the ls command to ignore some uninteresting files that pollute the windows user home directory.
```
# Alias ls to ignore ntuser files
alias ls='ls -I "NTUSER.*" -I "ntuser.*"'
```
* Windows 10 users may run in to [this bug](https://github.com/mitchellh/vagrant/issues/6852) and need to [install some additional libraries](https://www.microsoft.com/en-us/download/details.aspx?id=8328) to get Vagrant working.

Installation
------------
1. Install Vagrant and VirtualBox as specified above.
1. Clone this repo to a local folder.


Configuration
-------------

1. Select your desired project and configure it to build as follows:

	  In `Vagrantfile`, specify your project
	  ```
	  -vagrantfile_project="projects/generic"
	  +vagrantfile_project="projects/web-light"
	  ```

1. **Review the `README` for your project and perform any required steps.** This will probably include at minimum adding credentials and personal settings to a `secrets.yml` file based on the `example-secrets.yml` file for that project. These files will typically live in `$project/group_vars/vagrant`. 

    If a project doesn't have both a `README` and and `example-secrets.yml`, that's a bug.    
    
1. Set the `OULIB_USER` environment variable to specify a user to use for intaractive vagrant commands (like `vagrant ssh`). In most cases, this should be your normal ssh login, and should match credentials specified when configuring the project in the previous step.

    For example, add something like the following to your `.bash_profile`.

	 ```
	 export OULIB_USER=jdoe
	 ```


Vagrant Usage
------------

The following vagrant commands are likely to see the most use:

* `vagrant up` to start your vms. The box will build itself on first startup.
* `vagrant ssh $vm` to log in to `$vm`.
* `vagrant suspend` to suspend your VM without shutting it down.
* `vagrant halt` to shut down your vms.
* `vagrant reload` bounces your vms.

Less frequently, you'll may want to reprovision to get the lastest
changes, or rebuild your VM Completely. In that case, you'll need
these commands:

* `vagrant provision` to re-run the ansible provisioners.
* `vagrant destroy` to delete the VM, in case you want to start over.

You may also find it useful (and timesaving!) to snapshot and restore your VMs with
`vagrant snapshot`. 


Vagrant Troubleshooting
-----------------------

### Network weirdness

If the guest VM gets confused about its network, can't talk to the internet, or loses it's
fileshares, it maybe be necessary to do reboot your VMs with `vagrant halt && vagrant up`
or `vagrant reload`. If Vagrant is unable to successfully issue these commands,  you may need
to use the VirtualBox GUI to halt the VM before restarting it with `vagrant up`.

### Mounted fileshares and vboxsf errors

In cases where vagrant up fails because it can't mount the vboxsf
vagrant share you can typically fix that by re-running `vagrant up`
again until it succeeds.


### Ansible "UNREACHABLE" error

If you see blocks of errors like the following chunk of "UNREACHABLE", that's probably OK. We've standardized the network configuration across all of the projects and the result is that you're probably not building all of the available machines for any particular project.
```
==> ansible: TASK [setup] *******************************************************************
==> ansible: ok: [islandora.vagrant.localdomain]
==> ansible: fatal: [nginx.vagrant.localdomain]: UNREACHABLE! => {"changed": false, "msg": "Failed to connect to the host via ssh.", "unreachable": true}
==> ansible: fatal: [d7.vagrant.localdomain]: UNREACHABLE! => {"changed": false, "msg": "Failed to connect to the host via ssh.", "unreachable": true}
==> ansible: fatal: [cas.vagrant.localdomain]: UNREACHABLE! => {"changed": false, "msg": "Failed to connect to the host via ssh.", "unreachable": true}
==> ansible: fatal: [apigate.vagrant.localdomain]: UNREACHABLE! => {"changed": false, "msg": "Failed to connect to the host via ssh.", "unreachable": true}
==> ansible: fatal: [solr.vagrant.localdomain]: UNREACHABLE! => {"changed": false, "msg": "Failed to connect to the host via ssh.", "unreachable": true}
==> ansible: ok: [ansible.vagrant.localdomain]
```
If it bugs you too much, we'd love a pull request.


Ngrok problems
-----

Most projects are configured to make use of `ngrok` to provide secure
https access.  To make use of this, you'll need a paid account at
[ngrok.com](https://ngrok.com/). See the ngrok documentation for details.

Should ngrok become confused and broken, you can probably fix this by restarting the oulib-ngrok service
on the vagrant machine running the tunnel (Generally the `nginx` reverse proxy.)

```
sudo systemctl restart oulib-ngrok
```

Manually Rebuild a Single Project VM
-------------------------

You may want to rebuild an individual Vagrant VM without reprovisioning the full project from scratch (e.g. for Ansible role development).  For example, to build a new `solr.vagrant.localdomain` VM from scratch, first destroy and recreate the existing Solr VM.
```
# From the vagrant host
$ vagrant destroy solr
$ vagrant up solr
```
Then make sure the Ansible control machine has up-to-date info about the newly built host. (Mainly, you need the newly created ssh machine key.)
```
# From the vagrant host
$ OULIB_USER=vagrant vagrant ssh ansible --command "/vagrant/scripts/fix-hosts.sh"
```
Finally,  re-run the project playbook, limiting the scope to the machine that you want to rebuild.
```
# From the vagrant host
$ OULIB_USER=vagrant vagrant ssh ansible --command "ansible-playbook /vagrant/projects/web/playbooks/vagrant.yml --limit solr.vagrant.localdomain"
```

Ad-hoc Ansible Commands
------
General purpose ad-hoc commands require one to SSH into a specific vagrant box within the prod-infrastructure.

### Example:
* Ensure development requirements are met
* User enters vagrant_infrastructure directory on their box
* User initializes boxes and enviornment
```
	user@localdomain$: vagrant up
```
* User SSH's into project specific vagrant box
```
	user@localdomain$: vagrant ssh vagrant@web.vagrant.localdomain
```
* User attempts to run an adhoc command to gather information about web server/host
```
	[vagrant@web.vagrant.localdomain]$: ansible web -m setup
```
This will result in the ad-hoc command successfully executing and host information being returned.

* Note:
A possible work around for the user in the given example is to append the contents of ```vagrant_infrastructure/hosts``` to `/etc/hosts` allowing for a direct SSH to the vagrant box from the host vagrant enviornment

TODO
------------

* Add support for the rest of our environments
* Lots and lots.

<!--  LocalWords:  ansible
 -->
