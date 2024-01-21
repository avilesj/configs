# Makefile for managing the Arch Linux Vagrant machine

# Variables
VAGRANT_BIN = vagrant

# Targets
.PHONY: up destroy

test-prepare:
	vagrant plugin install vagrant-scp
test-up:
	$(VAGRANT_BIN) up
	vagrant scp . default:/tmp

test-destroy:
	$(VAGRANT_BIN) destroy -f

install-core:
	ansible-playbook install_arch_core.yaml
install-gnome:
	ansible-playbook install_arch_gnome.yaml
