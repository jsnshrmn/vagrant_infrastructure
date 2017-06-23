OULibraries.vagrant_infrastructure web
=========

Multimachine Vagrant web testing environment.

Requirements
------------

Working vagrant_infrastructure install. A paid ngrok account.  Patience.

Usage
-----

Configure the following in `web/group_vars/vagrant/secrets.yml`:

* `my_user` - your shell account, should match prod account for easiest synch config
* `my_name` - your name (for git config, etc)
* `my_email` - your email
* `my_pubkey` - your public key for GitHub and site synching
* `ssh_brokers` - ssh brokers that you'll need for synching sites
* `my_ngrok_authtoken` - your ngrok token
* `my_httpd_dn_suffix` - your reserved ngrok suffix
* `my_smtp_authuser` - smtp service credentials
* `my_smtp_authpassword` - smtp service credentials
```
cas_fileauth_users:
  - username: - a cas username of your choosing
    password: - a cas password of your choosing
```

With that done, `vagrant up` should give you working d7 + cas + nginx boxes. 
