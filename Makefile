home:
	nh home switch -a ./

sys:
	nh os boot -a ./

update:
	nix flake update

history:
	sudo nix profile history --profile /nix/var/nix/profiles/system

clean:
	nh clean all
