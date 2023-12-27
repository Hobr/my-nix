switch:
	sudo proxychains4 nh os switch

boot:
	sudo proxychains4 nh os boot

update:
	sudo proxychains4 nix flake update

history:
	sudo nix profile history --profile /nix/var/nix/profiles/system

gc:
	sudo nix profile wipe-history --profile /nix/var/nix/profiles/system  --older-than 3d
	sudo nix store gc --debug
