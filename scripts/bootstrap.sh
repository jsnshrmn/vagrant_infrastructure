#!/usr/bin/env bash

# we need git and ansible to get started
yum install -y git
yum install -y ansible

# create ansible vault secret if one doesn't exist.
stat /vagrant/vault_password.txt &>/dev/null || bash -c '< /dev/urandom tr -dc "a-zA-Z0-9~!@#$%^&*_-" | head -c${1:-254};echo;' > /vagrant/vault_password.txt

# copy hosts file provided by vagrant provisioner
cp /vagrant/hosts /etc/hosts
cp /vagrant/ssh.cfg /home/vagrant/.ssh/config
chown vagrant:vagrant /home/vagrant/.ssh/config
chmod 600 /home/vagrant/.ssh/config

# ansible complains if these files are on the windows share because permissions
#cp /vagrant/ansible.hosts /etc/ansible/hosts
cp /vagrant/ansible.cfg /etc/ansible/ansible.cfg
#chmod -x /etc/ansible/hosts

# Install default ansible roles
# Or project-specific roles if present
VAGRANT_REQUIREMENTS='/vagrant/requirements.yml'
if [ -f "/vagrant/{$1}/requirements.yml" ]; then
    VAGRANT_REQUIREMENTS='/vagrant/{$1}/requirements.yml'
fi
ansible-galaxy install -r "${VAGRANT_REQUIREMENTS}" --force

# run ansible
sudo -u vagrant bash -c "
# Keep colors intact
export PYTHONUNBUFFERED=1
export ANSIBLE_FORCE_COLOR=1
ansible-playbook /vagrant/{$1}/playbooks/vagrant.yml
"
