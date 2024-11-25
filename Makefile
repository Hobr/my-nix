os:
	nh os boot -a . -- --max-jobs 4 --cores 15

home:
	nh home switch -a . -- --max-jobs 4 --cores 15

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
