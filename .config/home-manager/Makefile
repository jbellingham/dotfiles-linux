.PHONY: default
default: update

.PHONY: update
update:
	home-manager switch --flake .#jesse

.PHONY: clean
clean:
	nix-collect-garbage -d