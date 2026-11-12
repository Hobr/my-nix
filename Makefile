os:
	nh os boot -a . -- --max-jobs 2

home:
	nh home switch -a . -- --max-jobs 2

update:
	nix flake update --access-tokens "github.com=$$(gh auth token)"
	git add flake.lock
	git commit -m "Update"

history:
	sudo nix profile history --profile /nix/var/nix/profiles/system

clean:
	nh clean all

fmt:
	nixfmt ./
