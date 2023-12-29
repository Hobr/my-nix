switch:
	nh os switch -a ./

boot:
	nh os boot -a ./

update:
	proxychains4 nix flake update

history:
	sudo nix profile history --profile /nix/var/nix/profiles/system

clean:
	sudo nix-collect-garbage -d

gc:
	sudo nix profile wipe-history --profile /nix/var/nix/profiles/system --older-than 3d
	sudo nix store gc --debug
