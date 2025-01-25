flatpak:
	ansible-playbook flatpak.yaml --ask-become-pass

laptop:
	ansible-playbook laptop.yaml --ask-become-pass

install:
	ansible-playbook install.yaml --ask-become-pass

configure:
	ansible-playbook configure.yaml --ask-become-pass
	$(MAKE) package pkg="alacritty"

package:
	ansible-playbook package.yaml --extra-vars "pkg=$(pkg)"

save:
	ansible-playbook save.yaml --extra-vars "pkg=$(pkg)"
update:
	ansible-playbook update.yaml
