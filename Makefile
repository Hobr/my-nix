switch:
	sudo nixos-rebuild switch --flake .#handsonic --show-trace

boot:
	sudo nixos-rebuild boot --flake .#handsonic --show-trace

update:
	sudo nix flake update

history:
	sudo nix profile history --profile /nix/var/nix/profiles/system

gc:
	sudo nix profile wipe-history --profile /nix/var/nix/profiles/system  --older-than 3d
	sudo nix store gc --debug
