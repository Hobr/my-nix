switch:
	sudo nixos-rebuild switch --flake .#hobr-nixos --show-trace

boot:
	sudo nixos-rebuild boot --flake .#hobr-nixos --show-trace

update:
	sudo nix flake update

upgrade:
	sudo nix flake update
	sudo nixos-rebuild switch --flake .#hobr-nixos --show-trace

history:
	nix profile history --profile /nix/var/nix/profiles/system

gc:
	sudo nix profile wipe-history --profile /nix/var/nix/profiles/system  --older-than 3d
	sudo nix store gc --debug
