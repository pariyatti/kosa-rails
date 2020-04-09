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

Install ansible roles from Galaxy:

```
ansible-galaxy install kevincoakley.neo4j
ansible-galaxy install ansistrano.deploy ansistrano.rollback
```

### Provision the box

#### One-Time Setup:

```
ansible-playbook -i hosts -u root setup.yml --extra-vars "neo4j_password=neo4j"
```

#### Deploy Kosa:

You will need to get the master password from someone on staff.

```
ansible-playbook -i hosts -u root kosa.yml --ask-vault-pass
```
