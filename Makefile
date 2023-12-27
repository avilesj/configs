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
	ansible-playbook configure_fedora.yaml --ask-become-pass
	ansible-playbook after_configure.yaml
post-install-fedora:
	ansible-playbook post_install_fedora.yaml
install-fedora-full: install-fedora configure-fedora post-install-fedora
save:
	ansible-playbook save.yaml
clean:
	ansible-playbook clean.yaml
	ansible-playbook clean-nvim.yaml
clean-nvim:
	ansible-playbook clean-nvim.yaml
