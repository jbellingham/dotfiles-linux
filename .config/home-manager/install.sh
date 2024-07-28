#! /bin/bash

# Use Wayland in Pop OS
# sudo sed -i '' 's/WaylandEnable=false/WaylandEnable=true/g' /etc/gdm3/custom.conf
# This will log out
# systemctl restart gdm.service

curl --proto '=https' --tlsv1.2 -sSf -L https://install.determinate.systems/nix | sh -s -- install
nix-channel --add https://github.com/nix-community/home-manager/archive/master.tar.gz home-manager
nix-channel --add https://github.com/nix-community/nixGL/archive/main.tar.gz nixgl && nix-channel --update
nix-channel --update
nix run home-manager/master -- switch -b backup --flake .#"jesse"

command -v zsh | sudo tee -a /etc/shells

# Requires logging out and back in
sudo chsh -s "$(command -v zsh)" "${USER}"
