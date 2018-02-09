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

From that point, you can use the `d7` utilities to get create an updated dev copy of the production repository Drupal site:

```
d7_sync.sh /srv/repository $repo-host-internal-name /srv/repository
d7_make.sh /srv/repository https://raw.githubusercontent.com/OULibraries/d7-ops/dev/make/repo.make
```

*Note:* You won't have a duplicate of repository content, and it would be unfeasible to sync the repository. Any dev content that is required will need to be imported or created. (With the [Islandora Sample Content Generator](https://github.com/mjordan/islandora_scg), for example)   


Author Information
------------------

OU Libraries 
