os:
	nh os boot -a .

home:
	nh home switch -a .

update:
	nix flake update
	git add flake.lock
	git commit -m "Update"

history:
	sudo nix profile history --profile /nix/var/nix/profiles/system

clean:
	nh clean all

fmt:
	nixfmt ./
