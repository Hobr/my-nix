os:
	nh os boot -a ./ -- --show-trace

home:
	nh home switch -a ./ -- --show-trace

update:
	nix flake update

history:
	sudo nix profile history --profile /nix/var/nix/profiles/system

clean:
	nh clean all

fmt:
	nixfmt ./
