install-macos:
	ansible-playbook install_macos.yaml
	ansible-playbook post_install.yaml
install-fedora:
	ansible-playbook install_fedora.yaml --ask-become-pass
	ansible-playbook post_install.yaml
configure:
	ansible-playbook configure.yaml
save:
	ansible-playbook save.yaml
