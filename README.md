OULibraries vagrant_infrastructure
=========

This is a shared vagrant environment capable of building a number of different OU Libraries projects in Vagrant using our infrastructure playbooks. For each development project, it will provision the required machines and an Ansible control machine and then using Ansible to configure a development environment based on our production environments. 
Currently includes the following development projects:
* [web](https://github.com/OULibraries/vagrant_infrastructure/blob/master/projects/web/README.md)
* [web-light](https://github.com/OULibraries/vagrant_infrastructure/blob/master/projects/web-light/README.md)
* [islandora](https://github.com/OULibraries/vagrant_infrastructure/blob/master/projects/islandora/README.md)
* [CAS](https://github.com/OULibraries/vagrant_infrastructure/blob/master/projects/cas/README.md)
* OJS


Requirements
------------

This environment can be a little finicky. The software combo below is know to work on a recentish release of MacOS and Windows and Fedora:
* Vagrant [v1.8.6](https://releases.hashicorp.com/vagrant/1.8.6/)
* Virtualbox [v5.1.14](http://download.virtualbox.org/virtualbox/5.1.14/) and compatible Guest Additions
* base box [geerlingguy/centos7](https://atlas.hashicorp.com/geerlingguy/boxes/centos7/versions/1.1.7) v1.1.7

We've had lots of version related bugs with this stack, so the above versions should probably be considered requried.  

All projects create an Ansible control VM, so you don't need a working local Ansible install on the VM host.

** Windows only notes:**
* This environment seems to be incompatible with the default DDPE antivirus software install, which OU Libraries Windows users may have installed. 
* Use our [msys2 setup](https://github.com/OULibraries/msys2-setup) to get an okay shell environment. You'll need to run vagrant from inside msys2.
* For convenience you may which to alias the windows vagrant.exe to the vagrant command in bash. One way to do that is to add the following to ~/.bash_profile     
```
# Alias vagrant bin if it exists
if [ -f "/c/HashiCorp/Vagrant/bin/vagrant.exe" ] ; then
  alias vagrant="/c/HashiCorp/Vagrant/bin/vagrant.exe"
fi

```

Installation
------------
1. Install Vagrant and VirtualBox as specified above.
1. Clone this repo to a local folder.


Configuration
-------------

1. Select your desired project and configure it to build as follows:

      On **Linux** or **MacOS**, create a `project` symlink to specify the project that you want to build.
      ```
      # Linux or MacOS
      ln -s projects/example project
      ```
     
      On *&Windows*&, you will need to edit two files: `Vagrantfile` and `ansible.cfg`
      
      In `Vagrantfile`, specify your project
      ```
      -vagrantfile_project="project"
      +vagrantfile_project="projects/web-light"
      ```
     
      In the `ansible.cfg`, specify the path to your projects inventory
      ```
      -inventory = /vagrant/project/inventory.py
      +inventory = /vagrant/projects/web-light/inventory.py
      ```

1. Review the `README` for your project and perform any required steps. This will probably include adding credentials and personal settings to a `secrets.yml` file. If your desired project doesn't have a `README` yet, harrass it's author. 


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


Vagrant Troubleshooting
-----------------------

It maybe be neccessary to do a `halt` or `reload` if the guest VM gets
confused about its network, or loses its fileshares. This most
frequently happens when the host machine goes to sleep and/or moves
between networks.

In cases where vagrant up fails because it can't mount the vboxsf
vagrant share you can typically fix that by re-running `vagrant up`
again until it succeeds.


Ngrok Tunneling
-----

Most projects are configured to make use of `ngrok` to provide secure
https access.  To make use of this, you'll need a paid account at
[ngrok.com](https://ngrok.com/). See the ngrok documentation for details. 

Should ngrok become confused and broken, simply restart the oulib-ngrok service
on the vagrant machine running the tunnel (Generally the `nginx` reverse proxy.) 

```
sudo systemctl restart oulib-ngrok
```

TODO
------------

* Add support for the rest of our environments
* Lots and lots. 
