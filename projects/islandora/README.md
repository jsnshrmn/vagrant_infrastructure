Project: web-light
=========

Abbreviated copy of web infrastructure, for when you just need to do some Drupal dev. 

Requirements
------------

Working vagrant_infrastructure install. A paid ngrok account.  Patience.

Usage
-----

Configure the following in `web-light/group_vars/vagrant/secrets.yml`:

* `my_user` - your shell account, should match prod account for easiest synch config 
* `my_name` - your name (for git config, etc)
* `my_email` - your email
* `my_pubkey` - your public key for GitHub and site synching
* `ssh_brokers` - ssh brokers that you'll need for synching sites
* `my_ngrok_authtoken` - your ngrok token 
* `my_httpd_dn_suffix` - your reserved ngrok suffix
* `my_smtp_authuser` - smtp service credentials
* `my_smtp_authpassword` - smtp service credentials


With that done, `vagrant up` should give you a working d7 box with ngrok forwarding for sites, but won't set up any sites.


Author Information
------------------

OU Libraries 
