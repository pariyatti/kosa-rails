#!/usr/bin/env sh

echo testing network access to ansible...
ansible all -i hosts -u root -m ping

echo removing dead ssh connections from ansible...
rm -r ~/.ansible/cp
echo ...removed.

echo also check https://serverfault.com/a/940498
