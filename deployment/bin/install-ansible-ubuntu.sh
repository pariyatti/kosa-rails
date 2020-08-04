sudo apt update
sudo apt install software-properties-common

sudo apt-add-repository --yes --update ppa:ansible/ansible
sudo apt-key adv --keyserver keyserver.ubuntu.com --recv-keys 93C4A3FD7BB9C367
sudo apt update

sudo apt install ansible
sudo apt install python3-argcomplete

