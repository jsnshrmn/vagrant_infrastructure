#!/usr/bin/env bash


# Copy /etc/hosts file and set up ssh keys for vagrant user
/vagrant/scripts/fix-hosts.sh

# Clean metadata in case of old mirrors etc
yum clean metadata
yum check-update

# Install git and ansible to get started
yum install -y epel-release
yum install -y git gcc openssl-devel python-devel python2-pip sshpas
pip install --upgrade setuptools
pip install --upgrade pip
pip install -r /vagrant/${1}/playbooks/web-monitoring-ansible/requirements.txt

# Create the default ansible config folder (pip install doesn't).
mkdir -pv /etc/ansible

# exit if there is not ansible vault secret.
stat /vagrant/vault_password.txt &>/dev/null || exit 1


# ansible complains if this file is on the windows share because permissions
cp /vagrant/ansible.cfg /etc/ansible/ansible.cfg
chown root:wheel /etc/ansible/ansible.cfg
chmod 644 /etc/ansible/ansible.cfg

# ansible uses the inventory path to locate group and host vars so we have to
# make sure the script is in the project folder
cp "/vagrant/scripts/inventory.py" "/vagrant/${1}"

# Install default ansible roles
# Or project-specific roles if present
VAGRANT_REQUIREMENTS='/vagrant/requirements.yml'
if [ -f "/vagrant/${1}/requirements.yml" ]; then
    VAGRANT_REQUIREMENTS="/vagrant/${1}/requirements.yml"
fi
ansible-galaxy install -r "${VAGRANT_REQUIREMENTS}" --force

# run ansible
sudo -u vagrant bash -c "
# Keep colors intact
export PYTHONUNBUFFERED=1
export ANSIBLE_FORCE_COLOR=1
ansible-playbook --user=vagrant --vault-id /vagrant/scripts/vaultpw.sh /vagrant/${1}/playbooks/vagrant.yml
"
