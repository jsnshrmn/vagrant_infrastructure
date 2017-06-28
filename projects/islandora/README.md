Project: Islandora
=========

Islandora dev environment. 

Requirements
------------

Working vagrant_infrastructure install. A paid ngrok account.  Patience.

Due to recent changes in Oracle's site, you'll need to manualy download `jdk-8u102-linux-x64.rpm` from the [JDK download site](http://www.oracle.com/technetwork/pt/java/javase/downloads/jdk8-downloads-2133151.html) and copy it to 'project/downloads' in your vagrant folder. 

Usage
-----

Configure your details in web/group_vars/vagrant/secrets.yml based on the template web/group_vars/vagrant/example-secrets.yml.

With that done, `vagrant up` should give you:

* ansible host
* islandora host with `repository` site. 


Author Information
------------------

OU Libraries 
