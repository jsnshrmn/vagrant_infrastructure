#!/usr/bin/env python

import json

# Ansible inventory skeleton for Vagrant use
inventory = {
    'vagrant' : {
        'hosts' : [],
        'vars': {"ansible_connection": "local" } 
    }
}

# Read vagrant hosts file (/etc/hosts format) 
with open( "/vagrant/hosts", "r") as hosts:
    for line in hosts:
        inventory['vagrant']['hosts'].append( line.split()[1])

print json.dumps(inventory)

