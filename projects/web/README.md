OULibraries.vagrant_infrastructure web
=========

This project provides a multi-machine Vagrant environment that closely mimics the OU Libraries AWS web environment.

It will build the following VMs:


* `ansible.vagrant.localdomain`
* `nginx.vagrant.localdomain`
* `d7.vagrant.localdomain`
* `cas.vagrant.localdomain`
* `apigate.vagrant.localdomain`
* `solr.vagrant.localdomain`

It won't build `islandora.vagrant.localdomain` and you may see errors about this host being unreachable. These can be safely ignored. 


Requirements
------------

Working vagrant_infrastructure install. A paid ngrok account.  Patience.

Configuration
-------------

Configure your details in `web/group_vars/vagrant/secrets.yml` based on the template `web/group_vars/vagrant/example-secrets.yml`. 


General Usage
------------
Once you have configured your settings, use `vagrant up` to build the environment. 

With that done, the most common starting point is to log use `vagrant
ssh d7` to log in to the confiured Drupal host where you can make use
of our `d7` scripts build and manage drupal sites.
