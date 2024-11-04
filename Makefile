full: core-install core-configure core-flatpak

flatpak:
	ansible-playbook flatpak.yaml --ask-become-pass

laptop:
	ansible-playbook laptop.yaml --ask-become-pass

install:
	ansible-playbook install.yaml --ask-become-pass

configure:
	ansible-playbook configure.yaml --ask-become-pass

package:
	ansible-playbook package.yaml --extra-vars "package=$(pkg)"

asdf:
	ansible-playbook asdf.yaml --ask-become-pass
save:
	ansible-playbook save.yaml
update:
	ansible-playbook update.yaml
