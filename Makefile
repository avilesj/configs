install-macos:
	ansible-playbook macos/install_macos.yaml
	ansible-playbook post_install.yaml
install-fedora:
	ansible-playbook fedora/install_fedora.yaml --ask-become-pass
	ansible-playbook post_install.yaml
configure-macos:
	ansible-playbook macos/configure_macos.yaml
	ansible-playbook configure.yaml
configure-fedora:
	ansible-playbook fedora/configure_fedora.yaml --ask-become-pass
install-fedora:
	ansible-playbook fedora/install_fedora.yaml --ask-become-pass
full-fedora: install-fedora core-install core-configure configure-fedora core-flatpak

core-flatpak:
	ansible-playbook core-flatpak.yaml --ask-become-pass

core-install:
	ansible-playbook core-install.yaml

core-configure:
	ansible-playbook core-configure.yaml
save:
	ansible-playbook save.yaml
update:
	ansible-playbook update.yaml
clean:
	ansible-playbook clean.yaml
	ansible-playbook clean-nvim.yaml
clean-nvim:
	ansible-playbook clean-nvim.yaml
