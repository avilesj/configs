full: core-install core-configure core-flatpak

core-flatpak:
	ansible-playbook core-flatpak.yaml --ask-become-pass

core-laptop:
	ansible-playbook core-laptop.yaml --ask-become-pass

core-install:
	ansible-playbook core-install.yaml --ask-become-pass

core-configure:
	ansible-playbook core-configure.yaml --ask-become-pass

save:
	ansible-playbook save.yaml
update:
	ansible-playbook update.yaml
