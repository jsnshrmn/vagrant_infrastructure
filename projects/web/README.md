OULibraries.vagrant_infrastructure web
=========

Multimachine Vagrant web testing environment.

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
```
cas_fileauth_users:
  - username: - a cas username of your choosing
    password: - a cas password of your choosing
```

With that done, `vagrant up` should give you working d7 + cas + nginx boxes.

You'll need to d7_init a site and configure it to work with CAS.

An under-annoted example of configuring a drupal site to use cas.


```
sudo yum -y install php-pear-CAS
d7_init.sh /srv/test
sudo -u apache drush -y pm-enable cas cas_roles cas_attributes -r /srv/test/drupal
sudo -u apache drush -y uli -r /srv/test/drupal

https://test.d7.ngrokhostname.example.com/admin/config/people/cas
library directory: empty
hostname: cas.ngrokhostname.example.com
login form: make cas default


user accounts: users cannot change email/pw

redirection: check once per session

destinations:
change pw url:
https://example.com/Account/ForgotPassword
register url:
https://example.com/Account/NewAccountSetup

# Only set this if something is broken and you're totally stuck. Never turn this on in production.  Turn it off when you don't need it.
cas debugging file: ../cas.log


cas_attributes
match every time
email:
[cas:attribute:email:first]

cas_roles
match every time
attribute:
[cas:attribute:membership]

example-role
/^CN=Example-LDAP-Parent-Group-ofwhich-User-is-a-member.*$/

Menu:
https://test.d7.ngrokhostname.example.com/admin/structure/menu/manage/user-menu

Disable "Log out" menu item.  Create a new "Log out" menu item with the following path:
caslogout
```


Author Information
------------------

Jason Sherman
