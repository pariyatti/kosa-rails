# Deployment of Pariyatti Services

Deployment will use Ubuntu on a cloud server of your choice. The sandbox server is currently running on Digital Ocean and these instructions will use that as an example.

## Create Server

### Create a Droplet on Digital Ocean.

Disable the root password and only allow SSH key access. You will need a minimum of a $10 server (to avoid `failed to fork` errors when running `apt`):

`Standard | Shared CPU | 1 vCPU | 2 GB | 25 GB | 2 TB | $10/mo`


### Install Ansible

Use your own computer as the Control Node. Locally, run the following commands which will install ansible and python (if necessary):

```
sudo apt update
sudo apt install software-properties-common
sudo apt-add-repository --yes --update ppa:ansible/ansible
sudo apt install ansible
sudo apt install python-argcomplete
```

Test your connection:

```
ansible all -i hosts -u root -m ping
```

### Provision the box

TODO: Large packages like neo4j, rbenv, passenger, and the kosa deployment should be carved out into their own roles and called from a central playbook.

Base packages:

```
ansible-playbook -i hosts -u root provision.yml
```

Neo4j:

Reading the neo4j ansible source code is helpful if something goes wrong: https://github.com/kevincoakley/ansible-role-neo4j

```
ansible-galaxy install kevincoakley.neo4j
ansible-playbook -i hosts -u root neo4j.yml --extra-vars "neo4j_password=$SECRET"
```

Ruby:

```
ansible-playbook -i hosts -u root ruby.yml
ansible-galaxy install geerlingguy.passenger
ansible-playbook -i hosts -u root passenger.yml
```

Kosa:

```
ansible-galaxy install ansistrano.deploy ansistrano.rollback
# you will need to get the master password from someone on staff:
ansible-playbook -i hosts -u root kosa.yml --ask-vault-pass
```
