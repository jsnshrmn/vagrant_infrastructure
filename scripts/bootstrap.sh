#!/usr/bin/env bash


# Copy /etc/hosts file and set up ssh keys for vagrant user
/vagrant/scripts/fix-hosts.sh

# Clean metadata in case of old mirrors etc
yum clean metadata
yum check-update

# Install git and ansible to get started
yum install -y epel-release
yum install -y git gcc openssl-devel python-devel python2-pip sshpass
pip install 'ansible~=2.5.0'

# Create the default ansible config folder (pip install doesn't).
mkdir -pv /etc/ansible

# create ansible vault secret if one doesn't exist.
stat /vagrant/vault_password.txt &>/dev/null || bash -c '< /dev/urandom tr -dc "a-zA-Z0-9~!@#$%^&*_-" | head -c${1:-254};echo;' > /vagrant/vault_password.txt


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
ansible-playbook --user=vagrant /vagrant/${1}/playbooks/vagrant.yml
"
