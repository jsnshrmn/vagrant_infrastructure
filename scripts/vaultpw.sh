#!/bin/bash

VAULT_PW="/vagrant/vault_password.txt"
[ -f "$VAULT_PW" ] || exit 0

cat /vagrant/vault_password.txt
