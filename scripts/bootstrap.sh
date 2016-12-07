#!/usr/bin/env bash



# Set up vagrant user ssh keys. These need to live on the vms to have
# reasonable permissions with Windows and vboxsf
mkdir -p  "/home/vagrant/.ssh/machines"
for host in $(ls /vagrant/.vagrant/machines);
do
    [ ! -f "/vagrant/.vagrant/machines/${host}/virtualbox/private_key" ] && continue
    mkdir "/home/vagrant/.ssh/machines/${host}"
    cp -v "/vagrant/.vagrant/machines/${host}/virtualbox/private_key" "/home/vagrant/.ssh/machines/${host}"
    chmod 600 "/home/vagrant/.ssh/machines/${host}/private_key"
    chown -R vagrant:vagrant "/home/vagrant/.ssh/"
done

# Clean metadata in case of old mirrors etc
yum clean metadata

# Install git and ansible to get started
yum install -y git
yum install -y python-pip
pip install 'ansible==2.1.1'

# Create the default ansible config folder (pip install doesn't).
mkdir -pv /etc/ansible

# create ansible vault secret if one doesn't exist.
stat /vagrant/vault_password.txt &>/dev/null || bash -c '< /dev/urandom tr -dc "a-zA-Z0-9~!@#$%^&*_-" | head -c${1:-254};echo;' > /vagrant/vault_password.txt

# copy hosts file provided by vagrant provisioner
cp /vagrant/hosts /etc/hosts
cp /vagrant/ssh.cfg /home/vagrant/.ssh/config
chown vagrant:vagrant /home/vagrant/.ssh/config
chmod 600 /home/vagrant/.ssh/config

# ansible complains if this file is on the windows share because permissions
cp /vagrant/ansible.cfg /etc/ansible/ansible.cfg
chown root:wheel /etc/ansible/ansible.cfg
chmod 640 /etc/ansible/ansible.cfg

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
ansible-playbook /vagrant/${1}/playbooks/vagrant.yml
"
