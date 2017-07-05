Project: Islandora
=========

Islandora dev environment. 

Requirements
------------

Working vagrant_infrastructure install. A paid ngrok account.  Patience.

Due to recent changes in Oracle's site, you'll need to manualy download `jdk-8u102-linux-x64.rpm` from the [JDK download site](http://www.oracle.com/technetwork/java/javase/downloads/java-archive-javase8-2177648.html) and copy it to `projects/islandora/downloads/` in your vagrant folder. 

Usage
-----

Configure your details in `islandora/group_vars/vagrant/secrets.yml` based on the template `islandora/group_vars/vagrant/example-secrets.yml`.

With that done, `vagrant up` should give you:

* ansible host
* islandora host with `repository` site. 


Author Information
------------------

OU Libraries 
