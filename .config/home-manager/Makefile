.PHONY: default
default: update

.PHONY: update
update:
	home-manager switch --flake .#jesse && spd-say "Done"

.PHONY: clean
clean:
	nix-collect-garbage -d