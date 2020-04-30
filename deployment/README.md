# Deployment of Pariyatti Services

Deployment will use Ubuntu on a cloud server of your choice. The sandbox server is currently running on Digital Ocean and these instructions will use that as an example.

Everything you need should be accessible from the `Makefile` in this directory. If you add new functionality to the deployment scripts, please add an interface through `make`. To see what is available, run:

```
make help
```

## Create Server

### Create a Droplet on Digital Ocean.

Disable the root password and only allow SSH key access. You will need a minimum of a $10 server (to avoid `failed to fork` errors when running `apt`):

`Standard | Shared CPU | 1 vCPU | 2 GB | 50 GB | 2 TB | $10/mo`

### Install Ansible

Use your own computer as the Control Node. Locally, run the following commands which will install ansible and python (if necessary):

```
make init
```

Test your connection:

```
make fix-ssh
```

### The deployment password

You will need to get the master password from someone on staff and save it to your local computer as `~/.kosa_password_file`.

When changing the deployment password, you will need to re-encrypt the Ansible Vaults:

```
# locate the vaults:
grep -ir "ANSIBLE_VAULT"

# for each vault you find, decrypt it. for example:
ansible localhost -e '@ansible/roles/neo4j/vars/main.yml' --ask-vault-pass -m debug -a 'var=neo4j_password'
ansible localhost -e '@ansible/roles/deploy/vars/main.yml' --ask-vault-pass -m debug -a 'var=rails_master_key'

# re-encrypt the strings and copy the contents from `!vault` into the original file:
ansible-vault encrypt_string -n neo4j_password
ansible-vault encrypt_string -n rails_master_key
```

### Provision the box

```
make all hosts=sandbox
make db-reset           # optional. this creates sample data.
```

### Deploy Kosa

```
make deploy hosts=sandbox
```

### Troubleshooting

**Hanging Connections**: If you are on an unreliable connection, `make all` will often hang during tasks involving Debian packages, Rubygems, or other long network transactions. Similarly, `make deploy` will often hang during `Gathering Facts`. Use `make fix-ssh` to clean up your Ansible ssh sessions.
