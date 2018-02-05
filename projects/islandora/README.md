Project: Islandora
=========

Islandora dev environment. 

Requirements
------------

Working vagrant_infrastructure install. A paid ngrok account.  Patience.

### NOTE
Due to recent changes in Oracle's site, you will need to register with Oracle and manualy download `jdk-8u102-linux-x64.rpm` from the [JDK download site](http://www.oracle.com/technetwork/java/javase/downloads/java-archive-javase8-2177648.html) and copy it to `projects/islandora/downloads/` in your vagrant folder.  

Usage
-----

Configure your details in `islandora/group_vars/vagrant/secrets.yml` based on the template `islandora/group_vars/vagrant/example-secrets.yml`.

With that done, `vagrant up` should give you:

* ansible host
* islandora host with a basic `repository` site. 

From that point, you can use the `d7` utilities to get an update-to-date copy of the production repository site.  

Author Information
------------------

OU Libraries 
