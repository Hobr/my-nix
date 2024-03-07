system:
	nh os boot -a ./
	
home:
	nh home switch -a ./

update:
	nix flake update

history:
	sudo nix profile history --profile /nix/var/nix/profiles/system

clean:
	nh clean all