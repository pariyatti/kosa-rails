# Deployment of Pariyatti Services

Deployment will use Ubuntu on a cloud server of your choice. The sandbox server is currently running on Digital Ocean and these instructions will use that as an example.

Everything you need should be accessible from the `Makefile` in this directory. If you add new functionality to the deployment scripts, please add an interface through `make`. To see what is available, run:

```
make help
```

## Create Server

### Create a Droplet on Digital Ocean.

Disable the root password and only allow SSH key access. You will need a minimum of a $10 server (to avoid `failed to fork` errors when running `apt`):

`Standard | Shared CPU | 1 vCPU | 2 GB | 25 GB | 2 TB | $10/mo`

### Install Ansible

Use your own computer as the Control Node. Locally, run the following commands which will install ansible and python (if necessary):

```
make install-ansible
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

You will need to get the master password from someone on staff. If you are on an unreliable connection, this command will often hang during `Gathering Facts`. Use `./fix-ssh-hangs.sh` to clean up your Ansible ssh sessions.

```
ansible-playbook -i hosts -u root kosa.yml --ask-vault-pass
```
