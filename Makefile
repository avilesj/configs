install-macos:
	ansible-playbook install_macos.yaml
	ansible-playbook post_install.yaml
install-fedora:
	ansible-playbook install_fedora.yaml --ask-become-pass
	ansible-playbook post_install.yaml
configure-macos:
	ansible-playbook configure_macos.yaml
	ansible-playbook after_configure.yaml
configure-fedora:
	ansible-playbook configure_fedora.yaml
	ansible-playbook after_configure.yaml
save:
	ansible-playbook save.yaml
