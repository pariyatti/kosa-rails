hosts = sandbox
password_file = ~/.kosa_password_file
export ANSIBLE_CONFIG = ansible/ansible.cfg

.PHONY: help install-ansible-ubuntu install-ansible-plugins init all update-ssh-keys update-master-key restart-passenger fix-ssh
# HELP sourced from https://gist.github.com/prwhite/8168133

# Add help text after each target name starting with '\#\#'
# A category can be added with @category
HELP_FUNC = \
    %help; \
    while(<>) { \
        if(/^([a-z0-9_-]+):.*\#\#(?:@(\w+))?\s(.*)$$/) { \
            push(@{$$help{$$2}}, [$$1, $$3]); \
        } \
    }; \
    print "usage: make [target] hosts=<sandbox>\n\n"; \
    for ( sort keys %help ) { \
        print "$$_:\n"; \
        printf("  %-20s %s\n", $$_->[0], $$_->[1]) for @{$$help{$$_}}; \
        print "\n"; \
    }

help: ##@Miscellaneous Show this help.
	@perl -e '$(HELP_FUNC)' $(MAKEFILE_LIST)

# Hidden@Setup Install ansible locally (ubuntu)
install-ansible-ubuntu:
	./bin/install-ansible-ubuntu.sh

# Hidden@Setup Install ansible plugins
install-ansible-plugins:
	ansible-galaxy install -r ansible/requirements.yml

init: | install-ansible-ubuntu install-ansible-plugins ##@Setup Install ansible and required plugins

all: ##@Setup Install (setup + deploy) kosa on hosts. Runs the all.yml playbook
	ansible-playbook --vault-password-file $(password_file) ansible/$@.yml -u root -i hosts/$(hosts)

setup: ##@Setup Setup a kosa box. Runs the setup.yml playbook
	ansible-playbook --vault-password-file $(password_file) ansible/setup.yml -u root -i hosts/$(hosts)

deploy: ##@Setup Deploy kosa. Runs the deploy.yml playbook
	ansible-playbook --vault-password-file $(password_file) ansible/deploy.yml -u root -i hosts/$(hosts)

db-reset: ##@Setup Reset kosa database. Runs the db-reset.yml playbook
	ansible-playbook --vault-password-file $(password_file) ansible/db-reset.yml -u root -i hosts/$(hosts)


update-ssh-keys: ##@Utilities Update ssh keys on boxes. Add keys to `ansible/roles/ssh/files/ssh_keys` under the appropriate environment
	ansible-playbook --vault-password-file $(password_file) ansible/setup.yml -u root -i hosts/$(hosts) --tags ssh

update-master-key: ##@Utilities Update RAILS_MASTER_KEY with app config .env file
	ansible-playbook --vault-password-file $(password_file) ansible/deploy.yml -u root -i hosts/$(hosts) --tags update-master-key

restart-passenger: ##@Utilities Restart passenger
	ansible-playbook --vault-password-file $(password_file) ansible/setup.yml -u root -i hosts/$(hosts) --tags restart-passenger

fix-ssh: ##@Utilities Fix local SSH hangs
	./bin/fix-ssh-hangs.sh
